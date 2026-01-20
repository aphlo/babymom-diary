// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeding_table_settings_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(feedingTableSettingsRepository)
const feedingTableSettingsRepositoryProvider =
    FeedingTableSettingsRepositoryProvider._();

final class FeedingTableSettingsRepositoryProvider extends $FunctionalProvider<
        FeedingTableSettingsRepository,
        FeedingTableSettingsRepository,
        FeedingTableSettingsRepository>
    with $Provider<FeedingTableSettingsRepository> {
  const FeedingTableSettingsRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'feedingTableSettingsRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$feedingTableSettingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<FeedingTableSettingsRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FeedingTableSettingsRepository create(Ref ref) {
    return feedingTableSettingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeedingTableSettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<FeedingTableSettingsRepository>(value),
    );
  }
}

String _$feedingTableSettingsRepositoryHash() =>
    r'e31a8080b64ec1319f9db4e4a94c991fd759ca1a';
