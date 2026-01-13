// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baby_food_sheet_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BabyFoodSheetViewModel)
const babyFoodSheetViewModelProvider = BabyFoodSheetViewModelFamily._();

final class BabyFoodSheetViewModelProvider
    extends $NotifierProvider<BabyFoodSheetViewModel, BabyFoodSheetState> {
  const BabyFoodSheetViewModelProvider._(
      {required BabyFoodSheetViewModelFamily super.from,
      required BabyFoodSheetArgs super.argument})
      : super(
          retry: null,
          name: r'babyFoodSheetViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$babyFoodSheetViewModelHash();

  @override
  String toString() {
    return r'babyFoodSheetViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BabyFoodSheetViewModel create() => BabyFoodSheetViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BabyFoodSheetState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BabyFoodSheetState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is BabyFoodSheetViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$babyFoodSheetViewModelHash() =>
    r'5184b6b5f412161d45e98f7ab8230234cc6460c4';

final class BabyFoodSheetViewModelFamily extends $Family
    with
        $ClassFamilyOverride<BabyFoodSheetViewModel, BabyFoodSheetState,
            BabyFoodSheetState, BabyFoodSheetState, BabyFoodSheetArgs> {
  const BabyFoodSheetViewModelFamily._()
      : super(
          retry: null,
          name: r'babyFoodSheetViewModelProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  BabyFoodSheetViewModelProvider call(
    BabyFoodSheetArgs args,
  ) =>
      BabyFoodSheetViewModelProvider._(argument: args, from: this);

  @override
  String toString() => r'babyFoodSheetViewModelProvider';
}

abstract class _$BabyFoodSheetViewModel extends $Notifier<BabyFoodSheetState> {
  late final _$args = ref.$arg as BabyFoodSheetArgs;
  BabyFoodSheetArgs get args => _$args;

  BabyFoodSheetState build(
    BabyFoodSheetArgs args,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<BabyFoodSheetState, BabyFoodSheetState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<BabyFoodSheetState, BabyFoodSheetState>,
        BabyFoodSheetState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
