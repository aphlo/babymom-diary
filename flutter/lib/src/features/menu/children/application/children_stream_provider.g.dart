// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'children_stream_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Household 内の子ども一覧を監視する StreamProvider。

@ProviderFor(childrenStream)
const childrenStreamProvider = ChildrenStreamFamily._();

/// Household 内の子ども一覧を監視する StreamProvider。

final class ChildrenStreamProvider extends $FunctionalProvider<
        AsyncValue<List<ChildSummary>>,
        List<ChildSummary>,
        Stream<List<ChildSummary>>>
    with
        $FutureModifier<List<ChildSummary>>,
        $StreamProvider<List<ChildSummary>> {
  /// Household 内の子ども一覧を監視する StreamProvider。
  const ChildrenStreamProvider._(
      {required ChildrenStreamFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'childrenStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$childrenStreamHash();

  @override
  String toString() {
    return r'childrenStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<ChildSummary>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<ChildSummary>> create(Ref ref) {
    final argument = this.argument as String;
    return childrenStream(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ChildrenStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$childrenStreamHash() => r'b76e0a41df0f3e61f8409b640433238605a64b43';

/// Household 内の子ども一覧を監視する StreamProvider。

final class ChildrenStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<ChildSummary>>, String> {
  const ChildrenStreamFamily._()
      : super(
          retry: null,
          name: r'childrenStreamProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Household 内の子ども一覧を監視する StreamProvider。

  ChildrenStreamProvider call(
    String householdId,
  ) =>
      ChildrenStreamProvider._(argument: householdId, from: this);

  @override
  String toString() => r'childrenStreamProvider';
}
