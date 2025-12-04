// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RecordViewModel)
const recordViewModelProvider = RecordViewModelProvider._();

final class RecordViewModelProvider
    extends $NotifierProvider<RecordViewModel, RecordPageState> {
  const RecordViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'recordViewModelProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$recordViewModelHash();

  @$internal
  @override
  RecordViewModel create() => RecordViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecordPageState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecordPageState>(value),
    );
  }
}

String _$recordViewModelHash() => r'070706e6cd03093eed66a1b002c16f02dac255d6';

abstract class _$RecordViewModel extends $Notifier<RecordPageState> {
  RecordPageState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<RecordPageState, RecordPageState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<RecordPageState, RecordPageState>,
        RecordPageState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
