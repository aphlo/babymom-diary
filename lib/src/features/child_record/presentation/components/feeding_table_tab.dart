import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../child_record.dart';
import '../models/record_draft.dart';
import '../models/record_item_model.dart';
import '../viewmodels/record_state.dart';
import '../viewmodels/record_view_model.dart';
import '../widgets/record_sheet/editable_record_sheet.dart';
import '../widgets/record_sheet/record_slot_sheet.dart';
import '../widgets/record_table.dart';

class FeedingTableTab extends ConsumerStatefulWidget {
  const FeedingTableTab({super.key});

  @override
  ConsumerState<FeedingTableTab> createState() => _FeedingTableTabState();
}

class _FeedingTableTabState extends ConsumerState<FeedingTableTab> {
  late final ProviderSubscription<RecordPageState> _stateSub;

  @override
  void initState() {
    super.initState();
    _stateSub = ref.listenManual<RecordPageState>(
      recordViewModelProvider,
      _handleStateEvent,
    );
  }

  @override
  void dispose() {
    _stateSub.close();
    super.dispose();
  }

  void _handleStateEvent(RecordPageState? previous, RecordPageState next) {
    final event = next.pendingUiEvent;
    if (event == null) {
      return;
    }
    final notifier = ref.read(recordViewModelProvider.notifier);
    if (!mounted) return;

    if (event.message != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(event.message!)));
    }
    if (event.openSlot != null) {
      showRecordSlotSheet(
        context: context,
        ref: ref,
        request: event.openSlot!,
      );
    }
    if (event.openEditor != null) {
      _openEditor(event.openEditor!);
    }
    notifier.clearUiEvent();
  }

  Future<void> _openEditor(RecordEditorRequest request) async {
    final notifier = ref.read(recordViewModelProvider.notifier);
    final result = await showDialog<RecordDraft>(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: EditableRecordSheet(
            initialDraft: request.draft,
            isNew: request.isNew,
          ),
        ),
      ),
    );
    if (result != null && mounted) {
      await notifier.addOrUpdateRecord(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recordViewModelProvider);
    final notifier = ref.read(recordViewModelProvider.notifier);
    final selectedDate = state.selectedDate;

    void handleSlotTap(int hour, RecordType type) {
      notifier.openSlotDetails(hour: hour, type: type);
    }

    final scrollStorageKey = PageStorageKey<String>(
      'record_table_scroll_${selectedDate.toIso8601String()}',
    );

    Widget buildRecordTable(List<RecordItemModel> records) {
      return Stack(
        children: [
          RecordTable(
            records: records,
            onSlotTap: handleSlotTap,
            scrollStorageKey: scrollStorageKey,
          ),
          if (state.recordsAsync.isLoading || state.isProcessing)
            const Positioned(
              right: 16,
              bottom: 16,
              child: SizedBox(
                height: 36,
                width: 36,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
            ),
        ],
      );
    }

    return state.recordsAsync.when(
      data: buildRecordTable,
      loading: () {
        final records = state.recordsAsync.value;
        if (records != null) {
          return buildRecordTable(records);
        }
        return const Center(child: CircularProgressIndicator());
      },
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}
