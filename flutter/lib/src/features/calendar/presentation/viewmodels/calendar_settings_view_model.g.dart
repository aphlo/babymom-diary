// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_settings_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CalendarSettingsViewModel)
const calendarSettingsViewModelProvider = CalendarSettingsViewModelProvider._();

final class CalendarSettingsViewModelProvider extends $NotifierProvider<
    CalendarSettingsViewModel, CalendarSettingsState> {
  const CalendarSettingsViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'calendarSettingsViewModelProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$calendarSettingsViewModelHash();

  @$internal
  @override
  CalendarSettingsViewModel create() => CalendarSettingsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarSettingsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarSettingsState>(value),
    );
  }
}

String _$calendarSettingsViewModelHash() =>
    r'60bce3110b66040f2480aa047e9fb6df4206770a';

abstract class _$CalendarSettingsViewModel
    extends $Notifier<CalendarSettingsState> {
  CalendarSettingsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CalendarSettingsState, CalendarSettingsState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<CalendarSettingsState, CalendarSettingsState>,
        CalendarSettingsState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
