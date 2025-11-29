// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(calendarEventRemoteDataSource)
const calendarEventRemoteDataSourceProvider =
    CalendarEventRemoteDataSourceProvider._();

final class CalendarEventRemoteDataSourceProvider extends $FunctionalProvider<
        CalendarEventFirestoreDataSource,
        CalendarEventFirestoreDataSource,
        CalendarEventFirestoreDataSource>
    with $Provider<CalendarEventFirestoreDataSource> {
  const CalendarEventRemoteDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'calendarEventRemoteDataSourceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$calendarEventRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<CalendarEventFirestoreDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CalendarEventFirestoreDataSource create(Ref ref) {
    return calendarEventRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarEventFirestoreDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<CalendarEventFirestoreDataSource>(value),
    );
  }
}

String _$calendarEventRemoteDataSourceHash() =>
    r'b8b37a90dcb06f177cacfbcc71090bdf71c49089';

@ProviderFor(calendarEventRepository)
const calendarEventRepositoryProvider = CalendarEventRepositoryProvider._();

final class CalendarEventRepositoryProvider extends $FunctionalProvider<
    CalendarEventRepository,
    CalendarEventRepository,
    CalendarEventRepository> with $Provider<CalendarEventRepository> {
  const CalendarEventRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'calendarEventRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$calendarEventRepositoryHash();

  @$internal
  @override
  $ProviderElement<CalendarEventRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CalendarEventRepository create(Ref ref) {
    return calendarEventRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarEventRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarEventRepository>(value),
    );
  }
}

String _$calendarEventRepositoryHash() =>
    r'9fc2fa65e4ba7893a070481eac65ac9e853e5756';
