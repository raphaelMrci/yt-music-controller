on run argv
    -- Get the playlist URL from the argument
    if (count of argv) > 0 then
        set playlistURL to item 1 of argv
    else
        error "No playlist URL provided."
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

    -- Proceed with the script logic for shuffle mode
    tell application "Arc"
        set ytMusicTab to missing value

        -- Search for the YouTube Music tab with the given playlist URL
        log "Searching for the YouTube Music tab with the provided playlist URL..."
        repeat with w in every window
            repeat with t in every tab of w
                if (URL of t contains playlistURL) then
                    set ytMusicTab to t
                    log "Found YouTube Music tab with the provided playlist URL."
                    exit repeat
                end if
            end repeat
            if ytMusicTab is not missing value then exit repeat
        end repeat

        -- Open the playlist URL in a new tab if not found
        if ytMusicTab is not missing value then
            tell ytMusicTab to select
            log "Selected existing YouTube Music tab."
        else
            log "YouTube Music tab not found. Opening a new tab with the provided playlist URL..."
            tell front window to make new tab with properties {URL:playlistURL}
            set ytMusicTab to active tab of front window
            log "New YouTube Music tab opened with the provided playlist URL."
        end if

        -- Interact with the menu and shuffle button
        log "Attempting to click the menu and shuffle button..."
        tell ytMusicTab
            execute javascript "
            (function() {
                console.log('Searching for the menu button...');
                const menuButton = document.querySelector('ytmusic-menu-renderer tp-yt-paper-icon-button');
                if (menuButton) {
                    console.log('Menu button found. Clicking it...');
                    menuButton.click();

                    setTimeout(() => {
                        console.log('Searching for the dropdown list...');
                        const listBox = document.querySelector('tp-yt-paper-listbox#items');
                        if (!listBox) {
                            console.error('Dropdown listbox not found.');
                            return;
                        }
                        console.log('Listbox found:', listBox);

                        const items = Array.from(listBox.querySelectorAll('ytmusic-menu-navigation-item-renderer'));
                        console.log(`Found ${items.length} items in the listbox.`);

                        const shuffleButton = items.find(item => {
                            const anchor = item.querySelector('a');
                            const href = anchor ? anchor.getAttribute('href') : null;
                            return href && href.startsWith('watch?playlist='); // Identify the shuffle button by href structure
                        });

                        if (shuffleButton) {
                            console.log('Shuffle button found. Clicking it...');
                            shuffleButton.querySelector('a').click();
                        } else {
                            console.error('Shuffle button not found in the listbox.');
                        }
                    }, 2000); // Allow time for the dropdown to populate
                } else {
                    console.error('Menu button not found.');
                }
            })();
            "
            log "Menu and shuffle button interaction completed."
        end tell

        log "Script execution completed."
    end tell
end run
