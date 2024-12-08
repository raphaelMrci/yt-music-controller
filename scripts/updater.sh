#!/bin/bash

# Environment Variables
INFO_PLIST="./info.plist"  # Path to the local info.plist file
REMOTE_INFO_PLIST="https://raw.githubusercontent.com/raphaelMrci/yt-music-controller/refs/heads/main/info.plist"  # URL to the remote info.plist
BASE_DOWNLOAD_URL="https://github.com/raphaelMrci/yt-music-controller/releases/download"  # Base URL for releases

# Extract the current version from the local info.plist
CURRENT_VERSION=$(plutil -extract version raw "$INFO_PLIST" 2>/dev/null)
if [ -z "$CURRENT_VERSION" ]; then
    osascript -e "display dialog \"Error: Failed to extract the current version from the local info.plist.\" buttons {\"OK\"} default button \"OK\""
    exit 1
fi

# Fetch the remote info.plist
REMOTE_INFO=$(curl -s --fail "$REMOTE_INFO_PLIST")
if [ $? -ne 0 ] || [ -z "$REMOTE_INFO" ]; then
    osascript -e "display dialog \"Error: Failed to fetch the remote info.plist.\" buttons {\"OK\"} default button \"OK\""
    exit 1
fi

# Extract the latest version from the remote info.plist
LATEST_VERSION=$(echo "$REMOTE_INFO" | plutil -extract version raw -o - -)
if [ -z "$LATEST_VERSION" ]; then
    osascript -e "display dialog \"Error: Failed to extract the latest version from the remote info.plist.\" buttons {\"OK\"} default button \"OK\""
    exit 1
fi

# Compare versions
if [ "$LATEST_VERSION" != "$CURRENT_VERSION" ]; then
    osascript -e "display dialog \"A new version ($LATEST_VERSION) of YT Music Controller is available!\" buttons {\"Cancel\", \"Update\"} default button \"Update\""
    if [ $? -eq 0 ]; then
        # Construct the dynamic download URL
        DOWNLOAD_URL="$BASE_DOWNLOAD_URL/v$LATEST_VERSION/YT.Music.Controller.alfredworkflow"

        # Download and open the updated workflow
        curl -L --fail -o /tmp/YTMusicController.alfredworkflow "$DOWNLOAD_URL"
        if [ $? -eq 0 ]; then
            open /tmp/YTMusicController.alfredworkflow
        else
            osascript -e "display dialog \"Error: Failed to download the update.\" buttons {\"OK\"} default button \"OK\""
            exit 1
        fi
    fi
fi
