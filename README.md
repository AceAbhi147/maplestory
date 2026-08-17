# Game 3: Maplestory

## Gameplay
| Gameplay 1                                   | Gameplay 2                                    |
 |----------------------------------------------|-----------------------------------------------|
| ![▶️ Gameplay](assets/gameplay/gameplay.gif) | ![▶️ Gameplay](assets/gameplay/gameplay2.gif) |

## Learnings
- Ticker for controling animation frames and game physics simulation
- Images/Sprite for game characters
- Looping animation & only-once animation decision and implementation
- Animations with Animation controller and Tween for "fading away" animations
- Improved state managements
- Render multiple assets/characters at the same time by storing there positional state in list/queue
- Splash screen with progress bar to load all assets behind the screens for smooth animations
- Color gradient for background
- Image repetition for texture inside a container

# MapleStory --- Local Development Setup

This document explains how to set up, run, and troubleshoot the
**MapleStory Flutter project** on a local development machine.

## 1. Prerequisites

Install the following before setting up the project:

-   **Flutter SDK**
-   **Dart SDK** --- included with Flutter
-   **Git**
-   **Android Studio** --- required for Android development/emulator
-   **VS Code or IntelliJ IDEA/Android Studio** --- for development
-   A browser such as **Chrome** for Flutter Web

Verify Flutter is installed:

``` bash
flutter --version
```

Then run:

``` bash
flutter doctor
```

Resolve any issues reported by `flutter doctor` before running the
application.

------------------------------------------------------------------------

## 2. Get the Source Code

Clone the repository:

``` bash
git clone <REPOSITORY_URL>
```

Move into the project directory:

``` bash
cd maplestory
```

If you already have the project locally, simply open the project root
--- the directory containing:

``` text
pubspec.yaml
```

------------------------------------------------------------------------

## 3. Project Structure

The project currently follows the standard Flutter structure:

``` text
maplestory/
├── .dart_tool/
├── .idea/
├── android/
├── assets/
├── build/
├── ios/
├── lib/
├── linux/
├── macos/
├── test/
├── web/
├── windows/
├── .gitignore
├── .metadata
├── analysis_options.yaml
├── maplestory.iml
├── pubspec.lock
├── pubspec.yaml
└── README.md
```

### Important directories

Directory       Purpose
  --------------- ---------------------------------------------------------
`lib/`          Main Dart/Flutter application code
`assets/`       Images, fonts, animations, and other application assets
`android/`      Android-specific project files
`ios/`          iOS-specific project files
`web/`          Flutter Web configuration
`windows/`      Windows desktop configuration
`linux/`        Linux desktop configuration
`macos/`        macOS desktop configuration
`test/`         Unit/widget tests
`build/`        Generated build output --- do not edit manually
`.dart_tool/`   Flutter/Dart generated files --- do not edit manually

------------------------------------------------------------------------

## 4. Install Dependencies

From the project root, run:

``` bash
flutter pub get
```

This reads `pubspec.yaml` and downloads/resolves the required Flutter
and Dart packages.

If dependencies appear to be out of sync, run:

``` bash
flutter clean
flutter pub get
```

------------------------------------------------------------------------

## 5. Verify Assets

The project contains an `assets/` directory.

Make sure assets referenced by the application are present and are
declared in `pubspec.yaml`.

For example:

``` yaml
flutter:
  assets:
    - assets/images/
```

After changing `pubspec.yaml`, run:

``` bash
flutter pub get
```

### Important

Asset paths are case-sensitive on some platforms.

For example:

``` dart
AssetImage('assets/images/cat/cat_0.png')
```

is different from:

``` dart
AssetImage('assets/images/Cat/cat_0.png')
```

Make sure the path used in Dart exactly matches the file path.

------------------------------------------------------------------------

## 6. Run the Application

First check which devices are available:

``` bash
flutter devices
```

### Run on Chrome

For Flutter Web:

``` bash
flutter run -d chrome
```

### Run on Android

Start an Android emulator from Android Studio, then verify it appears:

``` bash
flutter devices
```

Run:

``` bash
flutter run
```

Or explicitly specify the device:

``` bash
flutter run -d <DEVICE_ID>
```

### Run on Windows

If Windows desktop support is enabled:

``` bash
flutter run -d windows
```

------------------------------------------------------------------------

## 7. Running from Android Studio

1.  Open Android Studio.
2.  Select **Open**.
3.  Open the `maplestory` project directory.
4.  Wait for Flutter/Dart indexing to finish.
5.  Run:

``` bash
flutter pub get
```

6.  Start an emulator from **Device Manager**.
7.  Select the emulator from the device selector.
8.  Click **Run**.

For Web development, select Chrome as the target device.

------------------------------------------------------------------------

## 8. Running from the Command Line

A typical development session is:

``` bash
cd maplestory
flutter pub get
flutter devices
flutter run
```

For Chrome:

``` bash
flutter run -d chrome
```

For a specific Android device:

``` bash
flutter run -d <DEVICE_ID>
```

------------------------------------------------------------------------

## 9. Hot Reload

While the application is running, Flutter supports hot reload.

From the terminal:

``` text
r
```

This applies many Dart code changes without restarting the application.

Hot restart:

``` text
R
```

Use hot restart when a change requires the application state to be
recreated.

------------------------------------------------------------------------

## 10. Clean Build

If the application behaves unexpectedly after dependency, asset, or
build changes:

``` bash
flutter clean
flutter pub get
flutter run
```

For Android, you can also remove generated build artifacts if necessary
and rebuild.

Do **not** manually edit files inside:

``` text
build/
.dart_tool/
```

They are generated by Flutter.

------------------------------------------------------------------------

## 11. Common Asset Errors

If you see an error similar to:

``` text
Unable to load asset
```

check the following:

### Check the file exists

For example:

``` text
assets/
└── images/
    └── cat/
        └── cat_0.png
```

### Check `pubspec.yaml`

Make sure the directory is declared:

``` yaml
flutter:
  assets:
    - assets/images/
```

### Check the Dart path

The path must match exactly:

``` dart
AssetImage('assets/images/cat/cat_0.png')
```

Avoid accidentally passing an empty string:

``` dart
AssetImage('')
```

An empty asset path can result in Flutter attempting to load:

``` text
assets/
```

and returning a 404, particularly on Flutter Web.

------------------------------------------------------------------------

## 12. If Flutter Web Shows an Asset 404

If the application works on one platform but assets fail on Web:

1.  Verify the asset is declared in `pubspec.yaml`.
2.  Run:

``` bash
flutter clean
flutter pub get
```

3.  Stop the running application.
4.  Start it again:

``` bash
flutter run -d chrome
```

Also verify that the asset path is not empty and that the filename's
capitalization matches the actual file.

------------------------------------------------------------------------

## 13. Check Flutter Configuration

Run:

``` bash
flutter doctor -v
```

This provides detailed information about:

-   Flutter SDK
-   Dart SDK
-   Android SDK
-   Android Studio
-   Connected devices
-   Chrome
-   Desktop development tools

If the project requires a particular Flutter version, check the
project's `pubspec.yaml` for the Dart/Flutter SDK constraint.

------------------------------------------------------------------------

## 14. Recommended Development Workflow

After pulling changes from Git:

``` bash
git pull
flutter pub get
flutter run
```

If there are build or dependency issues:

``` bash
flutter clean
flutter pub get
flutter run
```

Before committing changes, it is recommended to run:

``` bash
flutter analyze
```

And, when tests are available:

``` bash
flutter test
```

------------------------------------------------------------------------

## 15. Useful Commands

Command                   Purpose
  ------------------------- ---------------------------------------
`flutter doctor`          Check Flutter development environment
`flutter doctor -v`       Detailed environment information
`flutter pub get`         Install/update dependencies
`flutter devices`         List available devices
`flutter run`             Run the application
`flutter run -d chrome`   Run on Chrome
`flutter clean`           Remove generated build files
`flutter analyze`         Analyze Dart/Flutter code
`flutter test`            Run tests

------------------------------------------------------------------------

## 16. Quick Start

For an already-configured development machine, the minimum setup is:

``` bash
git clone <REPOSITORY_URL>
cd maplestory
flutter pub get
flutter devices
flutter run
```

For Web:

``` bash
flutter run -d chrome
```

For Android:

``` bash
flutter run -d <ANDROID_DEVICE_ID>
```

------------------------------------------------------------------------

## 17. Notes for Contributors

-   Do not commit generated build output.
-   Do not manually modify `.dart_tool/` or `build/`.
-   Keep assets under the `assets/` directory.
-   Update `pubspec.yaml` whenever new asset directories are introduced.
-   Run `flutter pub get` after dependency or asset configuration
    changes.
-   Run `flutter analyze` before submitting changes.
-   Use consistent asset paths and filename casing.


