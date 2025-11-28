// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth_chart_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(growthCurveRepository)
const growthCurveRepositoryProvider = GrowthCurveRepositoryProvider._();

final class GrowthCurveRepositoryProvider extends $FunctionalProvider<
    GrowthCurveRepository,
    GrowthCurveRepository,
    GrowthCurveRepository> with $Provider<GrowthCurveRepository> {
  const GrowthCurveRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'growthCurveRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$growthCurveRepositoryHash();

  @$internal
  @override
  $ProviderElement<GrowthCurveRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GrowthCurveRepository create(Ref ref) {
    return growthCurveRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GrowthCurveRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GrowthCurveRepository>(value),
    );
  }
}

String _$growthCurveRepositoryHash() =>
    r'662c8deafecb3a1450987d0b7f46581bd5db01f3';

@ProviderFor(getGrowthCurvesUseCase)
const getGrowthCurvesUseCaseProvider = GetGrowthCurvesUseCaseProvider._();

final class GetGrowthCurvesUseCaseProvider extends $FunctionalProvider<
    GetGrowthCurves,
    GetGrowthCurves,
    GetGrowthCurves> with $Provider<GetGrowthCurves> {
  const GetGrowthCurvesUseCaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getGrowthCurvesUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getGrowthCurvesUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetGrowthCurves> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetGrowthCurves create(Ref ref) {
    return getGrowthCurvesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetGrowthCurves value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetGrowthCurves>(value),
    );
  }
}

String _$getGrowthCurvesUseCaseHash() =>
    r'7e79449936319e737493f3edfc03fa56d30e84d3';

@ProviderFor(growthRecordRepository)
const growthRecordRepositoryProvider = GrowthRecordRepositoryFamily._();

final class GrowthRecordRepositoryProvider extends $FunctionalProvider<
    GrowthRecordRepository,
    GrowthRecordRepository,
    GrowthRecordRepository> with $Provider<GrowthRecordRepository> {
  const GrowthRecordRepositoryProvider._(
      {required GrowthRecordRepositoryFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'growthRecordRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$growthRecordRepositoryHash();

  @override
  String toString() {
    return r'growthRecordRepositoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<GrowthRecordRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GrowthRecordRepository create(Ref ref) {
    final argument = this.argument as String;
    return growthRecordRepository(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GrowthRecordRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GrowthRecordRepository>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GrowthRecordRepositoryProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$growthRecordRepositoryHash() =>
    r'7fde6ac485a7c68e706af40241c5020c1e0336de';

final class GrowthRecordRepositoryFamily extends $Family
    with $FunctionalFamilyOverride<GrowthRecordRepository, String> {
  const GrowthRecordRepositoryFamily._()
      : super(
          retry: null,
          name: r'growthRecordRepositoryProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  GrowthRecordRepositoryProvider call(
    String householdId,
  ) =>
      GrowthRecordRepositoryProvider._(argument: householdId, from: this);

  @override
  String toString() => r'growthRecordRepositoryProvider';
}

@ProviderFor(watchGrowthRecordsUseCase)
const watchGrowthRecordsUseCaseProvider = WatchGrowthRecordsUseCaseFamily._();

final class WatchGrowthRecordsUseCaseProvider extends $FunctionalProvider<
    WatchGrowthRecords,
    WatchGrowthRecords,
    WatchGrowthRecords> with $Provider<WatchGrowthRecords> {
  const WatchGrowthRecordsUseCaseProvider._(
      {required WatchGrowthRecordsUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'watchGrowthRecordsUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$watchGrowthRecordsUseCaseHash();

  @override
  String toString() {
    return r'watchGrowthRecordsUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<WatchGrowthRecords> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchGrowthRecords create(Ref ref) {
    final argument = this.argument as String;
    return watchGrowthRecordsUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchGrowthRecords value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchGrowthRecords>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WatchGrowthRecordsUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$watchGrowthRecordsUseCaseHash() =>
    r'0cecce03a3ebf05e4838f0a99b3e3486df56672b';

final class WatchGrowthRecordsUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<WatchGrowthRecords, String> {
  const WatchGrowthRecordsUseCaseFamily._()
      : super(
          retry: null,
          name: r'watchGrowthRecordsUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  WatchGrowthRecordsUseCaseProvider call(
    String householdId,
  ) =>
      WatchGrowthRecordsUseCaseProvider._(argument: householdId, from: this);

  @override
  String toString() => r'watchGrowthRecordsUseCaseProvider';
}

@ProviderFor(addGrowthRecordUseCase)
const addGrowthRecordUseCaseProvider = AddGrowthRecordUseCaseFamily._();

final class AddGrowthRecordUseCaseProvider extends $FunctionalProvider<
    AddGrowthRecord,
    AddGrowthRecord,
    AddGrowthRecord> with $Provider<AddGrowthRecord> {
  const AddGrowthRecordUseCaseProvider._(
      {required AddGrowthRecordUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'addGrowthRecordUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$addGrowthRecordUseCaseHash();

  @override
  String toString() {
    return r'addGrowthRecordUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<AddGrowthRecord> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AddGrowthRecord create(Ref ref) {
    final argument = this.argument as String;
    return addGrowthRecordUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddGrowthRecord value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddGrowthRecord>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AddGrowthRecordUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$addGrowthRecordUseCaseHash() =>
    r'2bb946b3c62d61c80750adfff84f0d5e71ee25c3';

final class AddGrowthRecordUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<AddGrowthRecord, String> {
  const AddGrowthRecordUseCaseFamily._()
      : super(
          retry: null,
          name: r'addGrowthRecordUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  AddGrowthRecordUseCaseProvider call(
    String householdId,
  ) =>
      AddGrowthRecordUseCaseProvider._(argument: householdId, from: this);

  @override
  String toString() => r'addGrowthRecordUseCaseProvider';
}

@ProviderFor(updateGrowthRecordUseCase)
const updateGrowthRecordUseCaseProvider = UpdateGrowthRecordUseCaseFamily._();

final class UpdateGrowthRecordUseCaseProvider extends $FunctionalProvider<
    UpdateGrowthRecord,
    UpdateGrowthRecord,
    UpdateGrowthRecord> with $Provider<UpdateGrowthRecord> {
  const UpdateGrowthRecordUseCaseProvider._(
      {required UpdateGrowthRecordUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'updateGrowthRecordUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$updateGrowthRecordUseCaseHash();

  @override
  String toString() {
    return r'updateGrowthRecordUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<UpdateGrowthRecord> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UpdateGrowthRecord create(Ref ref) {
    final argument = this.argument as String;
    return updateGrowthRecordUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateGrowthRecord value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateGrowthRecord>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateGrowthRecordUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$updateGrowthRecordUseCaseHash() =>
    r'354db808646f57096c388f3b8484fd5ae33226ac';

final class UpdateGrowthRecordUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<UpdateGrowthRecord, String> {
  const UpdateGrowthRecordUseCaseFamily._()
      : super(
          retry: null,
          name: r'updateGrowthRecordUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UpdateGrowthRecordUseCaseProvider call(
    String householdId,
  ) =>
      UpdateGrowthRecordUseCaseProvider._(argument: householdId, from: this);

  @override
  String toString() => r'updateGrowthRecordUseCaseProvider';
}

@ProviderFor(deleteGrowthRecordUseCase)
const deleteGrowthRecordUseCaseProvider = DeleteGrowthRecordUseCaseFamily._();

final class DeleteGrowthRecordUseCaseProvider extends $FunctionalProvider<
    DeleteGrowthRecord,
    DeleteGrowthRecord,
    DeleteGrowthRecord> with $Provider<DeleteGrowthRecord> {
  const DeleteGrowthRecordUseCaseProvider._(
      {required DeleteGrowthRecordUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'deleteGrowthRecordUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$deleteGrowthRecordUseCaseHash();

  @override
  String toString() {
    return r'deleteGrowthRecordUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<DeleteGrowthRecord> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeleteGrowthRecord create(Ref ref) {
    final argument = this.argument as String;
    return deleteGrowthRecordUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteGrowthRecord value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteGrowthRecord>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteGrowthRecordUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deleteGrowthRecordUseCaseHash() =>
    r'35bce9b9125ebd368c3255fd38b3fa90d503a89c';

final class DeleteGrowthRecordUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<DeleteGrowthRecord, String> {
  const DeleteGrowthRecordUseCaseFamily._()
      : super(
          retry: null,
          name: r'deleteGrowthRecordUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  DeleteGrowthRecordUseCaseProvider call(
    String householdId,
  ) =>
      DeleteGrowthRecordUseCaseProvider._(argument: householdId, from: this);

  @override
  String toString() => r'deleteGrowthRecordUseCaseProvider';
}
