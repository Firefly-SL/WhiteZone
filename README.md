<h1 align="center">
  <span>White Zone</span>
</h1>

Desktop widget built with Rust and Egui, designed to visualize your annual progress.
I would like to let you know, this widget is on it's early developing area, and me on my busiest time in life. This project was build in order for me to learn Rust and to help a friend of mine with his needs. Still i am looking forward to improving this.

## Features

*   **Customizable Theme**: Personalize the widget through `config.toml` file, including background, heading colors, and dot grid colors for past, present, and future days.
*   **Always-On-Bottom Window**: white-zone stays under all other applications in the background, never obstructing your works.
*   **Configurable Window**: Adjust window size, position, corner radius, and drop shadow.
*   **Keyboard Shortcuts**:
    *   `Shift + R`: To Relaunch the widget (useful after config changes).
    *   `Ctrl + Q`: To Quit the widget.

## Installation
To install the widget check [latest release](https://github.com/Firefly-SL/white-zone/releases/latest) and install the corresponding executable for your operating system.

NOTE: as of now, the widget is only available for Windows and Linux.

After installation, it is recommended to put it in the Startup folder in windows (do a little google search for it), For Linux users i hope you figure it out or just send a message in [Discussions](https://github.com/Firefly-SL/white-zone/discussions/1). Now your widget will autostart after every boot.

If your widget isn't loading, delete the config.toml file and try to launch it again.
*   **Windows**: `%USERPROFILE%\Documents\white-zone\config.toml`
*   **Linux**: `~/.config/white-zone/config.toml` 

## Build from source
To build and run white-zone, you will need to have Rust and Cargo installed. If you don't have them, you can install them by following the instructions on the [official Rust website](https://www.rust-lang.org/tools/install).

1.  **Clone the repository**:
    ```bash
    git@github.com:Firefly-SL/white-zone.git
    cd white-zone
    ```
2.  **To run the widget without building.**:
    ```bash
    cargo run --release
    ```
3.  **To build the widget**:
    ```bash
    cargo build --release
    ```
    The `--release` flag is recommended (not mandatory) for better performance.

## Usage

Once launched, white-zone will appear as a overlay at the center of your desktop. It will display the current year, the number of days passed, the percentage of the year completed, and the remaining days in the year. The a visual representation of the year's progress. You can edit the config.toml file for customisation.

### Configuration

white-zone's appearance and behavior can be customized by editing the `config.toml` file. This file is automatically created the first time you run the widget.

*   **Windows**: `%USERPROFILE%\Documents\white-zone\config.toml`
*   **Linux**: `~/.config/white-zone/config.toml`

The `config.toml` file allows you to adjust:

*   **Window settings**: `size`, `ability to resize`, `position`, `corner_radius`, `lock_in_center`, and `drop_shadow` properties.
*   **Theme colors**: `background` and `heading` colors for the widget.
*   **Dot grid**: `column_count`, `color_past`, `color_future`, `color_today`, and `color_today_glow`.

You can turn off lock_in_center to freely move the widget were you desire.
NOTE: Now the funny part, resizing normaly, moving the app into another place will never presistent across reboots. don't ask me why i added those fields then, this lack of whatever will be fixed ASAP, even though this seems impossible to me. if you want to resize and change position use the fields size and position to do it manually.

## Contributing

Contributions are welcome! This project is on the early satges and i want to make it more useful for others. Even contributions like finding an optimal drop shadow settings is very much appreciated.

## License

The source code for white-zone is licensed under the GPL 3.0 license. See the [LICENSE.md](LICENSE.md) file for more details.

The fonts included in this project (`Poppins-Regular.ttf` and `Poppins-SemiBold.ttf`) are licensed under the Open Font License (OFL). See [OFL.txt](src/fonts/OFL.txt) for more details.