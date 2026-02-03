// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationSettingsDataSource)
const notificationSettingsDataSourceProvider =
    NotificationSettingsDataSourceProvider._();

final class NotificationSettingsDataSourceProvider extends $FunctionalProvider<
        NotificationSettingsFirestoreDataSource,
        NotificationSettingsFirestoreDataSource,
        NotificationSettingsFirestoreDataSource>
    with $Provider<NotificationSettingsFirestoreDataSource> {
  const NotificationSettingsDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'notificationSettingsDataSourceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$notificationSettingsDataSourceHash();

  @$internal
  @override
  $ProviderElement<NotificationSettingsFirestoreDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NotificationSettingsFirestoreDataSource create(Ref ref) {
    return notificationSettingsDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationSettingsFirestoreDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<NotificationSettingsFirestoreDataSource>(value),
    );
  }
}

String _$notificationSettingsDataSourceHash() =>
    r'e3420601ea1a6bc65569ea9d308e00c82fc441e1';

@ProviderFor(fcmDataSource)
const fcmDataSourceProvider = FcmDataSourceProvider._();

final class FcmDataSourceProvider
    extends $FunctionalProvider<FcmDataSource, FcmDataSource, FcmDataSource>
    with $Provider<FcmDataSource> {
  const FcmDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'fcmDataSourceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fcmDataSourceHash();

  @$internal
  @override
  $ProviderElement<FcmDataSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FcmDataSource create(Ref ref) {
    return fcmDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FcmDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FcmDataSource>(value),
    );
  }
}

String _$fcmDataSourceHash() => r'739dc879a2073dcdd33760967bd7fdc20d961308';

@ProviderFor(notificationRepository)
const notificationRepositoryProvider = NotificationRepositoryProvider._();

final class NotificationRepositoryProvider extends $FunctionalProvider<
    NotificationRepository,
    NotificationRepository,
    NotificationRepository> with $Provider<NotificationRepository> {
  const NotificationRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'notificationRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$notificationRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NotificationRepository create(Ref ref) {
    return notificationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRepository>(value),
    );
  }
}

String _$notificationRepositoryHash() =>
    r'28b959b04a41695db990edd731921aeb0b64163f';
