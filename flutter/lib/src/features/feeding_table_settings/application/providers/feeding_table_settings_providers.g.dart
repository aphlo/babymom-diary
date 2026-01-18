// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeding_table_settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 授乳表設定をStreamで提供するProvider

@ProviderFor(feedingTableSettingsStream)
const feedingTableSettingsStreamProvider =
    FeedingTableSettingsStreamProvider._();

/// 授乳表設定をStreamで提供するProvider

final class FeedingTableSettingsStreamProvider extends $FunctionalProvider<
        AsyncValue<FeedingTableSettings>,
        FeedingTableSettings,
        Stream<FeedingTableSettings>>
    with
        $FutureModifier<FeedingTableSettings>,
        $StreamProvider<FeedingTableSettings> {
  /// 授乳表設定をStreamで提供するProvider
  const FeedingTableSettingsStreamProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'feedingTableSettingsStreamProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$feedingTableSettingsStreamHash();

  @$internal
  @override
  $StreamProviderElement<FeedingTableSettings> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<FeedingTableSettings> create(Ref ref) {
    return feedingTableSettingsStream(ref);
  }
}

String _$feedingTableSettingsStreamHash() =>
    r'5c981f20514f7eff60816295bc167c73cb1777ff';

/// 現在の授乳表設定を取得するProvider

@ProviderFor(feedingTableSettings)
const feedingTableSettingsProvider = FeedingTableSettingsProvider._();

/// 現在の授乳表設定を取得するProvider

final class FeedingTableSettingsProvider extends $FunctionalProvider<
        AsyncValue<FeedingTableSettings>,
        FeedingTableSettings,
        FutureOr<FeedingTableSettings>>
    with
        $FutureModifier<FeedingTableSettings>,
        $FutureProvider<FeedingTableSettings> {
  /// 現在の授乳表設定を取得するProvider
  const FeedingTableSettingsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'feedingTableSettingsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$feedingTableSettingsHash();

  @$internal
  @override
  $FutureProviderElement<FeedingTableSettings> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<FeedingTableSettings> create(Ref ref) {
    return feedingTableSettings(ref);
  }
}

String _$feedingTableSettingsHash() =>
    r'5c4e81824c786c2990bb4f897a2c23296ee09756';
