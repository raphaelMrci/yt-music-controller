-- Get the current script's directory and construct the relative path to open_arc.applescript
set currentScriptPath to POSIX path of (path to me)
set currentScriptDirectory to POSIX path of ((POSIX file currentScriptPath as alias) & "::") -- Extract directory
set openArcScriptPath to currentScriptDirectory & "open_arc.applescript"

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

-- Proceed with liked_random.applescript logic
tell application "Arc"
    set ytMusicTab to missing value

    -- Search for the YouTube Music tab
    log "Searching for the YouTube Music tab..."
    repeat with w in every window
        repeat with t in every tab of w
            if (URL of t contains "music.youtube.com") then
                set ytMusicTab to t
                log "Found YouTube Music tab."
                exit repeat
            end if
        end repeat
        if ytMusicTab is not missing value then exit repeat
    end repeat

    -- Open a new tab if not found
    if ytMusicTab is not missing value then
        tell ytMusicTab to select
        log "Selected existing YouTube Music tab."
    else
        log "YouTube Music tab not found. Opening a new tab..."
        tell front window to make new tab with properties {URL:"https://music.youtube.com/playlist?list=LM"}
        set ytMusicTab to active tab of front window
        log "New YouTube Music tab opened."
    end if

    -- Ensure the play button is present and interactable
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

        -- Click the play button if not already playing
        log "Attempting to click the play button..."
        execute javascript "
            (function() {
                const playButton = document.querySelector('ytmusic-play-button-renderer');
                if (playButton && playButton.getAttribute('state') !== 'playing') {
                    console.log('Clicking play button to start music...');
                    playButton.click();
                } else {
                    console.log('Music is already playing or play button is not found.');
                }
            })();
        "
        log "Play button clicked or already playing."
    end tell

    log "Script execution completed."
end tell
