// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_settings_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(calendarSettingsRepository)
const calendarSettingsRepositoryProvider =
    CalendarSettingsRepositoryProvider._();

final class CalendarSettingsRepositoryProvider extends $FunctionalProvider<
    CalendarSettingsRepository,
    CalendarSettingsRepository,
    CalendarSettingsRepository> with $Provider<CalendarSettingsRepository> {
  const CalendarSettingsRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'calendarSettingsRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$calendarSettingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<CalendarSettingsRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CalendarSettingsRepository create(Ref ref) {
    return calendarSettingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarSettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarSettingsRepository>(value),
    );
  }
}

String _$calendarSettingsRepositoryHash() =>
    r'acceb03a7848155688d5a1d3797f6e0a631f2173';
