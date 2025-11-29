// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'children_local_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChildrenLocal)
const childrenLocalProvider = ChildrenLocalFamily._();

final class ChildrenLocalProvider
    extends $AsyncNotifierProvider<ChildrenLocal, List<ChildSummary>> {
  const ChildrenLocalProvider._(
      {required ChildrenLocalFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'childrenLocalProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$childrenLocalHash();

  @override
  String toString() {
    return r'childrenLocalProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChildrenLocal create() => ChildrenLocal();

  @override
  bool operator ==(Object other) {
    return other is ChildrenLocalProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$childrenLocalHash() => r'7291171650514f937543a8fe403e09fa046c70b6';

final class ChildrenLocalFamily extends $Family
    with
        $ClassFamilyOverride<ChildrenLocal, AsyncValue<List<ChildSummary>>,
            List<ChildSummary>, FutureOr<List<ChildSummary>>, String> {
  const ChildrenLocalFamily._()
      : super(
          retry: null,
          name: r'childrenLocalProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  ChildrenLocalProvider call(
    String householdId,
  ) =>
      ChildrenLocalProvider._(argument: householdId, from: this);

  @override
  String toString() => r'childrenLocalProvider';
}

abstract class _$ChildrenLocal extends $AsyncNotifier<List<ChildSummary>> {
  late final _$args = ref.$arg as String;
  String get householdId => _$args;

  FutureOr<List<ChildSummary>> build(
    String householdId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref =
        this.ref as $Ref<AsyncValue<List<ChildSummary>>, List<ChildSummary>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<ChildSummary>>, List<ChildSummary>>,
        AsyncValue<List<ChildSummary>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
