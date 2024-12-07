on detectDefaultBrowser()
    try
        -- Execute the shell script to detect the default browser
        set default_browser to do shell script "
            x=~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure.plist; \\
            plutil -convert xml1 $x; \\
            grep 'https' -b3 $x | awk 'NR==2 {split($2, arr, \"[><]\"); print arr[3]}'; \\
            plutil -convert binary1 $x
        "

        -- Map common bundle identifiers to browser names
        if default_browser is "org.mozilla.firefox" then
            set browser_name to "Firefox"
        else if default_browser is "com.apple.Safari" then
            set browser_name to "Safari"
        else if default_browser is "com.google.Chrome" then
            set browser_name to "Google Chrome"
        else if default_browser is "com.brave.Browser" then
            set browser_name to "Brave"
        else if default_browser is "company.thebrowser.Browser" then
            set browser_name to "Arc"
        else
            set browser_name to "Unknown Browser (" & default_browser & ")"
        end if

        return browser_name
    on error errMsg number errNum
        return "err"
    end try
end detectDefaultBrowser

set browserName to detectDefaultBrowser()

on storeBrowser(browserName)
    -- Output the variable in Alfred's format
    do shell script "echo '" & browserName & "'"
end storeBrowser

storeBrowser(browserName)
