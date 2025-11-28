// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccines_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VaccinesViewModel)
const vaccinesViewModelProvider = VaccinesViewModelProvider._();

final class VaccinesViewModelProvider
    extends $NotifierProvider<VaccinesViewModel, AsyncValue<VaccinesViewData>> {
  const VaccinesViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'vaccinesViewModelProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$vaccinesViewModelHash();

  @$internal
  @override
  VaccinesViewModel create() => VaccinesViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<VaccinesViewData> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<VaccinesViewData>>(value),
    );
  }
}

String _$vaccinesViewModelHash() => r'06d0c5dd3a5f19dd2770e35dd72365b04fc0af39';

abstract class _$VaccinesViewModel
    extends $Notifier<AsyncValue<VaccinesViewData>> {
  AsyncValue<VaccinesViewData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref
        as $Ref<AsyncValue<VaccinesViewData>, AsyncValue<VaccinesViewData>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<VaccinesViewData>, AsyncValue<VaccinesViewData>>,
        AsyncValue<VaccinesViewData>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
