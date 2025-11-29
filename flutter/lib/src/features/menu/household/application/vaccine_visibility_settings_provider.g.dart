// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccine_visibility_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ワクチン表示設定リポジトリのプロバイダー

@ProviderFor(vaccineVisibilitySettingsRepository)
const vaccineVisibilitySettingsRepositoryProvider =
    VaccineVisibilitySettingsRepositoryProvider._();

/// ワクチン表示設定リポジトリのプロバイダー

final class VaccineVisibilitySettingsRepositoryProvider
    extends $FunctionalProvider<
        VaccineVisibilitySettingsRepository,
        VaccineVisibilitySettingsRepository,
        VaccineVisibilitySettingsRepository>
    with $Provider<VaccineVisibilitySettingsRepository> {
  /// ワクチン表示設定リポジトリのプロバイダー
  const VaccineVisibilitySettingsRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'vaccineVisibilitySettingsRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() =>
      _$vaccineVisibilitySettingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<VaccineVisibilitySettingsRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VaccineVisibilitySettingsRepository create(Ref ref) {
    return vaccineVisibilitySettingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VaccineVisibilitySettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<VaccineVisibilitySettingsRepository>(value),
    );
  }
}

String _$vaccineVisibilitySettingsRepositoryHash() =>
    r'08cfd4da79855de5b00cffbe5939f12bce80f227';
