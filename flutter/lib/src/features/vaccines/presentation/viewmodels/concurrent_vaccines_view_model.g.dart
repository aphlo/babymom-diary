// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concurrent_vaccines_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ConcurrentVaccinesViewModel)
const concurrentVaccinesViewModelProvider =
    ConcurrentVaccinesViewModelFamily._();

final class ConcurrentVaccinesViewModelProvider extends $NotifierProvider<
    ConcurrentVaccinesViewModel, ConcurrentVaccinesState> {
  const ConcurrentVaccinesViewModelProvider._(
      {required ConcurrentVaccinesViewModelFamily super.from,
      required ConcurrentVaccinesParams super.argument})
      : super(
          retry: null,
          name: r'concurrentVaccinesViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$concurrentVaccinesViewModelHash();

  @override
  String toString() {
    return r'concurrentVaccinesViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ConcurrentVaccinesViewModel create() => ConcurrentVaccinesViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConcurrentVaccinesState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConcurrentVaccinesState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ConcurrentVaccinesViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$concurrentVaccinesViewModelHash() =>
    r'aeee2caaaaea4d31e3e133f81b58bc18760d1fef';

final class ConcurrentVaccinesViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
            ConcurrentVaccinesViewModel,
            ConcurrentVaccinesState,
            ConcurrentVaccinesState,
            ConcurrentVaccinesState,
            ConcurrentVaccinesParams> {
  const ConcurrentVaccinesViewModelFamily._()
      : super(
          retry: null,
          name: r'concurrentVaccinesViewModelProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ConcurrentVaccinesViewModelProvider call(
    ConcurrentVaccinesParams params,
  ) =>
      ConcurrentVaccinesViewModelProvider._(argument: params, from: this);

  @override
  String toString() => r'concurrentVaccinesViewModelProvider';
}

abstract class _$ConcurrentVaccinesViewModel
    extends $Notifier<ConcurrentVaccinesState> {
  late final _$args = ref.$arg as ConcurrentVaccinesParams;
  ConcurrentVaccinesParams get params => _$args;

  ConcurrentVaccinesState build(
    ConcurrentVaccinesParams params,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref =
        this.ref as $Ref<ConcurrentVaccinesState, ConcurrentVaccinesState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ConcurrentVaccinesState, ConcurrentVaccinesState>,
        ConcurrentVaccinesState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
