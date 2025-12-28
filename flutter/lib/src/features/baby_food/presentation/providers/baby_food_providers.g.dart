// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baby_food_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(babyFoodDataSource)
const babyFoodDataSourceProvider = BabyFoodDataSourceFamily._();

final class BabyFoodDataSourceProvider extends $FunctionalProvider<
    BabyFoodFirestoreDataSource,
    BabyFoodFirestoreDataSource,
    BabyFoodFirestoreDataSource> with $Provider<BabyFoodFirestoreDataSource> {
  const BabyFoodDataSourceProvider._(
      {required BabyFoodDataSourceFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'babyFoodDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$babyFoodDataSourceHash();

  @override
  String toString() {
    return r'babyFoodDataSourceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<BabyFoodFirestoreDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BabyFoodFirestoreDataSource create(Ref ref) {
    final argument = this.argument as String;
    return babyFoodDataSource(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BabyFoodFirestoreDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BabyFoodFirestoreDataSource>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is BabyFoodDataSourceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$babyFoodDataSourceHash() =>
    r'5c425c779e407d696f1106984611409ac374c17a';

final class BabyFoodDataSourceFamily extends $Family
    with $FunctionalFamilyOverride<BabyFoodFirestoreDataSource, String> {
  const BabyFoodDataSourceFamily._()
      : super(
          retry: null,
          name: r'babyFoodDataSourceProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  BabyFoodDataSourceProvider call(
    String householdId,
  ) =>
      BabyFoodDataSourceProvider._(argument: householdId, from: this);

  @override
  String toString() => r'babyFoodDataSourceProvider';
}

@ProviderFor(customIngredientDataSource)
const customIngredientDataSourceProvider = CustomIngredientDataSourceFamily._();

final class CustomIngredientDataSourceProvider extends $FunctionalProvider<
        CustomIngredientFirestoreDataSource,
        CustomIngredientFirestoreDataSource,
        CustomIngredientFirestoreDataSource>
    with $Provider<CustomIngredientFirestoreDataSource> {
  const CustomIngredientDataSourceProvider._(
      {required CustomIngredientDataSourceFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'customIngredientDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$customIngredientDataSourceHash();

  @override
  String toString() {
    return r'customIngredientDataSourceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<CustomIngredientFirestoreDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CustomIngredientFirestoreDataSource create(Ref ref) {
    final argument = this.argument as String;
    return customIngredientDataSource(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CustomIngredientFirestoreDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<CustomIngredientFirestoreDataSource>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CustomIngredientDataSourceProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$customIngredientDataSourceHash() =>
    r'd8761615704c85727ba963af5e3f1f733639f588';

final class CustomIngredientDataSourceFamily extends $Family
    with
        $FunctionalFamilyOverride<CustomIngredientFirestoreDataSource, String> {
  const CustomIngredientDataSourceFamily._()
      : super(
          retry: null,
          name: r'customIngredientDataSourceProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  CustomIngredientDataSourceProvider call(
    String householdId,
  ) =>
      CustomIngredientDataSourceProvider._(argument: householdId, from: this);

  @override
  String toString() => r'customIngredientDataSourceProvider';
}

@ProviderFor(hiddenIngredientsDataSource)
const hiddenIngredientsDataSourceProvider =
    HiddenIngredientsDataSourceFamily._();

final class HiddenIngredientsDataSourceProvider extends $FunctionalProvider<
        HiddenIngredientsFirestoreDataSource,
        HiddenIngredientsFirestoreDataSource,
        HiddenIngredientsFirestoreDataSource>
    with $Provider<HiddenIngredientsFirestoreDataSource> {
  const HiddenIngredientsDataSourceProvider._(
      {required HiddenIngredientsDataSourceFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'hiddenIngredientsDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$hiddenIngredientsDataSourceHash();

  @override
  String toString() {
    return r'hiddenIngredientsDataSourceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<HiddenIngredientsFirestoreDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HiddenIngredientsFirestoreDataSource create(Ref ref) {
    final argument = this.argument as String;
    return hiddenIngredientsDataSource(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HiddenIngredientsFirestoreDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<HiddenIngredientsFirestoreDataSource>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HiddenIngredientsDataSourceProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hiddenIngredientsDataSourceHash() =>
    r'6e8aec03b605b6a98e04e685492b9bbf8e380207';

final class HiddenIngredientsDataSourceFamily extends $Family
    with
        $FunctionalFamilyOverride<HiddenIngredientsFirestoreDataSource,
            String> {
  const HiddenIngredientsDataSourceFamily._()
      : super(
          retry: null,
          name: r'hiddenIngredientsDataSourceProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  HiddenIngredientsDataSourceProvider call(
    String householdId,
  ) =>
      HiddenIngredientsDataSourceProvider._(argument: householdId, from: this);

  @override
  String toString() => r'hiddenIngredientsDataSourceProvider';
}

@ProviderFor(babyFoodRecordRepository)
const babyFoodRecordRepositoryProvider = BabyFoodRecordRepositoryFamily._();

final class BabyFoodRecordRepositoryProvider extends $FunctionalProvider<
    BabyFoodRecordRepository,
    BabyFoodRecordRepository,
    BabyFoodRecordRepository> with $Provider<BabyFoodRecordRepository> {
  const BabyFoodRecordRepositoryProvider._(
      {required BabyFoodRecordRepositoryFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'babyFoodRecordRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$babyFoodRecordRepositoryHash();

  @override
  String toString() {
    return r'babyFoodRecordRepositoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<BabyFoodRecordRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BabyFoodRecordRepository create(Ref ref) {
    final argument = this.argument as String;
    return babyFoodRecordRepository(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BabyFoodRecordRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BabyFoodRecordRepository>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is BabyFoodRecordRepositoryProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$babyFoodRecordRepositoryHash() =>
    r'b1efa5bdc02ba278d3fcd8f619df9633a117c0da';

final class BabyFoodRecordRepositoryFamily extends $Family
    with $FunctionalFamilyOverride<BabyFoodRecordRepository, String> {
  const BabyFoodRecordRepositoryFamily._()
      : super(
          retry: null,
          name: r'babyFoodRecordRepositoryProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  BabyFoodRecordRepositoryProvider call(
    String householdId,
  ) =>
      BabyFoodRecordRepositoryProvider._(argument: householdId, from: this);

  @override
  String toString() => r'babyFoodRecordRepositoryProvider';
}

@ProviderFor(customIngredientRepository)
const customIngredientRepositoryProvider = CustomIngredientRepositoryFamily._();

final class CustomIngredientRepositoryProvider extends $FunctionalProvider<
    CustomIngredientRepository,
    CustomIngredientRepository,
    CustomIngredientRepository> with $Provider<CustomIngredientRepository> {
  const CustomIngredientRepositoryProvider._(
      {required CustomIngredientRepositoryFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'customIngredientRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$customIngredientRepositoryHash();

  @override
  String toString() {
    return r'customIngredientRepositoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<CustomIngredientRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CustomIngredientRepository create(Ref ref) {
    final argument = this.argument as String;
    return customIngredientRepository(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CustomIngredientRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CustomIngredientRepository>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CustomIngredientRepositoryProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$customIngredientRepositoryHash() =>
    r'109d19a310e7609bcd8d87f55f755ccfba9062e7';

final class CustomIngredientRepositoryFamily extends $Family
    with $FunctionalFamilyOverride<CustomIngredientRepository, String> {
  const CustomIngredientRepositoryFamily._()
      : super(
          retry: null,
          name: r'customIngredientRepositoryProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  CustomIngredientRepositoryProvider call(
    String householdId,
  ) =>
      CustomIngredientRepositoryProvider._(argument: householdId, from: this);

  @override
  String toString() => r'customIngredientRepositoryProvider';
}

@ProviderFor(addBabyFoodRecordUseCase)
const addBabyFoodRecordUseCaseProvider = AddBabyFoodRecordUseCaseFamily._();

final class AddBabyFoodRecordUseCaseProvider extends $FunctionalProvider<
    AddBabyFoodRecord,
    AddBabyFoodRecord,
    AddBabyFoodRecord> with $Provider<AddBabyFoodRecord> {
  const AddBabyFoodRecordUseCaseProvider._(
      {required AddBabyFoodRecordUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'addBabyFoodRecordUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$addBabyFoodRecordUseCaseHash();

  @override
  String toString() {
    return r'addBabyFoodRecordUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<AddBabyFoodRecord> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AddBabyFoodRecord create(Ref ref) {
    final argument = this.argument as String;
    return addBabyFoodRecordUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddBabyFoodRecord value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddBabyFoodRecord>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AddBabyFoodRecordUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$addBabyFoodRecordUseCaseHash() =>
    r'b179e749b5f50c71bc9b6c306cb1966b78139ee4';

final class AddBabyFoodRecordUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<AddBabyFoodRecord, String> {
  const AddBabyFoodRecordUseCaseFamily._()
      : super(
          retry: null,
          name: r'addBabyFoodRecordUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  AddBabyFoodRecordUseCaseProvider call(
    String householdId,
  ) =>
      AddBabyFoodRecordUseCaseProvider._(argument: householdId, from: this);

  @override
  String toString() => r'addBabyFoodRecordUseCaseProvider';
}

@ProviderFor(updateBabyFoodRecordUseCase)
const updateBabyFoodRecordUseCaseProvider =
    UpdateBabyFoodRecordUseCaseFamily._();

final class UpdateBabyFoodRecordUseCaseProvider extends $FunctionalProvider<
    UpdateBabyFoodRecord,
    UpdateBabyFoodRecord,
    UpdateBabyFoodRecord> with $Provider<UpdateBabyFoodRecord> {
  const UpdateBabyFoodRecordUseCaseProvider._(
      {required UpdateBabyFoodRecordUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'updateBabyFoodRecordUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$updateBabyFoodRecordUseCaseHash();

  @override
  String toString() {
    return r'updateBabyFoodRecordUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<UpdateBabyFoodRecord> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UpdateBabyFoodRecord create(Ref ref) {
    final argument = this.argument as String;
    return updateBabyFoodRecordUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateBabyFoodRecord value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateBabyFoodRecord>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateBabyFoodRecordUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$updateBabyFoodRecordUseCaseHash() =>
    r'15f1de9db5534a8431af8e7bc267b5cd017182ae';

final class UpdateBabyFoodRecordUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<UpdateBabyFoodRecord, String> {
  const UpdateBabyFoodRecordUseCaseFamily._()
      : super(
          retry: null,
          name: r'updateBabyFoodRecordUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UpdateBabyFoodRecordUseCaseProvider call(
    String householdId,
  ) =>
      UpdateBabyFoodRecordUseCaseProvider._(argument: householdId, from: this);

  @override
  String toString() => r'updateBabyFoodRecordUseCaseProvider';
}

@ProviderFor(deleteBabyFoodRecordUseCase)
const deleteBabyFoodRecordUseCaseProvider =
    DeleteBabyFoodRecordUseCaseFamily._();

final class DeleteBabyFoodRecordUseCaseProvider extends $FunctionalProvider<
    DeleteBabyFoodRecord,
    DeleteBabyFoodRecord,
    DeleteBabyFoodRecord> with $Provider<DeleteBabyFoodRecord> {
  const DeleteBabyFoodRecordUseCaseProvider._(
      {required DeleteBabyFoodRecordUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'deleteBabyFoodRecordUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$deleteBabyFoodRecordUseCaseHash();

  @override
  String toString() {
    return r'deleteBabyFoodRecordUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<DeleteBabyFoodRecord> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeleteBabyFoodRecord create(Ref ref) {
    final argument = this.argument as String;
    return deleteBabyFoodRecordUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteBabyFoodRecord value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteBabyFoodRecord>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteBabyFoodRecordUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deleteBabyFoodRecordUseCaseHash() =>
    r'b7e59824e0fa21a67c02ad619aa30eacf01835af';

final class DeleteBabyFoodRecordUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<DeleteBabyFoodRecord, String> {
  const DeleteBabyFoodRecordUseCaseFamily._()
      : super(
          retry: null,
          name: r'deleteBabyFoodRecordUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  DeleteBabyFoodRecordUseCaseProvider call(
    String householdId,
  ) =>
      DeleteBabyFoodRecordUseCaseProvider._(argument: householdId, from: this);

  @override
  String toString() => r'deleteBabyFoodRecordUseCaseProvider';
}

@ProviderFor(watchBabyFoodRecordsUseCase)
const watchBabyFoodRecordsUseCaseProvider =
    WatchBabyFoodRecordsUseCaseFamily._();

final class WatchBabyFoodRecordsUseCaseProvider extends $FunctionalProvider<
    WatchBabyFoodRecords,
    WatchBabyFoodRecords,
    WatchBabyFoodRecords> with $Provider<WatchBabyFoodRecords> {
  const WatchBabyFoodRecordsUseCaseProvider._(
      {required WatchBabyFoodRecordsUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'watchBabyFoodRecordsUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$watchBabyFoodRecordsUseCaseHash();

  @override
  String toString() {
    return r'watchBabyFoodRecordsUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<WatchBabyFoodRecords> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchBabyFoodRecords create(Ref ref) {
    final argument = this.argument as String;
    return watchBabyFoodRecordsUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchBabyFoodRecords value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchBabyFoodRecords>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WatchBabyFoodRecordsUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$watchBabyFoodRecordsUseCaseHash() =>
    r'4a6c87d35e2c0a91d9a85326b1999f1fe0674d6a';

final class WatchBabyFoodRecordsUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<WatchBabyFoodRecords, String> {
  const WatchBabyFoodRecordsUseCaseFamily._()
      : super(
          retry: null,
          name: r'watchBabyFoodRecordsUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  WatchBabyFoodRecordsUseCaseProvider call(
    String householdId,
  ) =>
      WatchBabyFoodRecordsUseCaseProvider._(argument: householdId, from: this);

  @override
  String toString() => r'watchBabyFoodRecordsUseCaseProvider';
}

@ProviderFor(addCustomIngredientUseCase)
const addCustomIngredientUseCaseProvider = AddCustomIngredientUseCaseFamily._();

final class AddCustomIngredientUseCaseProvider extends $FunctionalProvider<
    AddCustomIngredient,
    AddCustomIngredient,
    AddCustomIngredient> with $Provider<AddCustomIngredient> {
  const AddCustomIngredientUseCaseProvider._(
      {required AddCustomIngredientUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'addCustomIngredientUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$addCustomIngredientUseCaseHash();

  @override
  String toString() {
    return r'addCustomIngredientUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<AddCustomIngredient> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AddCustomIngredient create(Ref ref) {
    final argument = this.argument as String;
    return addCustomIngredientUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddCustomIngredient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddCustomIngredient>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AddCustomIngredientUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$addCustomIngredientUseCaseHash() =>
    r'19d7f8b40f87933ddcc1e828045aff6b5db31067';

final class AddCustomIngredientUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<AddCustomIngredient, String> {
  const AddCustomIngredientUseCaseFamily._()
      : super(
          retry: null,
          name: r'addCustomIngredientUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  AddCustomIngredientUseCaseProvider call(
    String householdId,
  ) =>
      AddCustomIngredientUseCaseProvider._(argument: householdId, from: this);

  @override
  String toString() => r'addCustomIngredientUseCaseProvider';
}

@ProviderFor(deleteCustomIngredientUseCase)
const deleteCustomIngredientUseCaseProvider =
    DeleteCustomIngredientUseCaseFamily._();

final class DeleteCustomIngredientUseCaseProvider extends $FunctionalProvider<
    DeleteCustomIngredient,
    DeleteCustomIngredient,
    DeleteCustomIngredient> with $Provider<DeleteCustomIngredient> {
  const DeleteCustomIngredientUseCaseProvider._(
      {required DeleteCustomIngredientUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'deleteCustomIngredientUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$deleteCustomIngredientUseCaseHash();

  @override
  String toString() {
    return r'deleteCustomIngredientUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<DeleteCustomIngredient> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeleteCustomIngredient create(Ref ref) {
    final argument = this.argument as String;
    return deleteCustomIngredientUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteCustomIngredient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteCustomIngredient>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteCustomIngredientUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deleteCustomIngredientUseCaseHash() =>
    r'ee40b073ef0359aaadd85cb4d050dab6365e4ffb';

final class DeleteCustomIngredientUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<DeleteCustomIngredient, String> {
  const DeleteCustomIngredientUseCaseFamily._()
      : super(
          retry: null,
          name: r'deleteCustomIngredientUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  DeleteCustomIngredientUseCaseProvider call(
    String householdId,
  ) =>
      DeleteCustomIngredientUseCaseProvider._(
          argument: householdId, from: this);

  @override
  String toString() => r'deleteCustomIngredientUseCaseProvider';
}

@ProviderFor(watchCustomIngredientsUseCase)
const watchCustomIngredientsUseCaseProvider =
    WatchCustomIngredientsUseCaseFamily._();

final class WatchCustomIngredientsUseCaseProvider extends $FunctionalProvider<
    WatchCustomIngredients,
    WatchCustomIngredients,
    WatchCustomIngredients> with $Provider<WatchCustomIngredients> {
  const WatchCustomIngredientsUseCaseProvider._(
      {required WatchCustomIngredientsUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'watchCustomIngredientsUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$watchCustomIngredientsUseCaseHash();

  @override
  String toString() {
    return r'watchCustomIngredientsUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<WatchCustomIngredients> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchCustomIngredients create(Ref ref) {
    final argument = this.argument as String;
    return watchCustomIngredientsUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchCustomIngredients value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchCustomIngredients>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WatchCustomIngredientsUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$watchCustomIngredientsUseCaseHash() =>
    r'd29d0f82f7185ab05310ac5a63898cc625c3b2c2';

final class WatchCustomIngredientsUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<WatchCustomIngredients, String> {
  const WatchCustomIngredientsUseCaseFamily._()
      : super(
          retry: null,
          name: r'watchCustomIngredientsUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  WatchCustomIngredientsUseCaseProvider call(
    String householdId,
  ) =>
      WatchCustomIngredientsUseCaseProvider._(
          argument: householdId, from: this);

  @override
  String toString() => r'watchCustomIngredientsUseCaseProvider';
}

/// 指定した日の離乳食記録を監視

@ProviderFor(dailyBabyFoodRecords)
const dailyBabyFoodRecordsProvider = DailyBabyFoodRecordsFamily._();

/// 指定した日の離乳食記録を監視

final class DailyBabyFoodRecordsProvider extends $FunctionalProvider<
        AsyncValue<List<BabyFoodRecord>>,
        List<BabyFoodRecord>,
        Stream<List<BabyFoodRecord>>>
    with
        $FutureModifier<List<BabyFoodRecord>>,
        $StreamProvider<List<BabyFoodRecord>> {
  /// 指定した日の離乳食記録を監視
  const DailyBabyFoodRecordsProvider._(
      {required DailyBabyFoodRecordsFamily super.from,
      required DailyBabyFoodRecordsQuery super.argument})
      : super(
          retry: null,
          name: r'dailyBabyFoodRecordsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dailyBabyFoodRecordsHash();

  @override
  String toString() {
    return r'dailyBabyFoodRecordsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<BabyFoodRecord>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<BabyFoodRecord>> create(Ref ref) {
    final argument = this.argument as DailyBabyFoodRecordsQuery;
    return dailyBabyFoodRecords(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DailyBabyFoodRecordsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dailyBabyFoodRecordsHash() =>
    r'427e81299624dbd9e84fe53b2141a05e0f19d5d7';

/// 指定した日の離乳食記録を監視

final class DailyBabyFoodRecordsFamily extends $Family
    with
        $FunctionalFamilyOverride<Stream<List<BabyFoodRecord>>,
            DailyBabyFoodRecordsQuery> {
  const DailyBabyFoodRecordsFamily._()
      : super(
          retry: null,
          name: r'dailyBabyFoodRecordsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// 指定した日の離乳食記録を監視

  DailyBabyFoodRecordsProvider call(
    DailyBabyFoodRecordsQuery query,
  ) =>
      DailyBabyFoodRecordsProvider._(argument: query, from: this);

  @override
  String toString() => r'dailyBabyFoodRecordsProvider';
}

/// 全ての離乳食記録を監視

@ProviderFor(watchBabyFoodRecords)
const watchBabyFoodRecordsProvider = WatchBabyFoodRecordsFamily._();

/// 全ての離乳食記録を監視

final class WatchBabyFoodRecordsProvider extends $FunctionalProvider<
        AsyncValue<List<BabyFoodRecord>>,
        List<BabyFoodRecord>,
        Stream<List<BabyFoodRecord>>>
    with
        $FutureModifier<List<BabyFoodRecord>>,
        $StreamProvider<List<BabyFoodRecord>> {
  /// 全ての離乳食記録を監視
  const WatchBabyFoodRecordsProvider._(
      {required WatchBabyFoodRecordsFamily super.from,
      required ({
        String householdId,
        String childId,
      })
          super.argument})
      : super(
          retry: null,
          name: r'watchBabyFoodRecordsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$watchBabyFoodRecordsHash();

  @override
  String toString() {
    return r'watchBabyFoodRecordsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<BabyFoodRecord>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<BabyFoodRecord>> create(Ref ref) {
    final argument = this.argument as ({
      String householdId,
      String childId,
    });
    return watchBabyFoodRecords(
      ref,
      householdId: argument.householdId,
      childId: argument.childId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WatchBabyFoodRecordsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$watchBabyFoodRecordsHash() =>
    r'd1714c14df58b1b1d1c12a18a3383d75deef5efb';

/// 全ての離乳食記録を監視

final class WatchBabyFoodRecordsFamily extends $Family
    with
        $FunctionalFamilyOverride<
            Stream<List<BabyFoodRecord>>,
            ({
              String householdId,
              String childId,
            })> {
  const WatchBabyFoodRecordsFamily._()
      : super(
          retry: null,
          name: r'watchBabyFoodRecordsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// 全ての離乳食記録を監視

  WatchBabyFoodRecordsProvider call({
    required String householdId,
    required String childId,
  }) =>
      WatchBabyFoodRecordsProvider._(argument: (
        householdId: householdId,
        childId: childId,
      ), from: this);

  @override
  String toString() => r'watchBabyFoodRecordsProvider';
}

/// カスタム食材を監視

@ProviderFor(customIngredients)
const customIngredientsProvider = CustomIngredientsFamily._();

/// カスタム食材を監視

final class CustomIngredientsProvider extends $FunctionalProvider<
        AsyncValue<List<CustomIngredient>>,
        List<CustomIngredient>,
        Stream<List<CustomIngredient>>>
    with
        $FutureModifier<List<CustomIngredient>>,
        $StreamProvider<List<CustomIngredient>> {
  /// カスタム食材を監視
  const CustomIngredientsProvider._(
      {required CustomIngredientsFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'customIngredientsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$customIngredientsHash();

  @override
  String toString() {
    return r'customIngredientsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<CustomIngredient>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<CustomIngredient>> create(Ref ref) {
    final argument = this.argument as String;
    return customIngredients(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CustomIngredientsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$customIngredientsHash() => r'570d75a9c20840c7a795274d35736f050481eae7';

/// カスタム食材を監視

final class CustomIngredientsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<CustomIngredient>>, String> {
  const CustomIngredientsFamily._()
      : super(
          retry: null,
          name: r'customIngredientsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// カスタム食材を監視

  CustomIngredientsProvider call(
    String householdId,
  ) =>
      CustomIngredientsProvider._(argument: householdId, from: this);

  @override
  String toString() => r'customIngredientsProvider';
}

/// 非表示食材IDを監視

@ProviderFor(hiddenIngredients)
const hiddenIngredientsProvider = HiddenIngredientsFamily._();

/// 非表示食材IDを監視

final class HiddenIngredientsProvider extends $FunctionalProvider<
        AsyncValue<Set<String>>, Set<String>, Stream<Set<String>>>
    with $FutureModifier<Set<String>>, $StreamProvider<Set<String>> {
  /// 非表示食材IDを監視
  const HiddenIngredientsProvider._(
      {required HiddenIngredientsFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'hiddenIngredientsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$hiddenIngredientsHash();

  @override
  String toString() {
    return r'hiddenIngredientsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Set<String>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Set<String>> create(Ref ref) {
    final argument = this.argument as String;
    return hiddenIngredients(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HiddenIngredientsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hiddenIngredientsHash() => r'53f1d9498a9b4f52af82d3fd91e538676f74ebc9';

/// 非表示食材IDを監視

final class HiddenIngredientsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Set<String>>, String> {
  const HiddenIngredientsFamily._()
      : super(
          retry: null,
          name: r'hiddenIngredientsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// 非表示食材IDを監視

  HiddenIngredientsProvider call(
    String householdId,
  ) =>
      HiddenIngredientsProvider._(argument: householdId, from: this);

  @override
  String toString() => r'hiddenIngredientsProvider';
}
