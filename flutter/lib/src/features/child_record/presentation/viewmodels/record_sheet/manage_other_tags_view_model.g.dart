// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_other_tags_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// タグ管理画面の ViewModel
///
/// 使用例:
/// ```dart
/// final state = ref.watch(manageOtherTagsViewModelProvider(householdId));
/// final notifier = ref.read(manageOtherTagsViewModelProvider(householdId).notifier);
/// ```

@ProviderFor(ManageOtherTagsViewModel)
const manageOtherTagsViewModelProvider = ManageOtherTagsViewModelFamily._();

/// タグ管理画面の ViewModel
///
/// 使用例:
/// ```dart
/// final state = ref.watch(manageOtherTagsViewModelProvider(householdId));
/// final notifier = ref.read(manageOtherTagsViewModelProvider(householdId).notifier);
/// ```
final class ManageOtherTagsViewModelProvider
    extends $NotifierProvider<ManageOtherTagsViewModel, ManageOtherTagsState> {
  /// タグ管理画面の ViewModel
  ///
  /// 使用例:
  /// ```dart
  /// final state = ref.watch(manageOtherTagsViewModelProvider(householdId));
  /// final notifier = ref.read(manageOtherTagsViewModelProvider(householdId).notifier);
  /// ```
  const ManageOtherTagsViewModelProvider._(
      {required ManageOtherTagsViewModelFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'manageOtherTagsViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$manageOtherTagsViewModelHash();

  @override
  String toString() {
    return r'manageOtherTagsViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ManageOtherTagsViewModel create() => ManageOtherTagsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ManageOtherTagsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ManageOtherTagsState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ManageOtherTagsViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$manageOtherTagsViewModelHash() =>
    r'1ca2d0e82577711b23f7a2a3be59c656f82f5b8b';

/// タグ管理画面の ViewModel
///
/// 使用例:
/// ```dart
/// final state = ref.watch(manageOtherTagsViewModelProvider(householdId));
/// final notifier = ref.read(manageOtherTagsViewModelProvider(householdId).notifier);
/// ```

final class ManageOtherTagsViewModelFamily extends $Family
    with
        $ClassFamilyOverride<ManageOtherTagsViewModel, ManageOtherTagsState,
            ManageOtherTagsState, ManageOtherTagsState, String> {
  const ManageOtherTagsViewModelFamily._()
      : super(
          retry: null,
          name: r'manageOtherTagsViewModelProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// タグ管理画面の ViewModel
  ///
  /// 使用例:
  /// ```dart
  /// final state = ref.watch(manageOtherTagsViewModelProvider(householdId));
  /// final notifier = ref.read(manageOtherTagsViewModelProvider(householdId).notifier);
  /// ```

  ManageOtherTagsViewModelProvider call(
    String householdId,
  ) =>
      ManageOtherTagsViewModelProvider._(argument: householdId, from: this);

  @override
  String toString() => r'manageOtherTagsViewModelProvider';
}

/// タグ管理画面の ViewModel
///
/// 使用例:
/// ```dart
/// final state = ref.watch(manageOtherTagsViewModelProvider(householdId));
/// final notifier = ref.read(manageOtherTagsViewModelProvider(householdId).notifier);
/// ```

abstract class _$ManageOtherTagsViewModel
    extends $Notifier<ManageOtherTagsState> {
  late final _$args = ref.$arg as String;
  String get householdId => _$args;

  ManageOtherTagsState build(
    String householdId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<ManageOtherTagsState, ManageOtherTagsState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ManageOtherTagsState, ManageOtherTagsState>,
        ManageOtherTagsState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
