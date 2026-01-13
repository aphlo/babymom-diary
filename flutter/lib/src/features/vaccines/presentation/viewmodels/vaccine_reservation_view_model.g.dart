// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccine_reservation_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VaccineReservationViewModel)
const vaccineReservationViewModelProvider =
    VaccineReservationViewModelFamily._();

final class VaccineReservationViewModelProvider extends $NotifierProvider<
    VaccineReservationViewModel, VaccineReservationState> {
  const VaccineReservationViewModelProvider._(
      {required VaccineReservationViewModelFamily super.from,
      required VaccineReservationParams super.argument})
      : super(
          retry: null,
          name: r'vaccineReservationViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$vaccineReservationViewModelHash();

  @override
  String toString() {
    return r'vaccineReservationViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VaccineReservationViewModel create() => VaccineReservationViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VaccineReservationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VaccineReservationState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VaccineReservationViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vaccineReservationViewModelHash() =>
    r'a21b305bdf86a21f468be0d3655c009d430f9c9f';

final class VaccineReservationViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
            VaccineReservationViewModel,
            VaccineReservationState,
            VaccineReservationState,
            VaccineReservationState,
            VaccineReservationParams> {
  const VaccineReservationViewModelFamily._()
      : super(
          retry: null,
          name: r'vaccineReservationViewModelProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  VaccineReservationViewModelProvider call(
    VaccineReservationParams params,
  ) =>
      VaccineReservationViewModelProvider._(argument: params, from: this);

  @override
  String toString() => r'vaccineReservationViewModelProvider';
}

abstract class _$VaccineReservationViewModel
    extends $Notifier<VaccineReservationState> {
  late final _$args = ref.$arg as VaccineReservationParams;
  VaccineReservationParams get params => _$args;

  VaccineReservationState build(
    VaccineReservationParams params,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref =
        this.ref as $Ref<VaccineReservationState, VaccineReservationState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<VaccineReservationState, VaccineReservationState>,
        VaccineReservationState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
