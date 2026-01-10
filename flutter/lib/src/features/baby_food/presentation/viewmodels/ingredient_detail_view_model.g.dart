// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IngredientDetailViewModel)
const ingredientDetailViewModelProvider = IngredientDetailViewModelFamily._();

final class IngredientDetailViewModelProvider extends $NotifierProvider<
    IngredientDetailViewModel, IngredientDetailState> {
  const IngredientDetailViewModelProvider._(
      {required IngredientDetailViewModelFamily super.from,
      required IngredientDetailArgs super.argument})
      : super(
          retry: null,
          name: r'ingredientDetailViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$ingredientDetailViewModelHash();

  @override
  String toString() {
    return r'ingredientDetailViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  IngredientDetailViewModel create() => IngredientDetailViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IngredientDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IngredientDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IngredientDetailViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ingredientDetailViewModelHash() =>
    r'a1217e2e01b9f446462639ed0b35fcfdb0d97604';

final class IngredientDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
            IngredientDetailViewModel,
            IngredientDetailState,
            IngredientDetailState,
            IngredientDetailState,
            IngredientDetailArgs> {
  const IngredientDetailViewModelFamily._()
      : super(
          retry: null,
          name: r'ingredientDetailViewModelProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  IngredientDetailViewModelProvider call(
    IngredientDetailArgs args,
  ) =>
      IngredientDetailViewModelProvider._(argument: args, from: this);

  @override
  String toString() => r'ingredientDetailViewModelProvider';
}

abstract class _$IngredientDetailViewModel
    extends $Notifier<IngredientDetailState> {
  late final _$args = ref.$arg as IngredientDetailArgs;
  IngredientDetailArgs get args => _$args;

  IngredientDetailState build(
    IngredientDetailArgs args,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<IngredientDetailState, IngredientDetailState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<IngredientDetailState, IngredientDetailState>,
        IngredientDetailState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
