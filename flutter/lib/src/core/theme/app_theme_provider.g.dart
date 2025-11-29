// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appTheme)
const appThemeProvider = AppThemeFamily._();

final class AppThemeProvider
    extends $FunctionalProvider<ThemeData, ThemeData, ThemeData>
    with $Provider<ThemeData> {
  const AppThemeProvider._(
      {required AppThemeFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'appThemeProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appThemeHash();

  @override
  String toString() {
    return r'appThemeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<ThemeData> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeData create(Ref ref) {
    final argument = this.argument as String;
    return appTheme(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeData>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AppThemeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$appThemeHash() => r'3e2b2594eaf3129600facf03280d1e2803a15670';

final class AppThemeFamily extends $Family
    with $FunctionalFamilyOverride<ThemeData, String> {
  const AppThemeFamily._()
      : super(
          retry: null,
          name: r'appThemeProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  AppThemeProvider call(
    String householdId,
  ) =>
      AppThemeProvider._(argument: householdId, from: this);

  @override
  String toString() => r'appThemeProvider';
}
