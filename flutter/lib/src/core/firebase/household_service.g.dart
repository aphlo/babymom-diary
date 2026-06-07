// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firebaseAuth)
const firebaseAuthProvider = FirebaseAuthProvider._();

final class FirebaseAuthProvider
    extends $FunctionalProvider<FirebaseAuth, FirebaseAuth, FirebaseAuth>
    with $Provider<FirebaseAuth> {
  const FirebaseAuthProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'firebaseAuthProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firebaseAuthHash();

  @$internal
  @override
  $ProviderElement<FirebaseAuth> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirebaseAuth create(Ref ref) {
    return firebaseAuth(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseAuth value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseAuth>(value),
    );
  }
}

String _$firebaseAuthHash() => r'cb440927c3ab863427fd4b052a8ccba4c024c863';

@ProviderFor(firebaseFirestore)
const firebaseFirestoreProvider = FirebaseFirestoreProvider._();

final class FirebaseFirestoreProvider extends $FunctionalProvider<
    FirebaseFirestore,
    FirebaseFirestore,
    FirebaseFirestore> with $Provider<FirebaseFirestore> {
  const FirebaseFirestoreProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'firebaseFirestoreProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firebaseFirestoreHash();

  @$internal
  @override
  $ProviderElement<FirebaseFirestore> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirebaseFirestore create(Ref ref) {
    return firebaseFirestore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseFirestore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseFirestore>(value),
    );
  }
}

String _$firebaseFirestoreHash() => r'da44e0544482927855093596d84cb41842b27214';

@ProviderFor(firebaseFunctions)
const firebaseFunctionsProvider = FirebaseFunctionsProvider._();

final class FirebaseFunctionsProvider extends $FunctionalProvider<
    FirebaseFunctions,
    FirebaseFunctions,
    FirebaseFunctions> with $Provider<FirebaseFunctions> {
  const FirebaseFunctionsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'firebaseFunctionsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firebaseFunctionsHash();

  @$internal
  @override
  $ProviderElement<FirebaseFunctions> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirebaseFunctions create(Ref ref) {
    return firebaseFunctions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseFunctions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseFunctions>(value),
    );
  }
}

String _$firebaseFunctionsHash() => r'e5a28559af1fc5c157cdfba83e5aef7625eb968a';

@ProviderFor(householdService)
const householdServiceProvider = HouseholdServiceProvider._();

final class HouseholdServiceProvider extends $FunctionalProvider<
    HouseholdService,
    HouseholdService,
    HouseholdService> with $Provider<HouseholdService> {
  const HouseholdServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'householdServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$householdServiceHash();

  @$internal
  @override
  $ProviderElement<HouseholdService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HouseholdService create(Ref ref) {
    return householdService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HouseholdService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HouseholdService>(value),
    );
  }
}

String _$householdServiceHash() => r'9679cd6574ef6d5a5d2c0a8f0a567edc9bbe8bda';

/// Provider for initial household ID (used at app startup)
/// This ensures a household exists and returns its ID synchronously after initial load

@ProviderFor(initialHouseholdId)
const initialHouseholdIdProvider = InitialHouseholdIdProvider._();

/// Provider for initial household ID (used at app startup)
/// This ensures a household exists and returns its ID synchronously after initial load

final class InitialHouseholdIdProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// Provider for initial household ID (used at app startup)
  /// This ensures a household exists and returns its ID synchronously after initial load
  const InitialHouseholdIdProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'initialHouseholdIdProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$initialHouseholdIdHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return initialHouseholdId(ref);
  }
}

String _$initialHouseholdIdHash() =>
    r'1c2ab5debb069fb34578d8e934566f4b898e6bb4';

@ProviderFor(authState)
const authStateProvider = AuthStateProvider._();

final class AuthStateProvider
    extends $FunctionalProvider<AsyncValue<User?>, User?, Stream<User?>>
    with $FutureModifier<User?>, $StreamProvider<User?> {
  const AuthStateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authStateProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authStateHash();

  @$internal
  @override
  $StreamProviderElement<User?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<User?> create(Ref ref) {
    return authState(ref);
  }
}

String _$authStateHash() => r'bb1f08243a83d88f3fa41e7632f0637b369f833b';

/// users/{uid}ドキュメントを単一のStreamで購読するプロバイダー
/// 複数のプロバイダーで同じドキュメントを購読しないよう統合

@ProviderFor(userDocumentStream)
const userDocumentStreamProvider = UserDocumentStreamProvider._();

/// users/{uid}ドキュメントを単一のStreamで購読するプロバイダー
/// 複数のプロバイダーで同じドキュメントを購読しないよう統合

final class UserDocumentStreamProvider extends $FunctionalProvider<
        AsyncValue<UserDocumentData>,
        UserDocumentData,
        Stream<UserDocumentData>>
    with $FutureModifier<UserDocumentData>, $StreamProvider<UserDocumentData> {
  /// users/{uid}ドキュメントを単一のStreamで購読するプロバイダー
  /// 複数のプロバイダーで同じドキュメントを購読しないよう統合
  const UserDocumentStreamProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userDocumentStreamProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userDocumentStreamHash();

  @$internal
  @override
  $StreamProviderElement<UserDocumentData> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<UserDocumentData> create(Ref ref) {
    return userDocumentStream(ref);
  }
}

String _$userDocumentStreamHash() =>
    r'59d62c4a0d5c5076ffed1fe1d19452a90ed2b9c2';

/// Provider that derives activeHouseholdId from the shared user document stream
/// Uses select to avoid Stream-of-Streams while sharing the single Firestore listener

@ProviderFor(currentHouseholdId)
const currentHouseholdIdProvider = CurrentHouseholdIdProvider._();

/// Provider that derives activeHouseholdId from the shared user document stream
/// Uses select to avoid Stream-of-Streams while sharing the single Firestore listener

final class CurrentHouseholdIdProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// Provider that derives activeHouseholdId from the shared user document stream
  /// Uses select to avoid Stream-of-Streams while sharing the single Firestore listener
  const CurrentHouseholdIdProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'currentHouseholdIdProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$currentHouseholdIdHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return currentHouseholdId(ref);
  }
}

String _$currentHouseholdIdHash() =>
    r'ee603496fc4d4604e113af2819933eba39c4d92d';

/// Provider that derives membershipType from the shared user document stream
/// Uses select to avoid Stream-of-Streams while sharing the single Firestore listener

@ProviderFor(currentMembershipType)
const currentMembershipTypeProvider = CurrentMembershipTypeProvider._();

/// Provider that derives membershipType from the shared user document stream
/// Uses select to avoid Stream-of-Streams while sharing the single Firestore listener

final class CurrentMembershipTypeProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  /// Provider that derives membershipType from the shared user document stream
  /// Uses select to avoid Stream-of-Streams while sharing the single Firestore listener
  const CurrentMembershipTypeProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'currentMembershipTypeProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$currentMembershipTypeHash();

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    return currentMembershipType(ref);
  }
}

String _$currentMembershipTypeHash() =>
    r'f76eb4aae44803c00f6f295d87c0a85d24f90e55';
