import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../child_record.dart';
import '../providers/daily_records_provider.dart';
import '../../../ads/application/services/banner_ad_manager.dart';
import '../../../ads/presentation/widgets/banner_ad_widget.dart';
import '../../../menu/children/application/child_context_provider.dart';
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
      // 子供未登録のメッセージの場合はダイアログを表示
      if (event.message == '記録を行うには、メニューから子どもを登録してください。') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              '子どもを登録してください',
              style: TextStyle(fontSize: 16),
            ),
            content: Text(
              event.message!,
              style: const TextStyle(fontSize: 14),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(event.message!)));
      }
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
        backgroundColor: Colors.white,
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
    final childContext = ref.watch(childContextProvider).value;
    final selectedDate = state.selectedDate;

    // ChildContext と selectedChildId が揃っている場合のみ記録を取得
    final selectedChildId = childContext?.selectedChildId;
    final recordsAsync = (childContext != null &&
            selectedChildId != null &&
            selectedChildId.isNotEmpty)
        ? ref.watch(dailyRecordsProvider(DailyRecordsQuery(
            householdId: childContext.householdId,
            childId: selectedChildId,
            date: selectedDate,
          )))
        : const AsyncValue<List<RecordItemModel>>.data(<RecordItemModel>[]);

    void handleSlotTap(int hour, RecordType type) {
      final records = recordsAsync.value ?? const <RecordItemModel>[];
      notifier.openSlotDetails(hour: hour, type: type, allRecords: records);
    }

    final scrollStorageKey = PageStorageKey<String>(
      'record_table_scroll_${selectedDate.toIso8601String()}',
    );

    Widget buildRecordTable(List<RecordItemModel> records) {
      return Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                RecordTable(
                  records: records,
                  onSlotTap: handleSlotTap,
                  scrollStorageKey: scrollStorageKey,
                  selectedDate: selectedDate,
                ),
                if ((recordsAsync.isLoading && !recordsAsync.hasValue) ||
                    state.isProcessing)
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
            ),
          ),
          const BannerAdWidget(slot: BannerAdSlot.feedingTable),
        ],
      );
    }

    return recordsAsync.when(
      data: buildRecordTable,
      loading: () {
        final records = recordsAsync.value;
        if (records != null) {
          return buildRecordTable(records);
        }
        return const Center(child: CircularProgressIndicator());
      },
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}
