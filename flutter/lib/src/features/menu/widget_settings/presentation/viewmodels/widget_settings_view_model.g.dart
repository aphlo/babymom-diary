// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_settings_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WidgetSettingsViewModel)
const widgetSettingsViewModelProvider = WidgetSettingsViewModelProvider._();

final class WidgetSettingsViewModelProvider
    extends $NotifierProvider<WidgetSettingsViewModel, WidgetSettingsState> {
  const WidgetSettingsViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'widgetSettingsViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$widgetSettingsViewModelHash();

  @$internal
  @override
  WidgetSettingsViewModel create() => WidgetSettingsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WidgetSettingsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WidgetSettingsState>(value),
    );
  }
}

String _$widgetSettingsViewModelHash() =>
    r'86d56f074581b54dddd7ca915ba8f23a5d5a5458';

abstract class _$WidgetSettingsViewModel
    extends $Notifier<WidgetSettingsState> {
  WidgetSettingsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<WidgetSettingsState, WidgetSettingsState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<WidgetSettingsState, WidgetSettingsState>,
        WidgetSettingsState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
