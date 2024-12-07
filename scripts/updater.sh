#!/bin/bash

# Environment Variables
CURRENT_VERSION=$(cat version.txt)  # Read the local version from version.txt
VERSION_URL="https://github.com/raphaelMrci/yt-music-controller/version.txt"  # URL to version.txt
BASE_DOWNLOAD_URL="https://github.com/raphaelMrci/yt-music-controller/releases/download"  # Base URL for releases

# Validate CURRENT_VERSION
if [ -z "$CURRENT_VERSION" ]; then
    osascript -e "display dialog \"Error: Current version not provided.\" buttons {\"OK\"} default button \"OK\""
    exit 1
fi

# Fetch the latest version
LATEST_VERSION=$(curl -s --fail "$VERSION_URL")
if [ $? -ne 0 ] || [ -z "$LATEST_VERSION" ]; then
    osascript -e "display dialog \"Error: Failed to fetch the latest version.\" buttons {\"OK\"} default button \"OK\""
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
else
    osascript -e "display dialog \"You are already using the latest version ($CURRENT_VERSION).\" buttons {\"OK\"} default button \"OK\""
fi
