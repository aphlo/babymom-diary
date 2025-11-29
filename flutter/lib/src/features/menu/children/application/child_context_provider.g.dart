// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_context_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 子供コンテキストを一元管理するAsyncNotifier
///
/// このプロバイダは以下を統合的に監視し、リアクティブに更新します:
/// - householdId の変更
/// - selectedChildId の変更
/// - childrenList の変更（子供削除の検知含む）
/// - selectedChild のスナップショット（誕生日など）の変更
///
/// 子供が削除された場合、自動的に次の子供を選択します。
///
/// 使用例:
/// ```dart
/// final contextAsync = ref.watch(childContextProvider);
/// contextAsync.when(
///   data: (context) {
///     // context.householdId, context.selectedChildId, etc.
///   },
///   loading: () => CircularProgressIndicator(),
///   error: (e, s) => Text('Error: $e'),
/// );
/// ```

@ProviderFor(ChildContextNotifier)
const childContextProvider = ChildContextNotifierProvider._();

/// 子供コンテキストを一元管理するAsyncNotifier
///
/// このプロバイダは以下を統合的に監視し、リアクティブに更新します:
/// - householdId の変更
/// - selectedChildId の変更
/// - childrenList の変更（子供削除の検知含む）
/// - selectedChild のスナップショット（誕生日など）の変更
///
/// 子供が削除された場合、自動的に次の子供を選択します。
///
/// 使用例:
/// ```dart
/// final contextAsync = ref.watch(childContextProvider);
/// contextAsync.when(
///   data: (context) {
///     // context.householdId, context.selectedChildId, etc.
///   },
///   loading: () => CircularProgressIndicator(),
///   error: (e, s) => Text('Error: $e'),
/// );
/// ```
final class ChildContextNotifierProvider
    extends $AsyncNotifierProvider<ChildContextNotifier, ChildContext> {
  /// 子供コンテキストを一元管理するAsyncNotifier
  ///
  /// このプロバイダは以下を統合的に監視し、リアクティブに更新します:
  /// - householdId の変更
  /// - selectedChildId の変更
  /// - childrenList の変更（子供削除の検知含む）
  /// - selectedChild のスナップショット（誕生日など）の変更
  ///
  /// 子供が削除された場合、自動的に次の子供を選択します。
  ///
  /// 使用例:
  /// ```dart
  /// final contextAsync = ref.watch(childContextProvider);
  /// contextAsync.when(
  ///   data: (context) {
  ///     // context.householdId, context.selectedChildId, etc.
  ///   },
  ///   loading: () => CircularProgressIndicator(),
  ///   error: (e, s) => Text('Error: $e'),
  /// );
  /// ```
  const ChildContextNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'childContextProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$childContextNotifierHash();

  @$internal
  @override
  ChildContextNotifier create() => ChildContextNotifier();
}

String _$childContextNotifierHash() =>
    r'2d6e2ba2e079ff1929a4c480661fc817d9e9dcfa';

/// 子供コンテキストを一元管理するAsyncNotifier
///
/// このプロバイダは以下を統合的に監視し、リアクティブに更新します:
/// - householdId の変更
/// - selectedChildId の変更
/// - childrenList の変更（子供削除の検知含む）
/// - selectedChild のスナップショット（誕生日など）の変更
///
/// 子供が削除された場合、自動的に次の子供を選択します。
///
/// 使用例:
/// ```dart
/// final contextAsync = ref.watch(childContextProvider);
/// contextAsync.when(
///   data: (context) {
///     // context.householdId, context.selectedChildId, etc.
///   },
///   loading: () => CircularProgressIndicator(),
///   error: (e, s) => Text('Error: $e'),
/// );
/// ```

abstract class _$ChildContextNotifier extends $AsyncNotifier<ChildContext> {
  FutureOr<ChildContext> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ChildContext>, ChildContext>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<ChildContext>, ChildContext>,
        AsyncValue<ChildContext>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
