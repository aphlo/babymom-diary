// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccine_settings_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vaccineSettingsRepository)
const vaccineSettingsRepositoryProvider = VaccineSettingsRepositoryProvider._();

final class VaccineSettingsRepositoryProvider extends $FunctionalProvider<
    VaccineSettingsRepository,
    VaccineSettingsRepository,
    VaccineSettingsRepository> with $Provider<VaccineSettingsRepository> {
  const VaccineSettingsRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'vaccineSettingsRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$vaccineSettingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<VaccineSettingsRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VaccineSettingsRepository create(Ref ref) {
    return vaccineSettingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VaccineSettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VaccineSettingsRepository>(value),
    );
  }
}

String _$vaccineSettingsRepositoryHash() =>
    r'00d54c8b9a25331cf63b89e60de52f45a4c60d8c';
