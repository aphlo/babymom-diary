// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_management_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for DataManagementRepository

@ProviderFor(dataManagementRepository)
const dataManagementRepositoryProvider = DataManagementRepositoryProvider._();

/// Provider for DataManagementRepository

final class DataManagementRepositoryProvider extends $FunctionalProvider<
    DataManagementRepository,
    DataManagementRepository,
    DataManagementRepository> with $Provider<DataManagementRepository> {
  /// Provider for DataManagementRepository
  const DataManagementRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'dataManagementRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dataManagementRepositoryHash();

  @$internal
  @override
  $ProviderElement<DataManagementRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DataManagementRepository create(Ref ref) {
    return dataManagementRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DataManagementRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DataManagementRepository>(value),
    );
  }
}

String _$dataManagementRepositoryHash() =>
    r'14622df80f8129c1201db1d0881f6a36ec982e8b';

/// Provider for DeleteAllHouseholdData use case

@ProviderFor(deleteAllHouseholdData)
const deleteAllHouseholdDataProvider = DeleteAllHouseholdDataProvider._();

/// Provider for DeleteAllHouseholdData use case

final class DeleteAllHouseholdDataProvider extends $FunctionalProvider<
    DeleteAllHouseholdData,
    DeleteAllHouseholdData,
    DeleteAllHouseholdData> with $Provider<DeleteAllHouseholdData> {
  /// Provider for DeleteAllHouseholdData use case
  const DeleteAllHouseholdDataProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'deleteAllHouseholdDataProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$deleteAllHouseholdDataHash();

  @$internal
  @override
  $ProviderElement<DeleteAllHouseholdData> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeleteAllHouseholdData create(Ref ref) {
    return deleteAllHouseholdData(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteAllHouseholdData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteAllHouseholdData>(value),
    );
  }
}

String _$deleteAllHouseholdDataHash() =>
    r'b1f330c8f221aec19328af60f84d29132eee84d7';
