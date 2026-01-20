// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ThemeModeStorageのProvider

@ProviderFor(themeModeStorage)
const themeModeStorageProvider = ThemeModeStorageProvider._();

/// ThemeModeStorageのProvider

final class ThemeModeStorageProvider extends $FunctionalProvider<
    ThemeModeStorage,
    ThemeModeStorage,
    ThemeModeStorage> with $Provider<ThemeModeStorage> {
  /// ThemeModeStorageのProvider
  const ThemeModeStorageProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'themeModeStorageProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$themeModeStorageHash();

  @$internal
  @override
  $ProviderElement<ThemeModeStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeModeStorage create(Ref ref) {
    return themeModeStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeModeStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeModeStorage>(value),
    );
  }
}

String _$themeModeStorageHash() => r'9d8b0f550cf2428bfd3d7d0d560e254e4eb1e5a7';

/// テーマモードの状態管理Notifier

@ProviderFor(ThemeModeNotifier)
const themeModeProvider = ThemeModeNotifierProvider._();

/// テーマモードの状態管理Notifier
final class ThemeModeNotifierProvider
    extends $NotifierProvider<ThemeModeNotifier, ThemeMode> {
  /// テーマモードの状態管理Notifier
  const ThemeModeNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'themeModeProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$themeModeNotifierHash();

  @$internal
  @override
  ThemeModeNotifier create() => ThemeModeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeModeNotifierHash() => r'eea6aea017c0885bd7f1c1ea8156dc808d89adab';

/// テーマモードの状態管理Notifier

abstract class _$ThemeModeNotifier extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ThemeMode, ThemeMode>, ThemeMode, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
