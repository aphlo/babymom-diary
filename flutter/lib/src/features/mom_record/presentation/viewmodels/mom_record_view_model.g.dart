// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mom_record_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MomRecordViewModel)
const momRecordViewModelProvider = MomRecordViewModelProvider._();

final class MomRecordViewModelProvider
    extends $NotifierProvider<MomRecordViewModel, MomRecordPageState> {
  const MomRecordViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'momRecordViewModelProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$momRecordViewModelHash();

  @$internal
  @override
  MomRecordViewModel create() => MomRecordViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MomRecordPageState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MomRecordPageState>(value),
    );
  }
}

String _$momRecordViewModelHash() =>
    r'ce7d705f0b0792191241dfad68fa2c07b718d27c';

abstract class _$MomRecordViewModel extends $Notifier<MomRecordPageState> {
  MomRecordPageState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<MomRecordPageState, MomRecordPageState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<MomRecordPageState, MomRecordPageState>,
        MomRecordPageState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
