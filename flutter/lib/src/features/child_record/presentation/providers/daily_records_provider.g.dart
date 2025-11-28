// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_records_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 日別の記録をリアルタイムで取得する StreamProvider
///
/// [DailyRecordsQuery] で指定された householdId, childId, date に基づいて
/// Firestore から記録を監視し、UI モデルに変換して返す。
///
/// 使用例:
/// ```dart
/// final recordsAsync = ref.watch(dailyRecordsProvider(DailyRecordsQuery(
///   householdId: context.householdId,
///   childId: childId,
///   date: selectedDate,
/// )));
/// ```

@ProviderFor(dailyRecords)
const dailyRecordsProvider = DailyRecordsFamily._();

/// 日別の記録をリアルタイムで取得する StreamProvider
///
/// [DailyRecordsQuery] で指定された householdId, childId, date に基づいて
/// Firestore から記録を監視し、UI モデルに変換して返す。
///
/// 使用例:
/// ```dart
/// final recordsAsync = ref.watch(dailyRecordsProvider(DailyRecordsQuery(
///   householdId: context.householdId,
///   childId: childId,
///   date: selectedDate,
/// )));
/// ```

final class DailyRecordsProvider extends $FunctionalProvider<
        AsyncValue<List<RecordItemModel>>,
        List<RecordItemModel>,
        Stream<List<RecordItemModel>>>
    with
        $FutureModifier<List<RecordItemModel>>,
        $StreamProvider<List<RecordItemModel>> {
  /// 日別の記録をリアルタイムで取得する StreamProvider
  ///
  /// [DailyRecordsQuery] で指定された householdId, childId, date に基づいて
  /// Firestore から記録を監視し、UI モデルに変換して返す。
  ///
  /// 使用例:
  /// ```dart
  /// final recordsAsync = ref.watch(dailyRecordsProvider(DailyRecordsQuery(
  ///   householdId: context.householdId,
  ///   childId: childId,
  ///   date: selectedDate,
  /// )));
  /// ```
  const DailyRecordsProvider._(
      {required DailyRecordsFamily super.from,
      required DailyRecordsQuery super.argument})
      : super(
          retry: null,
          name: r'dailyRecordsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dailyRecordsHash();

  @override
  String toString() {
    return r'dailyRecordsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<RecordItemModel>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<RecordItemModel>> create(Ref ref) {
    final argument = this.argument as DailyRecordsQuery;
    return dailyRecords(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DailyRecordsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dailyRecordsHash() => r'bde8616e9df9ca447bcb1d2b0a2afb74a63dad7b';

/// 日別の記録をリアルタイムで取得する StreamProvider
///
/// [DailyRecordsQuery] で指定された householdId, childId, date に基づいて
/// Firestore から記録を監視し、UI モデルに変換して返す。
///
/// 使用例:
/// ```dart
/// final recordsAsync = ref.watch(dailyRecordsProvider(DailyRecordsQuery(
///   householdId: context.householdId,
///   childId: childId,
///   date: selectedDate,
/// )));
/// ```

final class DailyRecordsFamily extends $Family
    with
        $FunctionalFamilyOverride<Stream<List<RecordItemModel>>,
            DailyRecordsQuery> {
  const DailyRecordsFamily._()
      : super(
          retry: null,
          name: r'dailyRecordsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// 日別の記録をリアルタイムで取得する StreamProvider
  ///
  /// [DailyRecordsQuery] で指定された householdId, childId, date に基づいて
  /// Firestore から記録を監視し、UI モデルに変換して返す。
  ///
  /// 使用例:
  /// ```dart
  /// final recordsAsync = ref.watch(dailyRecordsProvider(DailyRecordsQuery(
  ///   householdId: context.householdId,
  ///   childId: childId,
  ///   date: selectedDate,
  /// )));
  /// ```

  DailyRecordsProvider call(
    DailyRecordsQuery query,
  ) =>
      DailyRecordsProvider._(argument: query, from: this);

  @override
  String toString() => r'dailyRecordsProvider';
}
