tell application "Arc"
    set ytMusicTab to missing value

    -- Iterate through all windows and tabs
    repeat with w in every window
        repeat with t in every tab of w
            try
                if (URL of t) contains "music.youtube.com" then
                    set ytMusicTab to t
                    exit repeat
                end if
            end try
        end repeat
        if ytMusicTab is not missing value then exit repeat
    end repeat

    -- If YouTube Music tab is found
    if ytMusicTab is not missing value then
        tell ytMusicTab to execute javascript "document.querySelector('.play-pause-button').click();"
    else
        display notification "YouTube Music tab not found!" with title "YT Music controller"
    end if
end tell
