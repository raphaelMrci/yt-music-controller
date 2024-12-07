# YT Music Controller

A workflow for Alfred that allows you to control YouTube Music in the Arc browser. It supports basic playback actions, such as play, pause, next, and previous, as well as opening your liked songs or playlists.

For now, only the Arc browser is supported. Support for other browsers such as Chrome, Firefox, and Safari may be added in the future.

## Features

- **Detect Default Browser**:
  - Automatically detects your default browser or lets you specify one (currently supports only Arc).

- **Liked Songs Playback**:
  - Play your liked songs.
  - Play your liked songs in shuffle mode.

- **Playback Controls**:
  - Play or pause YouTube Music.
  - Skip to the next or previous song.

- **Playlist Support** *(In Progress)*:
  - Launch custom playlists by keyword. This feature is currently under development.

## Commands

| **Keyword** | **Description**                                                    |
| ----------- | ------------------------------------------------------------------ |
| `liked`     | Launch your liked songs playlist.                                  |
| `likedr`    | Launch your liked songs in shuffle mode.                           |
| `play`      | Play or pause YouTube Music.                                       |
| `pause`     | Alias for `play`.                                                  |
| `next`      | Skip to the next song.                                             |
| `previous`  | Skip to the previous song.                                         |
| `p1`        | *(In Progress)* Launch your first custom playlist.                 |
| `p1r`       | *(In Progress)* Launch your first custom playlist in shuffle mode. |

## Installation

1. **Download**: Clone or download the repository from [GitHub](https://github.com/raphaelMrci/yt-music-controller).
2. **Import Workflow**: Open Alfred and import the `.alfredworkflow` file.
3. **Setup Browser** (Optional):
   - By default, the workflow detects your default browser.
   - To manually specify a browser, open the workflow's configuration and set the `browser_name` variable.
   - If your browser is not supported, it will not work until future updates.

## How It Works

1. **Browser Detection**:
   - The workflow attempts to detect your default browser.
   - You can override this behavior by specifying `browser_name`.

2. **Liked Songs & Shuffle**:
   - The workflow uses AppleScript to open the YouTube Music tab in the specified browser.
   - It interacts with the menu and shuffle options using injected JavaScript.

3. **Playback Controls**:
   - Controls playback (play/pause, next, previous) via YouTube Music's active tab.

4. **Custom Playlists** *(In Progress)*:
   - Define and play your custom playlists using keywords like `p1` or `p1r`.

## Dependencies

- **macOS**: Required for AppleScript.
- **Alfred Powerpack**: Required to import and use the workflow.
- **Supported Browsers**:
  - Arc (default and only supported browser for now)
  - Support for Google Chrome, Firefox, and Safari is coming soon.

## Troubleshooting

- **YT Music Tab Not Found**:
  - Ensure you’re logged into YouTube Music in your browser.
  - Verify that the browser specified in `browser_name` is installed and working.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to fork the repository and submit pull requests for new features or improvements!

## Author

Created by **Raphael Mrci**.

GitHub: [@raphaelMrci](https://github.com/raphaelMrci)
