// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_child_snapshot_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedChildSnapshot)
const selectedChildSnapshotProvider = SelectedChildSnapshotFamily._();

final class SelectedChildSnapshotProvider
    extends $AsyncNotifierProvider<SelectedChildSnapshot, ChildSummary?> {
  const SelectedChildSnapshotProvider._(
      {required SelectedChildSnapshotFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'selectedChildSnapshotProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$selectedChildSnapshotHash();

  @override
  String toString() {
    return r'selectedChildSnapshotProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SelectedChildSnapshot create() => SelectedChildSnapshot();

  @override
  bool operator ==(Object other) {
    return other is SelectedChildSnapshotProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedChildSnapshotHash() =>
    r'c6b214f7eefa4f310283d7cd1f70145ed0eb3ee1';

final class SelectedChildSnapshotFamily extends $Family
    with
        $ClassFamilyOverride<SelectedChildSnapshot, AsyncValue<ChildSummary?>,
            ChildSummary?, FutureOr<ChildSummary?>, String> {
  const SelectedChildSnapshotFamily._()
      : super(
          retry: null,
          name: r'selectedChildSnapshotProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  SelectedChildSnapshotProvider call(
    String householdId,
  ) =>
      SelectedChildSnapshotProvider._(argument: householdId, from: this);

  @override
  String toString() => r'selectedChildSnapshotProvider';
}

abstract class _$SelectedChildSnapshot extends $AsyncNotifier<ChildSummary?> {
  late final _$args = ref.$arg as String;
  String get householdId => _$args;

  FutureOr<ChildSummary?> build(
    String householdId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<AsyncValue<ChildSummary?>, ChildSummary?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<ChildSummary?>, ChildSummary?>,
        AsyncValue<ChildSummary?>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
