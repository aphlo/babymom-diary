// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mom_diary_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MomDiaryViewModel)
const momDiaryViewModelProvider = MomDiaryViewModelProvider._();

final class MomDiaryViewModelProvider
    extends $NotifierProvider<MomDiaryViewModel, MomDiaryPageState> {
  const MomDiaryViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'momDiaryViewModelProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$momDiaryViewModelHash();

  @$internal
  @override
  MomDiaryViewModel create() => MomDiaryViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MomDiaryPageState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MomDiaryPageState>(value),
    );
  }
}

String _$momDiaryViewModelHash() => r'd96dc19cc97ffec2f00377442a632b94e20c6f26';

abstract class _$MomDiaryViewModel extends $Notifier<MomDiaryPageState> {
  MomDiaryPageState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<MomDiaryPageState, MomDiaryPageState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<MomDiaryPageState, MomDiaryPageState>,
        MomDiaryPageState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
