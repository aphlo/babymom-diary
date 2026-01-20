// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccine_settings_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VaccineSettingsViewModel)
const vaccineSettingsViewModelProvider = VaccineSettingsViewModelProvider._();

final class VaccineSettingsViewModelProvider
    extends $NotifierProvider<VaccineSettingsViewModel, VaccineSettingsState> {
  const VaccineSettingsViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'vaccineSettingsViewModelProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$vaccineSettingsViewModelHash();

  @$internal
  @override
  VaccineSettingsViewModel create() => VaccineSettingsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VaccineSettingsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VaccineSettingsState>(value),
    );
  }
}

String _$vaccineSettingsViewModelHash() =>
    r'f824bc71c1d9aaa668de21fbafc61dc25af8d1aa';

abstract class _$VaccineSettingsViewModel
    extends $Notifier<VaccineSettingsState> {
  VaccineSettingsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<VaccineSettingsState, VaccineSettingsState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<VaccineSettingsState, VaccineSettingsState>,
        VaccineSettingsState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
