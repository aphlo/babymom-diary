// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firebaseMessaging)
const firebaseMessagingProvider = FirebaseMessagingProvider._();

final class FirebaseMessagingProvider extends $FunctionalProvider<
    FirebaseMessaging,
    FirebaseMessaging,
    FirebaseMessaging> with $Provider<FirebaseMessaging> {
  const FirebaseMessagingProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'firebaseMessagingProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firebaseMessagingHash();

  @$internal
  @override
  $ProviderElement<FirebaseMessaging> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirebaseMessaging create(Ref ref) {
    return firebaseMessaging(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseMessaging value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseMessaging>(value),
    );
  }
}

String _$firebaseMessagingHash() => r'1672e956b9febea725d18574f63c5ce88cefb132';

@ProviderFor(flutterLocalNotifications)
const flutterLocalNotificationsProvider = FlutterLocalNotificationsProvider._();

final class FlutterLocalNotificationsProvider extends $FunctionalProvider<
        FlutterLocalNotificationsPlugin,
        FlutterLocalNotificationsPlugin,
        FlutterLocalNotificationsPlugin>
    with $Provider<FlutterLocalNotificationsPlugin> {
  const FlutterLocalNotificationsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'flutterLocalNotificationsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$flutterLocalNotificationsHash();

  @$internal
  @override
  $ProviderElement<FlutterLocalNotificationsPlugin> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FlutterLocalNotificationsPlugin create(Ref ref) {
    return flutterLocalNotifications(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlutterLocalNotificationsPlugin value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<FlutterLocalNotificationsPlugin>(value),
    );
  }
}

String _$flutterLocalNotificationsHash() =>
    r'165fec726a30695d49886452a578b260f905f87d';

@ProviderFor(pushNotificationService)
const pushNotificationServiceProvider = PushNotificationServiceProvider._();

final class PushNotificationServiceProvider extends $FunctionalProvider<
    PushNotificationService,
    PushNotificationService,
    PushNotificationService> with $Provider<PushNotificationService> {
  const PushNotificationServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'pushNotificationServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$pushNotificationServiceHash();

  @$internal
  @override
  $ProviderElement<PushNotificationService> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PushNotificationService create(Ref ref) {
    return pushNotificationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PushNotificationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PushNotificationService>(value),
    );
  }
}

String _$pushNotificationServiceHash() =>
    r'c4502d130ede23f79afa64255286319da2b3268e';
