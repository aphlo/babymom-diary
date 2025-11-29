// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_calendar_event_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddCalendarEventViewModel)
const addCalendarEventViewModelProvider = AddCalendarEventViewModelFamily._();

final class AddCalendarEventViewModelProvider extends $NotifierProvider<
    AddCalendarEventViewModel, AddCalendarEventState> {
  const AddCalendarEventViewModelProvider._(
      {required AddCalendarEventViewModelFamily super.from,
      required DateTime super.argument})
      : super(
          retry: null,
          name: r'addCalendarEventViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$addCalendarEventViewModelHash();

  @override
  String toString() {
    return r'addCalendarEventViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AddCalendarEventViewModel create() => AddCalendarEventViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddCalendarEventState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddCalendarEventState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AddCalendarEventViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$addCalendarEventViewModelHash() =>
    r'f1d696c5e5ce2073f66e3bed2b827a5b43801872';

final class AddCalendarEventViewModelFamily extends $Family
    with
        $ClassFamilyOverride<AddCalendarEventViewModel, AddCalendarEventState,
            AddCalendarEventState, AddCalendarEventState, DateTime> {
  const AddCalendarEventViewModelFamily._()
      : super(
          retry: null,
          name: r'addCalendarEventViewModelProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  AddCalendarEventViewModelProvider call(
    DateTime initialDate,
  ) =>
      AddCalendarEventViewModelProvider._(argument: initialDate, from: this);

  @override
  String toString() => r'addCalendarEventViewModelProvider';
}

abstract class _$AddCalendarEventViewModel
    extends $Notifier<AddCalendarEventState> {
  late final _$args = ref.$arg as DateTime;
  DateTime get initialDate => _$args;

  AddCalendarEventState build(
    DateTime initialDate,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<AddCalendarEventState, AddCalendarEventState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AddCalendarEventState, AddCalendarEventState>,
        AddCalendarEventState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
