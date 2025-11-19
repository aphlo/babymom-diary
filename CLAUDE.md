# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**babymom-diary** (branded as "milu") is a monorepo containing:
- **Flutter app**: Baby care activity tracking (vaccinations, growth records, calendar, maternal health)
- **Cloud Functions**: Backend logic for household sharing and other server-side features
- **Terraform**: Infrastructure as Code for GCP resource management

The Flutter codebase follows strict Domain-Driven Design (DDD) principles combined with MVVM architecture.

## Repository Structure

```
babymom-diary/
├── flutter/           # Flutter application
├── cloud-functions/   # Firebase Cloud Functions (Node.js/TypeScript)
├── terraform/         # Infrastructure as Code
├── docs/             # Project-wide documentation
├── firestore.rules   # Firestore security rules
├── firestore.indexes.json
└── firebase.json     # Firebase configuration (gitignored - contains secrets)
```

## Essential Commands

### Development (via Rake)

**NOTE:** All Rake commands must be run from the `flutter/` directory.

```bash
cd flutter
rake run_local      # Run with local flavor (Firebase emulator)
rake run_prod       # Run with prod flavor (production Firebase)
rake format         # Format code: fvm dart format lib test
rake lint           # Analyze: fvm flutter analyze
rake test           # Run tests: fvm flutter test
```

Pass extra Flutter flags via `ARGS` environment variable:
```bash
cd flutter
ARGS="--device-id emulator-5554" rake run_prod
ARGS="--dart-define=BABYMOM_FIREBASE_EMULATOR_HOST=10.0.2.2" rake run_local
```

### Direct Flutter Commands (via FVM)

```bash
cd flutter
fvm use                     # Install/switch to pinned Flutter version
fvm flutter pub get         # Install dependencies
fvm flutter test test/path/to/test_file.dart  # Run single test file
fvm flutter test --name "test name pattern"   # Run specific test by name
fvm flutter run --flavor local -t lib/main_local.dart --device-id <device>
```

### Testing
- Unit tests mirror feature structure: `flutter/test/features/{feature}/{layer}/{file}_test.dart`
- Focus on domain services and use cases for business logic validation
- Run specific test: `cd flutter && fvm flutter test test/features/vaccines/domain/services/vaccination_schedule_policy_test.dart`

## Architecture

### Layer Structure (DDD + MVVM)

The Flutter app strictly separates concerns into four layers:

```
flutter/lib/src/features/{feature}/
  domain/           # Business logic (NO Flutter/Firebase dependencies)
    entities/       # Immutable core business objects
    repositories/   # Repository interfaces (abstract)
    services/       # Domain services (complex business rules)
    value_objects/  # Value objects (primitives with validation)
    errors/         # Domain-specific errors

  application/      # Use case orchestration
    usecases/       # Application operations (coordinator layer)
    mappers/        # Application-level transformations

  infrastructure/   # Data persistence & external systems
    repositories/   # Repository implementations
    sources/        # Data sources (Firestore, assets)
    models/         # DTOs/data models for serialization
    firestore/      # Firestore-specific commands/queries

  presentation/     # UI (MVVM pattern)
    pages/          # Screen widgets
    widgets/        # Feature-specific UI components
    viewmodels/     # State management (Riverpod StateNotifier)
    models/         # UI-specific models
    mappers/        # Domain-to-UI transformations
    controllers/    # UI controllers
    styles/         # UI styling
```

**Critical Principles:**
1. **Domain Independence:** Domain layer MUST NOT import Flutter, Firebase, or any infrastructure packages
2. **Dependency Inversion:** Domain defines repository interfaces; infrastructure implements them
3. **Immutability:** All entities and value objects use `@immutable` annotation
4. **Mapper Pattern:** Separate mappers handle transformations between layers
5. **Use Case Encapsulation:** Each business operation is a dedicated use case class

### Data Flow

```
Widget
  → ViewModel (StateNotifier)
    → UseCase
      → Repository Interface (domain)
        → Repository Implementation (infrastructure)
          → Data Source (Firestore/Local)
```

**Example (Adding Calendar Event):**
- `AddCalendarEventPage` (view) calls `CalendarViewModel.addEvent()`
- `CalendarViewModel` calls `AddCalendarEvent` use case
- Use case calls `CalendarEventRepository.add()`
- `CalendarEventRepositoryImpl` calls `CalendarEventFirestoreDataSource.add()`
- Data source writes to Firestore, returns domain entity
- Mappers transform domain entity → UI model for display

### State Management (Riverpod)

- **Providers:** Dependency injection and state exposure
- **StateNotifier:** Mutable state management in ViewModels
- **AsyncValue:** Handling async operations with loading/error states
- **Stream-based reactivity:** Real-time Firestore updates via StreamProvider

**ViewModel Pattern:**
```dart
class FeatureViewModel extends StateNotifier<FeatureState> {
  final UseCase _useCase;

  FeatureViewModel(this._useCase) : super(FeatureState.initial());

  Future<void> performAction() async {
    state = state.copyWith(isLoading: true);
    final result = await _useCase.execute();
    state = state.copyWith(isLoading: false, data: result);
  }
}
```

## Key Features

### 1. Vaccines (Most Complex)
- **Domain Services:** `VaccinationSchedulePolicy`, `ReservationGroupDomainService`
- **Dose System:** Uses `doseId` (UUID) instead of `doseNumber` for stable references across edits
- **Reservation Groups:** Manages simultaneous vaccinations across multiple vaccine types
- **Firestore Schema:**
  - Doses stored as map within parent `vaccination_records` document
  - Separate `reservation_groups` collection for simultaneous bookings
  - Collections: `households/{householdId}/children/{childId}/vaccination_records/{vaccineId}`

### 2. Calendar
- Manages events and integrates with vaccination schedules
- Example implementation referenced in `AGENTS.md` for MVVM best practices

### 3. Child Record
- Daily activity tracking, growth records, percentile charts
- Multiple record types with historical data

### 4. Children
- Multi-child management per household
- Local caching with SharedPreferences + snapshot support

### 5. Mom Record
- Maternal health tracking and diary entries

### 6. Household
- Multi-user household management with anonymous Firebase auth

## Important Conventions

### Naming
- **Entities:** PascalCase descriptive (e.g., `VaccinationRecord`, `DoseRecord`)
- **Use Cases:** Verb-based (e.g., `CreateVaccineReservation`, `AddCalendarEvent`)
- **ViewModels:** `{Feature}ViewModel` with `{Feature}State`
- **Repositories:** `{Feature}Repository` (interface) + `{Feature}RepositoryImpl`
- **Data Sources:** `{Feature}FirestoreDataSource`

### Firestore Patterns
- **Collection Structure:** `households/{householdId}/children/{childId}/...`
- **Document IDs:** UUIDs for stable references
- **Dose Storage:** Map-based within parent document (not subcollections)
- **Sorting:** Dynamic sorting by `scheduledDate` → `createdAt` (not by sequence numbers)

### Code Organization
- Each feature is self-contained with all four layers
- Barrel files (e.g., `vaccines.dart`) for clean imports
- ViewModels NEVER directly access data sources (always through use cases)
- Mappers handle all cross-layer transformations

## Environment & Configuration

### Flavors
- **local:** Firebase emulator (default host: `localhost` for iOS, `10.0.2.2` for Android)
- **prod:** Production Firebase

Entry points: `flutter/lib/main_local.dart` and `flutter/lib/main_prod.dart`

### Firebase Setup

**IMPORTANT:** Firebase configuration files contain secrets and are gitignored. After cloning or migration, you need to regenerate them.

See detailed instructions: `docs/firebase_config_regeneration.md`

Quick setup:
```bash
cd flutter
flutterfire configure --project=babymom-diary --out=lib/firebase_options_local.dart
flutterfire configure --project=babymom-diary --out=lib/firebase_options_prod.dart
```

Required files (all gitignored):
- `flutter/lib/firebase_options_local.dart`
- `flutter/lib/firebase_options_prod.dart`
- `flutter/lib/firebase_options.dart`
- `flutter/android/app/src/local/google-services.json`
- `flutter/android/app/src/prod/google-services.json`
- `flutter/ios/Runner/GoogleService-Info-*.plist`
- `flutter/fastlane/.env.local`
- `flutter/fastlane/.env.prod`

### Development Tools
- **FVM:** Flutter Version Manager (pinned via `flutter/.fvmrc`)
- **Fastlane:** Deployment automation (run from `flutter/` directory)
- **Widgetbook:** Component catalog for UI development
- **Terraform:** Infrastructure management (in `terraform/` directory)
- **Firebase CLI:** Emulator and deployment (run from root directory)

## Key Design Decisions

### Dose ID System (Recent Migration)
- **Old:** `doseNumber` (sequential integers)
- **New:** `doseId` (UUIDs)
- **Reason:** Prevents reference breakage when doses are deleted/reordered
- **Impact:** Doses sorted dynamically for display, not by document structure

### Domain Services vs. Use Cases
- **Domain Services:** Complex business rules involving multiple entities (e.g., `VaccinationSchedulePolicy` calculates schedules based on child age and vaccine guidelines)
- **Use Cases:** Orchestrate operations across repositories and domain services (e.g., `CreateVaccineReservation` coordinates reservation creation and calendar updates)

### Multi-Child Support
- Household-based data isolation in Firestore
- Selected child state managed globally
- Local caching with snapshot support for viewing other children

## Documentation References

- `README.md` - Monorepo overview and quick start
- `flutter/README.md` - Flutter app specific documentation
- `cloud-functions/README.md` - Cloud Functions documentation
- `terraform/README.md` - Infrastructure management guide
- `AGENTS.md` (Japanese) - Detailed MVVM/DDD guidelines with CalendarPage examples
- `docs/household_sharing.md` (Japanese) - Household sharing feature design
- `docs/terraform_setup.md` (Japanese) - Terraform setup guide
- `docs/monorepo_migration.md` (Japanese) - Monorepo migration guide
- `docs/firebase_config_regeneration.md` (Japanese) - Firebase config regeneration steps
- `docs/dose.md` (Japanese) - Dose system design rationale and migration strategy
