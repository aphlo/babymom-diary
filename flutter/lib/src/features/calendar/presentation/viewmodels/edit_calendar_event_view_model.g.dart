// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_calendar_event_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EditCalendarEventViewModel)
const editCalendarEventViewModelProvider = EditCalendarEventViewModelFamily._();

final class EditCalendarEventViewModelProvider extends $NotifierProvider<
    EditCalendarEventViewModel, EditCalendarEventState> {
  const EditCalendarEventViewModelProvider._(
      {required EditCalendarEventViewModelFamily super.from,
      required CalendarEvent super.argument})
      : super(
          retry: null,
          name: r'editCalendarEventViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$editCalendarEventViewModelHash();

  @override
  String toString() {
    return r'editCalendarEventViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EditCalendarEventViewModel create() => EditCalendarEventViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EditCalendarEventState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EditCalendarEventState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EditCalendarEventViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$editCalendarEventViewModelHash() =>
    r'0c209685ff157bdf157a4e9f8dd8e55173be159d';

final class EditCalendarEventViewModelFamily extends $Family
    with
        $ClassFamilyOverride<EditCalendarEventViewModel, EditCalendarEventState,
            EditCalendarEventState, EditCalendarEventState, CalendarEvent> {
  const EditCalendarEventViewModelFamily._()
      : super(
          retry: null,
          name: r'editCalendarEventViewModelProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  EditCalendarEventViewModelProvider call(
    CalendarEvent event,
  ) =>
      EditCalendarEventViewModelProvider._(argument: event, from: this);

  @override
  String toString() => r'editCalendarEventViewModelProvider';
}

abstract class _$EditCalendarEventViewModel
    extends $Notifier<EditCalendarEventState> {
  late final _$args = ref.$arg as CalendarEvent;
  CalendarEvent get event => _$args;

  EditCalendarEventState build(
    CalendarEvent event,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref =
        this.ref as $Ref<EditCalendarEventState, EditCalendarEventState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<EditCalendarEventState, EditCalendarEventState>,
        EditCalendarEventState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
