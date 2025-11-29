// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccine_visibility_settings_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ワクチン表示設定画面のViewModel

@ProviderFor(VaccineVisibilitySettingsViewModel)
const vaccineVisibilitySettingsViewModelProvider =
    VaccineVisibilitySettingsViewModelProvider._();

/// ワクチン表示設定画面のViewModel
final class VaccineVisibilitySettingsViewModelProvider
    extends $NotifierProvider<VaccineVisibilitySettingsViewModel,
        VaccineVisibilitySettingsState> {
  /// ワクチン表示設定画面のViewModel
  const VaccineVisibilitySettingsViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'vaccineVisibilitySettingsViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() =>
      _$vaccineVisibilitySettingsViewModelHash();

  @$internal
  @override
  VaccineVisibilitySettingsViewModel create() =>
      VaccineVisibilitySettingsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VaccineVisibilitySettingsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<VaccineVisibilitySettingsState>(value),
    );
  }
}

String _$vaccineVisibilitySettingsViewModelHash() =>
    r'98835c6a3a4a8d590eeacecb100fbcbbc77002b8';

/// ワクチン表示設定画面のViewModel

abstract class _$VaccineVisibilitySettingsViewModel
    extends $Notifier<VaccineVisibilitySettingsState> {
  VaccineVisibilitySettingsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref
        as $Ref<VaccineVisibilitySettingsState, VaccineVisibilitySettingsState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<VaccineVisibilitySettingsState,
            VaccineVisibilitySettingsState>,
        VaccineVisibilitySettingsState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
