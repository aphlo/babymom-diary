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

String _$appThemeHash() => r'36ee74221999cb135812b1d1924eb33b011fc0aa';

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

/// ダークモード用のテーマProvider

@ProviderFor(appDarkTheme)
const appDarkThemeProvider = AppDarkThemeFamily._();

/// ダークモード用のテーマProvider

final class AppDarkThemeProvider
    extends $FunctionalProvider<ThemeData, ThemeData, ThemeData>
    with $Provider<ThemeData> {
  /// ダークモード用のテーマProvider
  const AppDarkThemeProvider._(
      {required AppDarkThemeFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'appDarkThemeProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appDarkThemeHash();

  @override
  String toString() {
    return r'appDarkThemeProvider'
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
    return appDarkTheme(
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
    return other is AppDarkThemeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$appDarkThemeHash() => r'2fab3cbc60fb4fad13ce9c68ea5feb1f6d736b0a';

/// ダークモード用のテーマProvider

final class AppDarkThemeFamily extends $Family
    with $FunctionalFamilyOverride<ThemeData, String> {
  const AppDarkThemeFamily._()
      : super(
          retry: null,
          name: r'appDarkThemeProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  /// ダークモード用のテーマProvider

  AppDarkThemeProvider call(
    String householdId,
  ) =>
      AppDarkThemeProvider._(argument: householdId, from: this);

  @override
  String toString() => r'appDarkThemeProvider';
}
