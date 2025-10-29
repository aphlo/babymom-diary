# babymom-diary

A Flutter app for tracking baby care activities.

**Quick Start**
- Install FVM (https://fvm.app) and ensure the `fvm` command is on your PATH.
- In the repo, install the pinned Flutter SDK and dependencies: `fvm use` (reads `.fvmrc`) then `fvm flutter pub get`
- Run on a device/emulator: `rake run_local` (or `rake run_prod`)

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
- Local flavor (emulator/debug): `rake run_local`
- Production flavor: `rake run_prod`
- Select the target device from Flutter’s prompt or VS Code/Android Studio device selector.

**Common Commands**
- Format: `dart format lib test` (adjust paths as needed)
- Analyze: `fvm flutter analyze`
- Tests: `fvm flutter test`

**Rake Tasks**
- Run local flavor: `rake run_local`
- Run prod flavor: `rake run_prod`
- Analyze / test: `rake analyze`, `rake test`
- Pass extra Flutter flags via `ARGS`, e.g. `ARGS="--device-id emulator-5554" rake run_prod`

**Environments**
- Copy `lib/firebase_options_local.example.dart` and `lib/firebase_options_prod.example.dart` to their non-`.example` counterparts, then run `flutterfire configure --project <firebase-project-id> --out <dest-file>` for local/prod to populate real credentials (the generated files stay local because they are gitignored).
- Android requires `google-services.json` per flavor: copy the `.example` files under `android/app/src/<flavor>/` to `google-services.json` and fill in the Firebase values from the console.
- iOS schemes: `local` targets `Debug-local` and connects to the Firebase Emulator Suite, `prod` targets `Release-prod`.
- Fastlane environment variables: duplicate `fastlane/.env.local.example` / `.env.prod.example` and populate secrets (Apple IDs, etc.) in the `.env.*` files that stay outside of git.
- Run the app: `rake run_local` (emulator host defaults to `localhost`, override with `ARGS="--dart-define=BABYMOM_FIREBASE_EMULATOR_HOST=<host>"` if you run on Android/iOS hardware) or `rake run_prod`.
- Fastlane (after `bundle install`): `fastlane local --env local`, `fastlane prod --env prod`, `fastlane -f fastlane/Fastfile.android local --env local`, `fastlane -f fastlane/Fastfile.android prod --env prod`.
