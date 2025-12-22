// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth_chart_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GrowthChartViewModel)
const growthChartViewModelProvider = GrowthChartViewModelProvider._();

final class GrowthChartViewModelProvider
    extends $NotifierProvider<GrowthChartViewModel, GrowthChartState> {
  const GrowthChartViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'growthChartViewModelProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$growthChartViewModelHash();

  @$internal
  @override
  GrowthChartViewModel create() => GrowthChartViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GrowthChartState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GrowthChartState>(value),
    );
  }
}

String _$growthChartViewModelHash() =>
    r'9f7415202f25b098aee38d87a9ef9e41d5eeb311';

abstract class _$GrowthChartViewModel extends $Notifier<GrowthChartState> {
  GrowthChartState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<GrowthChartState, GrowthChartState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<GrowthChartState, GrowthChartState>,
        GrowthChartState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
