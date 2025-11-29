# union_shop

A Flutter project for the University of Portsmouth union shop.

## Overview

This repository contains a Flutter application (multi-platform) named `union_shop`.
The app's entrypoint is `lib/main.dart` and there are pages such as `about_page.dart`, `product_page.dart`, `sale_page.dart`, and `collections_page.dart` in the `lib/` folder.

## Requirements

- Flutter SDK (compatible with the project's `pubspec.yaml` environment).
- Platform toolchains for your target (Android Studio / Xcode / Visual Studio for desktop builds) if building for mobile/desktop.

## Setup

1. Install Flutter: https://flutter.dev/docs/get-started/install
2. From the repository root, fetch packages:

```powershell
flutter pub get
```

## Run the app

- To run on the default connected device/emulator:

```powershell
flutter run
```

- To run on Windows (desktop) specifically:

```powershell
flutter run -d windows
```

- To run on Android or iOS specify a device or use an emulator/simulator.

## Build

- Build an Android APK:

```powershell
flutter build apk --release
```

- Build for Windows:

```powershell
flutter build windows --release
```

## Tests

Run unit and widget tests with:

```powershell
flutter test
```

There are tests in the `test/` directory (for example `home_test.dart`, `product_test.dart`).

## Project structure (high level)

- `lib/` - application source code (UI and logic)
- `test/` - unit and widget tests
- `android/`, `ios/`, `linux/`, `macos/`, `web/`, `windows/` - platform folders for builds

## Notes

- The package is configured in `pubspec.yaml` (SDK constraints and basic dependencies). Update dependencies there and run `flutter pub get`.
- If you plan to run on iOS or macOS, use a macOS host with Xcode installed.

## License

Add a license file if you intend to publish this project.
