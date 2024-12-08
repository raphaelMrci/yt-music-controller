on run argv
    -- Get the first argument passed to the script
    if (count of argv) > 0 then
        set inputURL to item 1 of argv
    else
        error "No URL provided."
    end if

    -- Get the current script's directory and construct the relative path to open_arc.applescript
    set currentScriptPath to POSIX path of (path to me)
    set currentScriptDirectory to do shell script "dirname " & quoted form of currentScriptPath
    set openArcScriptPath to currentScriptDirectory & "/open_arc.applescript"

    log "Calling open_arc.applescript at path: " & openArcScriptPath

    -- Run open_arc.applescript and handle potential errors
    try
        do shell script "osascript " & quoted form of openArcScriptPath
        log "open_arc.applescript executed successfully."
    on error errMsg
        log "Failed to execute open_arc.applescript: " & errMsg
        error "Stopping script as Arc could not be opened."
    end try

    -- Check if Arc is running before proceeding
    tell application "System Events"
        set arcIsRunning to (name of application processes) contains "Arc"
    end tell

    if not arcIsRunning then
        log "Arc is not running. Stopping script."
        error "Arc is not running. Exiting script."
    end if

    -- Open or switch to the playlist URL in Arc
    tell application "Arc"
        set ytMusicTab to missing value

        -- Search for the YouTube Music tab with the same URL
        log "Searching for the YouTube Music tab with the playlist URL..."
        repeat with w in every window
            repeat with t in every tab of w
                if (URL of t contains inputURL) then
                    set ytMusicTab to t
                    log "Found the YouTube Music tab with the playlist URL."
                    exit repeat
                end if
            end repeat
            if ytMusicTab is not missing value then exit repeat
        end repeat

        -- Open the playlist URL in a new tab if not found
        if ytMusicTab is not missing value then
            tell ytMusicTab to select
            log "Selected the existing YouTube Music tab."
        else
            log "YouTube Music tab not found. Opening a new tab with the playlist URL..."
            tell front window to make new tab with properties {URL:inputURL}
            set ytMusicTab to active tab of front window
            log "New YouTube Music tab opened with the playlist URL."
        end if

        -- Wait for the tab to load and ensure the play button is interactable
        log "Waiting for the play button to appear and become interactable..."
        tell ytMusicTab
            set timeoutCounter to 0
            repeat
                try
                    -- Check for the play button's existence and visibility
                    set playButtonExists to execute javascript "
                        (function() {
                            const playButton = document.querySelector('ytmusic-play-button-renderer');
                            return playButton && window.getComputedStyle(playButton).visibility === 'visible' && playButton.offsetParent !== null;
                        })();
                    "
                    if playButtonExists as boolean then
                        log "Play button is ready and interactable."
                        exit repeat
                    end if
                on error
                    log "JavaScript execution failed during play button check. Retrying..."
                end try
                delay 0.5 -- Short wait for retry loop
                set timeoutCounter to timeoutCounter + 1
                log "Play button check: " & (timeoutCounter * 0.5) & " seconds elapsed..."
                if timeoutCounter > 40 then -- 20 seconds timeout
                    log "Play button did not become available within timeout period."
                    error "Play button did not become available within timeout period."
                end if
            end repeat

            -- Click the play button within the correct container
            log "Attempting to click the correct play button..."
            execute javascript "
                (function() {
                    const container = document.querySelector('#action-buttons');
                    if (container) {
                        const playButton = container.querySelector('ytmusic-play-button-renderer');
                        if (playButton && playButton.getAttribute('state') !== 'playing') {
                            console.log('Clicking the correct play button...');
                            playButton.click();
                        } else {
                            console.log('Music is already playing or the play button is not found.');
                        }
                    } else {
                        console.log('Action-buttons container not found.');
                    }
                })();
            "
            log "Correct play button clicked or music is already playing."
        end tell

        log "Script execution completed."
    end tell
end run
