import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../child_record.dart';
import '../models/record_draft.dart';
import '../models/record_item_model.dart';

@immutable
class RecordSlotRequest {
  const RecordSlotRequest({
    required this.date,
    required this.hour,
    required this.type,
    required this.records,
  });

  final DateTime date;
  final int hour;
  final RecordType type;
  final List<RecordItemModel> records;
}

@immutable
class RecordEditorRequest {
  const RecordEditorRequest({
    required this.draft,
    required this.isNew,
  });

  final RecordDraft draft;
  final bool isNew;
}

@immutable
class RecordUiEvent {
  const RecordUiEvent._({
    this.message,
    this.openSlot,
    this.openEditor,
  });

  final String? message;
  final RecordSlotRequest? openSlot;
  final RecordEditorRequest? openEditor;

  const RecordUiEvent.showMessage(String message)
      : this._(message: message, openSlot: null, openEditor: null);

  const RecordUiEvent.openSlot(RecordSlotRequest request)
      : this._(message: null, openSlot: request, openEditor: null);

  const RecordUiEvent.openEditor(RecordEditorRequest request)
      : this._(message: null, openSlot: null, openEditor: request);
}

@immutable
class RecordPageState {
  const RecordPageState({
    required this.selectedDate,
    required this.recordsAsync,
    required this.otherTagsAsync,
    required this.selectedChildId,
    required this.householdId,
    this.isProcessing = false,
    this.pendingUiEvent,
    this.activeDraft,
  });

  final DateTime selectedDate;
  final AsyncValue<List<RecordItemModel>> recordsAsync;
  final AsyncValue<List<String>> otherTagsAsync;
  final String? selectedChildId;
  final String? householdId;
  final bool isProcessing;
  final RecordUiEvent? pendingUiEvent;
  final RecordDraft? activeDraft;

  List<RecordItemModel> get records =>
      recordsAsync.valueOrNull ?? const <RecordItemModel>[];

  bool get hasError => recordsAsync.hasError;

  Object? get error => recordsAsync.whenOrNull(error: (err, __) => err);

  RecordPageState copyWith({
    DateTime? selectedDate,
    AsyncValue<List<RecordItemModel>>? recordsAsync,
    AsyncValue<List<String>>? otherTagsAsync,
    String? selectedChildId,
    String? householdId,
    bool? isProcessing,
    RecordUiEvent? pendingUiEvent,
    RecordDraft? activeDraft,
  }) {
    return RecordPageState(
      selectedDate: selectedDate ?? this.selectedDate,
      recordsAsync: recordsAsync ?? this.recordsAsync,
      otherTagsAsync: otherTagsAsync ?? this.otherTagsAsync,
      selectedChildId: selectedChildId ?? this.selectedChildId,
      householdId: householdId ?? this.householdId,
      isProcessing: isProcessing ?? this.isProcessing,
      pendingUiEvent: pendingUiEvent,
      activeDraft: activeDraft,
    );
  }

  static RecordPageState initial() {
    final now = DateTime.now();
    final normalized = DateTime(now.year, now.month, now.day);
    return RecordPageState(
      selectedDate: normalized,
      recordsAsync: const AsyncValue<List<RecordItemModel>>.loading(),
      otherTagsAsync: const AsyncValue<List<String>>.loading(),
      selectedChildId: null,
      householdId: null,
      isProcessing: false,
      pendingUiEvent: null,
      activeDraft: null,
    );
  }
}
