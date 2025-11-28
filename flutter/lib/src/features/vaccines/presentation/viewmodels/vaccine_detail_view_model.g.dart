// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccine_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VaccineDetailViewModel)
const vaccineDetailViewModelProvider = VaccineDetailViewModelFamily._();

final class VaccineDetailViewModelProvider
    extends $NotifierProvider<VaccineDetailViewModel, VaccineDetailState> {
  const VaccineDetailViewModelProvider._(
      {required VaccineDetailViewModelFamily super.from,
      required VaccineDetailParams super.argument})
      : super(
          retry: null,
          name: r'vaccineDetailViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$vaccineDetailViewModelHash();

  @override
  String toString() {
    return r'vaccineDetailViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VaccineDetailViewModel create() => VaccineDetailViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VaccineDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VaccineDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VaccineDetailViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vaccineDetailViewModelHash() =>
    r'eb77ef06d6998ee22f04f42ed49907bde9d04ae1';

final class VaccineDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<VaccineDetailViewModel, VaccineDetailState,
            VaccineDetailState, VaccineDetailState, VaccineDetailParams> {
  const VaccineDetailViewModelFamily._()
      : super(
          retry: null,
          name: r'vaccineDetailViewModelProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  VaccineDetailViewModelProvider call(
    VaccineDetailParams params,
  ) =>
      VaccineDetailViewModelProvider._(argument: params, from: this);

  @override
  String toString() => r'vaccineDetailViewModelProvider';
}

abstract class _$VaccineDetailViewModel extends $Notifier<VaccineDetailState> {
  late final _$args = ref.$arg as VaccineDetailParams;
  VaccineDetailParams get params => _$args;

  VaccineDetailState build(
    VaccineDetailParams params,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<VaccineDetailState, VaccineDetailState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<VaccineDetailState, VaccineDetailState>,
        VaccineDetailState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
