import 'package:flutter/foundation.dart';

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
    required this.selectedTabIndex,
    required this.selectedChildId,
    required this.householdId,
    this.isProcessing = false,
    this.pendingUiEvent,
    this.activeDraft,
  });

  final DateTime selectedDate;
  final int selectedTabIndex;
  final String? selectedChildId;
  final String? householdId;
  final bool isProcessing;
  final RecordUiEvent? pendingUiEvent;
  final RecordDraft? activeDraft;

  RecordPageState copyWith({
    DateTime? selectedDate,
    int? selectedTabIndex,
    String? selectedChildId,
    String? householdId,
    bool? isProcessing,
    RecordUiEvent? pendingUiEvent,
    RecordDraft? activeDraft,
  }) {
    return RecordPageState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
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
      selectedTabIndex: 0,
      selectedChildId: null,
      householdId: null,
      isProcessing: false,
      pendingUiEvent: null,
      activeDraft: null,
    );
  }
}
