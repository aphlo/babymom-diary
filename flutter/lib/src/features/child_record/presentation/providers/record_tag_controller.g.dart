// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_tag_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// RecordTagRepository の Provider

@ProviderFor(recordTagRepository)
const recordTagRepositoryProvider = RecordTagRepositoryProvider._();

/// RecordTagRepository の Provider

final class RecordTagRepositoryProvider extends $FunctionalProvider<
    RecordTagRepository,
    RecordTagRepository,
    RecordTagRepository> with $Provider<RecordTagRepository> {
  /// RecordTagRepository の Provider
  const RecordTagRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'recordTagRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$recordTagRepositoryHash();

  @$internal
  @override
  $ProviderElement<RecordTagRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RecordTagRepository create(Ref ref) {
    return recordTagRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecordTagRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecordTagRepository>(value),
    );
  }
}

String _$recordTagRepositoryHash() =>
    r'e83608fa1bc05e79e9bcc09285073ac5bb39326b';

/// 世帯ごとのタグ一覧を管理する Controller
///
/// 使用例:
/// ```dart
/// final tagsAsync = ref.watch(recordTagControllerProvider(householdId));
/// final controller = ref.read(recordTagControllerProvider(householdId).notifier);
/// await controller.add('新しいタグ');
/// ```

@ProviderFor(RecordTagController)
const recordTagControllerProvider = RecordTagControllerFamily._();

/// 世帯ごとのタグ一覧を管理する Controller
///
/// 使用例:
/// ```dart
/// final tagsAsync = ref.watch(recordTagControllerProvider(householdId));
/// final controller = ref.read(recordTagControllerProvider(householdId).notifier);
/// await controller.add('新しいタグ');
/// ```
final class RecordTagControllerProvider
    extends $AsyncNotifierProvider<RecordTagController, List<String>> {
  /// 世帯ごとのタグ一覧を管理する Controller
  ///
  /// 使用例:
  /// ```dart
  /// final tagsAsync = ref.watch(recordTagControllerProvider(householdId));
  /// final controller = ref.read(recordTagControllerProvider(householdId).notifier);
  /// await controller.add('新しいタグ');
  /// ```
  const RecordTagControllerProvider._(
      {required RecordTagControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'recordTagControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$recordTagControllerHash();

  @override
  String toString() {
    return r'recordTagControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RecordTagController create() => RecordTagController();

  @override
  bool operator ==(Object other) {
    return other is RecordTagControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$recordTagControllerHash() =>
    r'929b2e12fbbec21ee27f22ad98211eae340b8b15';

/// 世帯ごとのタグ一覧を管理する Controller
///
/// 使用例:
/// ```dart
/// final tagsAsync = ref.watch(recordTagControllerProvider(householdId));
/// final controller = ref.read(recordTagControllerProvider(householdId).notifier);
/// await controller.add('新しいタグ');
/// ```

final class RecordTagControllerFamily extends $Family
    with
        $ClassFamilyOverride<RecordTagController, AsyncValue<List<String>>,
            List<String>, FutureOr<List<String>>, String> {
  const RecordTagControllerFamily._()
      : super(
          retry: null,
          name: r'recordTagControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// 世帯ごとのタグ一覧を管理する Controller
  ///
  /// 使用例:
  /// ```dart
  /// final tagsAsync = ref.watch(recordTagControllerProvider(householdId));
  /// final controller = ref.read(recordTagControllerProvider(householdId).notifier);
  /// await controller.add('新しいタグ');
  /// ```

  RecordTagControllerProvider call(
    String householdId,
  ) =>
      RecordTagControllerProvider._(argument: householdId, from: this);

  @override
  String toString() => r'recordTagControllerProvider';
}

/// 世帯ごとのタグ一覧を管理する Controller
///
/// 使用例:
/// ```dart
/// final tagsAsync = ref.watch(recordTagControllerProvider(householdId));
/// final controller = ref.read(recordTagControllerProvider(householdId).notifier);
/// await controller.add('新しいタグ');
/// ```

abstract class _$RecordTagController extends $AsyncNotifier<List<String>> {
  late final _$args = ref.$arg as String;
  String get householdId => _$args;

  FutureOr<List<String>> build(
    String householdId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<AsyncValue<List<String>>, List<String>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<String>>, List<String>>,
        AsyncValue<List<String>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
