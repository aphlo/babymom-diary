// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_summary_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WeeklySummaryViewModel)
const weeklySummaryViewModelProvider = WeeklySummaryViewModelFamily._();

final class WeeklySummaryViewModelProvider
    extends $NotifierProvider<WeeklySummaryViewModel, WeeklySummaryState> {
  const WeeklySummaryViewModelProvider._(
      {required WeeklySummaryViewModelFamily super.from,
      required DateTime super.argument})
      : super(
          retry: null,
          name: r'weeklySummaryViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$weeklySummaryViewModelHash();

  @override
  String toString() {
    return r'weeklySummaryViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  WeeklySummaryViewModel create() => WeeklySummaryViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeeklySummaryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeeklySummaryState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WeeklySummaryViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$weeklySummaryViewModelHash() =>
    r'237a2a43f0a50e85e4cbc8aceaab80bd3a440063';

final class WeeklySummaryViewModelFamily extends $Family
    with
        $ClassFamilyOverride<WeeklySummaryViewModel, WeeklySummaryState,
            WeeklySummaryState, WeeklySummaryState, DateTime> {
  const WeeklySummaryViewModelFamily._()
      : super(
          retry: null,
          name: r'weeklySummaryViewModelProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  WeeklySummaryViewModelProvider call(
    DateTime initialDate,
  ) =>
      WeeklySummaryViewModelProvider._(argument: initialDate, from: this);

  @override
  String toString() => r'weeklySummaryViewModelProvider';
}

abstract class _$WeeklySummaryViewModel extends $Notifier<WeeklySummaryState> {
  late final _$args = ref.$arg as DateTime;
  DateTime get initialDate => _$args;

  WeeklySummaryState build(
    DateTime initialDate,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<WeeklySummaryState, WeeklySummaryState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<WeeklySummaryState, WeeklySummaryState>,
        WeeklySummaryState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
