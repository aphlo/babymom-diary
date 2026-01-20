// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeding_table_settings_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FeedingTableSettingsViewModel)
const feedingTableSettingsViewModelProvider =
    FeedingTableSettingsViewModelProvider._();

final class FeedingTableSettingsViewModelProvider extends $NotifierProvider<
    FeedingTableSettingsViewModel, FeedingTableSettingsState> {
  const FeedingTableSettingsViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'feedingTableSettingsViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$feedingTableSettingsViewModelHash();

  @$internal
  @override
  FeedingTableSettingsViewModel create() => FeedingTableSettingsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeedingTableSettingsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeedingTableSettingsState>(value),
    );
  }
}

String _$feedingTableSettingsViewModelHash() =>
    r'7626ab47e72f977d8c5d423bd51d9547b1129623';

abstract class _$FeedingTableSettingsViewModel
    extends $Notifier<FeedingTableSettingsState> {
  FeedingTableSettingsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<FeedingTableSettingsState, FeedingTableSettingsState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<FeedingTableSettingsState, FeedingTableSettingsState>,
        FeedingTableSettingsState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
