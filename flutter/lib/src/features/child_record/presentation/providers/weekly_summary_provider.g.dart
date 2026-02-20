// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_summary_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 週間サマリーデータを取得・集計するFutureProvider

@ProviderFor(weeklySummary)
const weeklySummaryProvider = WeeklySummaryFamily._();

/// 週間サマリーデータを取得・集計するFutureProvider

final class WeeklySummaryProvider extends $FunctionalProvider<
        AsyncValue<WeeklySummaryData>,
        WeeklySummaryData,
        FutureOr<WeeklySummaryData>>
    with
        $FutureModifier<WeeklySummaryData>,
        $FutureProvider<WeeklySummaryData> {
  /// 週間サマリーデータを取得・集計するFutureProvider
  const WeeklySummaryProvider._(
      {required WeeklySummaryFamily super.from,
      required WeeklySummaryQuery super.argument})
      : super(
          retry: null,
          name: r'weeklySummaryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$weeklySummaryHash();

  @override
  String toString() {
    return r'weeklySummaryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<WeeklySummaryData> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<WeeklySummaryData> create(Ref ref) {
    final argument = this.argument as WeeklySummaryQuery;
    return weeklySummary(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WeeklySummaryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$weeklySummaryHash() => r'31cf99e4801a829474c1e351b08d4686a73d9e91';

/// 週間サマリーデータを取得・集計するFutureProvider

final class WeeklySummaryFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<WeeklySummaryData>,
            WeeklySummaryQuery> {
  const WeeklySummaryFamily._()
      : super(
          retry: null,
          name: r'weeklySummaryProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// 週間サマリーデータを取得・集計するFutureProvider

  WeeklySummaryProvider call(
    WeeklySummaryQuery query,
  ) =>
      WeeklySummaryProvider._(argument: query, from: this);

  @override
  String toString() => r'weeklySummaryProvider';
}
