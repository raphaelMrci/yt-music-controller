tell application "Arc"
    -- Assuming tab is already open and active
    tell (active tab of front window) to execute javascript "
        const menuButton = document.querySelector('ytmusic-menu-renderer tp-yt-paper-icon-button');
        if (menuButton) {
            menuButton.click();
            setTimeout(() => {
                const shuffleButton = document.querySelector('a[href=\"watch?playlist=LM\"]');
                if (shuffleButton) shuffleButton.click();
            }, 1000);
        }
    "
end tell
