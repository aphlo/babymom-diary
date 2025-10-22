# babymom-diary

A Flutter app for tracking baby care activities.

**Quick Start**
- Install FVM (https://fvm.app) and ensure the `fvm` command is on your PATH.
- In the repo, install the pinned Flutter SDK and dependencies: `fvm use` (reads `.fvmrc`) then `fvm flutter pub get`
- Run on a device/emulator: `fvm flutter run`

**Requirements**
- Flutter SDK: `>=3.3.0 <4.0.0` (pinned via FVM to the stable release defined in `.fvmrc`)
- Platform toolchains:
  - iOS: Xcode + CocoaPods (`brew install cocoapods`), an iOS simulator or device
  - Android: Android Studio SDK + emulator or device

**FVM Tips**
- Reinstall or update the pinned SDK: `fvm use`
- Run ad-hoc commands via `fvm flutter <command>` (consider `alias flutter="fvm flutter"` locally)

**Setup**
- Install Flutter dependencies: `fvm flutter pub get`
- (iOS only, if needed) Install pods: `cd ios && pod install && cd -`
- Launch a simulator/emulator or plug in a device.

**Run**
- Debug run: `fvm flutter run`
- Select the target device from Flutter’s prompt or VS Code/Android Studio device selector.

**Common Commands**
- Format: `dart format lib test` (adjust paths as needed)
- Analyze: `fvm flutter analyze`
- Tests: `fvm flutter test`
