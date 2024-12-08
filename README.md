# YT Music Controller

YT Music Controller is an Alfred workflow designed to streamline your interaction with YouTube Music in the Arc browser. It provides quick access to your liked songs, playback controls, custom playlists, and an optional auto-updater directly from Alfred. Alfred Remote support has also been added for even more convenience. Support for additional browsers is planned for future updates.

## Features

- **Playback Controls**:
  - Play or pause YouTube Music.
  - Skip to the next or previous song in your playlist.

- **Liked Songs**:
  - Quickly launch your liked songs playlist.
  - Shuffle your liked songs with a single command.

- **Custom Playlist Support**:
  - Launch and control up to **3 different custom playlists**.
  - Shuffle mode is available for each custom playlist.

- **Auto-Updater** *(Configurable)*:
  - Automatically checks for updates and installs them.
  - Can be enabled or disabled in the workflow configuration.

- **Browser Detection** *(Arc Supported)*:
  - Automatically detects Arc as the default browser.
  - Support for Chrome, Firefox, Brave and Safari is planned for future updates.

- **Alfred Remote Support**:
  - Control your YouTube Music playback directly from Alfred Remote.

## Commands

All commands are prefixed with `ym`. For example, use `ym liked` to launch your liked songs playlist.

| Command       | Description                                        |
| ------------- | -------------------------------------------------- |
| `ym liked`    | Launches your liked songs playlist.                |
| `ym likedr`   | Plays your liked songs in shuffle mode.            |
| `ym play`     | Toggles play or pause on YouTube Music.            |
| `ym next`     | Skips to the next song.                            |
| `ym previous` | Plays the previous song.                           |
| `ym p1`       | Plays your first custom playlist.                  |
| `ym p1r`      | Plays your first custom playlist in shuffle mode.  |
| `ym p2`       | Plays your second custom playlist.                 |
| `ym p2r`      | Plays your second custom playlist in shuffle mode. |
| `ym p3`       | Plays your third custom playlist.                  |
| `ym p3r`      | Plays your third custom playlist in shuffle mode.  |

## Requirements

- **macOS**: Required for AppleScript functionality.
- **Alfred Powerpack**: To enable workflows.
- **Arc Browser**: Currently the only supported browser.

## Customization

### Configure Browser

1. Open Alfred preferences.
2. Edit the workflow's environment variables.
3. Specify the `Browser` variable to the one you want to use instead of your default browser. The list contains all the supported browsers.

### Enable or Disable Auto-Updater

1. Open the workflow's configuration
2. Check/Uncheck `Stay up-to-date`

## Notes

- The workflow uses AppleScript and JavaScript injection for precise control over YouTube Music.
- Make sure you are logged into YouTube Music in Arc for optimal functionality.
- Support for Chrome, Firefox, and Safari is planned for future updates.

## Author

Created by **Raphael Mrci**.

GitHub Repository: [YT Music Controller](https://github.com/raphaelMrci/yt-music-controller)
