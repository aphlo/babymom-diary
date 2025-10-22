import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';

import '../../child_record.dart';
import '../models/record_draft.dart';
import '../models/record_item_model.dart';
import '../viewmodels/record_state.dart';
import '../viewmodels/record_view_model.dart';
import '../widgets/app_bar_child_info.dart';
import '../widgets/app_bar_date_switcher.dart';
import '../widgets/record_sheet/editable_record_sheet.dart';
import '../widgets/record_sheet/record_slot_sheet.dart';
import '../widgets/record_table.dart';

class RecordTablePage extends ConsumerStatefulWidget {
  const RecordTablePage({super.key});

  @override
  ConsumerState<RecordTablePage> createState() => _RecordTablePageState();
}

class _RecordTablePageState extends ConsumerState<RecordTablePage> {
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

    final today = DateTime.now();
    final today0 = DateTime(today.year, today.month, today.day);
    final isToday = selectedDate.isAtSameMomentAs(today0);

    Future<void> goToPreviousDate() async {
      final d = state.selectedDate;
      final prev =
          DateTime(d.year, d.month, d.day).subtract(const Duration(days: 1));
      await notifier.onSelectDate(prev);
    }

    Future<void> goToNextDate() async {
      final d = state.selectedDate;
      final nd = DateTime(d.year, d.month, d.day).add(const Duration(days: 1));
      await notifier.onSelectDate(nd);
    }

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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AppBarChildInfo(),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _AppBarIconButton(
                    icon: Icons.chevron_left,
                    tooltip: '前日',
                    onPressed: goToPreviousDate,
                  ),
                  const Expanded(
                    child: Center(child: AppBarDateSwitcher()),
                  ),
                  _AppBarIconButton(
                    icon: Icons.chevron_right,
                    tooltip: '翌日',
                    onPressed: isToday ? null : goToNextDate,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: state.recordsAsync.when(
        data: buildRecordTable,
        loading: () {
          final records = state.recordsAsync.value;
          if (records != null) {
            return buildRecordTable(records);
          }
          return const Center(child: CircularProgressIndicator());
        },
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class _AppBarIconButton extends StatelessWidget {
  const _AppBarIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 40, height: 40),
      splashRadius: 22,
    );
  }
}
