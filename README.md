# babymom-diary

A Flutter app for tracking baby care activities.

**Quick Start**
- Clone the repo and install packages: `flutter pub get`
- Run on a device/emulator: `flutter run`

This project defaults to a local-only mode using `SharedPreferences` (no Firebase required). You can optionally enable Firebase/Firestore later.

**Requirements**
- Flutter SDK: `>=3.3.0 <4.0.0` (see `pubspec.yaml`)
- Platform toolchains:
  - iOS: Xcode + CocoaPods (`brew install cocoapods`), an iOS simulator or device
  - Android: Android Studio SDK + emulator or device

**Setup**
- Install Flutter dependencies: `flutter pub get`
- (iOS only, if needed) Install pods: `cd ios && pod install && cd -`
- Launch a simulator/emulator or plug in a device.

**Run**
- Debug run: `flutter run`
- Select the target device from Flutter’s prompt or VS Code/Android Studio device selector.

**Common Commands**
- Format: `flutter format .`
- Analyze: `flutter analyze`
- Tests: `flutter test`
