import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dialogs/mom_record_editor_dialog.dart';
import '../models/mom_record_ui_model.dart';
import '../viewmodels/mom_record_view_model.dart';
import 'mom_record_table.dart';

class MomRecordOverviewTab extends ConsumerWidget {
  const MomRecordOverviewTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(momRecordViewModelProvider);
    final notifier = ref.read(momRecordViewModelProvider.notifier);

    Future<void> handleRetry() async {
      await notifier.loadForMonth(state.focusMonth);
    }

    Future<void> handleRecordTap(MomDailyRecordUiModel record) async {
      final saved = await MomRecordEditorDialog.show(context, record);
      if (saved == true && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('記録を保存しました')),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: state.monthlyRecords.when(
            data: (monthly) {
              if (monthly.days.isEmpty) {
                return const Center(child: Text('表示できる記録がありません'));
              }
              return MomRecordTable(
                records: monthly.days,
                onRecordTap: handleRecordTap,
              );
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            error: (error, stackTrace) {
              return _ErrorView(onRetry: handleRetry);
            },
          ),
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('記録の取得に失敗しました'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('再読み込み'),
          ),
        ],
      ),
    );
  }
}
