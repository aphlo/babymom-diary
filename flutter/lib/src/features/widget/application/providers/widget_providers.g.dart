// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// WidgetDataRepositoryプロバイダー

@ProviderFor(widgetDataRepository)
const widgetDataRepositoryProvider = WidgetDataRepositoryProvider._();

/// WidgetDataRepositoryプロバイダー

final class WidgetDataRepositoryProvider extends $FunctionalProvider<
    WidgetDataRepository,
    WidgetDataRepository,
    WidgetDataRepository> with $Provider<WidgetDataRepository> {
  /// WidgetDataRepositoryプロバイダー
  const WidgetDataRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'widgetDataRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$widgetDataRepositoryHash();

  @$internal
  @override
  $ProviderElement<WidgetDataRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WidgetDataRepository create(Ref ref) {
    return widgetDataRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WidgetDataRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WidgetDataRepository>(value),
    );
  }
}

String _$widgetDataRepositoryHash() =>
    r'1f5b5eeac237c50666e52207ba7558ffdf59eef8';

/// WidgetDataSyncServiceプロバイダー（householdIdごと）

@ProviderFor(widgetDataSyncService)
const widgetDataSyncServiceProvider = WidgetDataSyncServiceFamily._();

/// WidgetDataSyncServiceプロバイダー（householdIdごと）

final class WidgetDataSyncServiceProvider extends $FunctionalProvider<
    WidgetDataSyncService,
    WidgetDataSyncService,
    WidgetDataSyncService> with $Provider<WidgetDataSyncService> {
  /// WidgetDataSyncServiceプロバイダー（householdIdごと）
  const WidgetDataSyncServiceProvider._(
      {required WidgetDataSyncServiceFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'widgetDataSyncServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$widgetDataSyncServiceHash();

  @override
  String toString() {
    return r'widgetDataSyncServiceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<WidgetDataSyncService> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WidgetDataSyncService create(Ref ref) {
    final argument = this.argument as String;
    return widgetDataSyncService(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WidgetDataSyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WidgetDataSyncService>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WidgetDataSyncServiceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$widgetDataSyncServiceHash() =>
    r'4c5e0d97d5042c09113160eb3afd4476847bb91c';

/// WidgetDataSyncServiceプロバイダー（householdIdごと）

final class WidgetDataSyncServiceFamily extends $Family
    with $FunctionalFamilyOverride<WidgetDataSyncService, String> {
  const WidgetDataSyncServiceFamily._()
      : super(
          retry: null,
          name: r'widgetDataSyncServiceProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// WidgetDataSyncServiceプロバイダー（householdIdごと）

  WidgetDataSyncServiceProvider call(
    String householdId,
  ) =>
      WidgetDataSyncServiceProvider._(argument: householdId, from: this);

  @override
  String toString() => r'widgetDataSyncServiceProvider';
}

/// ウィジェット設定プロバイダー

@ProviderFor(WidgetSettingsNotifier)
const widgetSettingsProvider = WidgetSettingsNotifierProvider._();

/// ウィジェット設定プロバイダー
final class WidgetSettingsNotifierProvider
    extends $AsyncNotifierProvider<WidgetSettingsNotifier, WidgetSettings> {
  /// ウィジェット設定プロバイダー
  const WidgetSettingsNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'widgetSettingsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$widgetSettingsNotifierHash();

  @$internal
  @override
  WidgetSettingsNotifier create() => WidgetSettingsNotifier();
}

String _$widgetSettingsNotifierHash() =>
    r'35d911783e7fe8cde368ca516902c3b4ae19c368';

/// ウィジェット設定プロバイダー

abstract class _$WidgetSettingsNotifier extends $AsyncNotifier<WidgetSettings> {
  FutureOr<WidgetSettings> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<WidgetSettings>, WidgetSettings>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<WidgetSettings>, WidgetSettings>,
        AsyncValue<WidgetSettings>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
