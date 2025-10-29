fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios prep

```sh
[bundle exec] fastlane ios prep
```

Flutter clean & pub get

### ios build

```sh
[bundle exec] fastlane ios build
```

Build iOS for the selected flavor (requires --env)

### ios beta

```sh
[bundle exec] fastlane ios beta
```

Upload to TestFlight for the prod environment

### ios local

```sh
[bundle exec] fastlane ios local
```

Local iOS build that stays on the machine

### ios prod

```sh
[bundle exec] fastlane ios prod
```

Prod build & TestFlight upload

----


## Android

### android prep

```sh
[bundle exec] fastlane android prep
```

Flutter clean & pub get

### android build

```sh
[bundle exec] fastlane android build
```

Build Android artifact for a flavor

### android local

```sh
[bundle exec] fastlane android local
```

Local debug APK build

### android prod

```sh
[bundle exec] fastlane android prod
```

Prod release AAB build

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
