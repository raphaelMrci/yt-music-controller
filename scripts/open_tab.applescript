tell application "Arc"
    set ytMusicTab to missing value
    -- Search for the YouTube Music tab
    repeat with w in every window
        repeat with t in every tab of w
            if (URL of t contains "music.youtube.com") then
                set ytMusicTab to t
                exit repeat
            end if
        end repeat
        if ytMusicTab is not missing value then exit repeat
    end repeat

    -- Open new tab if not found
    if ytMusicTab is not missing value then
        tell ytMusicTab to select
    else
        tell front window to make new tab with properties {URL:"https://music.youtube.com/playlist?list=LM"}
        delay 3
    end if
end tell
