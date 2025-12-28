// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_settings_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IngredientSettingsViewModel)
const ingredientSettingsViewModelProvider =
    IngredientSettingsViewModelFamily._();

final class IngredientSettingsViewModelProvider extends $NotifierProvider<
    IngredientSettingsViewModel, IngredientSettingsState> {
  const IngredientSettingsViewModelProvider._(
      {required IngredientSettingsViewModelFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'ingredientSettingsViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$ingredientSettingsViewModelHash();

  @override
  String toString() {
    return r'ingredientSettingsViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  IngredientSettingsViewModel create() => IngredientSettingsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IngredientSettingsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IngredientSettingsState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IngredientSettingsViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ingredientSettingsViewModelHash() =>
    r'bb93e59bbd5473e8229f2407ccdc43cd3877c478';

final class IngredientSettingsViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
            IngredientSettingsViewModel,
            IngredientSettingsState,
            IngredientSettingsState,
            IngredientSettingsState,
            String> {
  const IngredientSettingsViewModelFamily._()
      : super(
          retry: null,
          name: r'ingredientSettingsViewModelProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  IngredientSettingsViewModelProvider call(
    String householdId,
  ) =>
      IngredientSettingsViewModelProvider._(argument: householdId, from: this);

  @override
  String toString() => r'ingredientSettingsViewModelProvider';
}

abstract class _$IngredientSettingsViewModel
    extends $Notifier<IngredientSettingsState> {
  late final _$args = ref.$arg as String;
  String get householdId => _$args;

  IngredientSettingsState build(
    String householdId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref =
        this.ref as $Ref<IngredientSettingsState, IngredientSettingsState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<IngredientSettingsState, IngredientSettingsState>,
        IngredientSettingsState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
