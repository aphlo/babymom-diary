import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../ads/presentation/widgets/banner_ad_widget.dart';
import '../dialogs/mom_diary_editor_dialog.dart';
import '../models/mom_diary_ui_model.dart';
import '../viewmodels/mom_diary_view_model.dart';
import 'mom_diary_table.dart';

class MomDiaryOverviewTab extends ConsumerWidget {
  const MomDiaryOverviewTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(momDiaryViewModelProvider);
    final notifier = ref.read(momDiaryViewModelProvider.notifier);

    Future<void> handleEntryTap(MomDiaryEntryUiModel entry) async {
      final saved = await MomDiaryEditorDialog.show(context, entry);
      if (saved == true && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('日記を保存しました')),
        );
      }
    }

    Future<void> handleRetry() async {
      await notifier.loadForMonth(state.focusMonth, keepState: false);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: state.monthlyDiary.when(
            data: (monthly) {
              if (monthly.entries.isEmpty) {
                return const Center(child: Text('表示できる日記がありません'));
              }
              return MomDiaryTable(
                entries: monthly.entries,
                onEntryTap: handleEntryTap,
              );
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            error: (error, stackTrace) {
              return _DiaryErrorView(onRetry: handleRetry);
            },
          ),
        ),
        const BannerAdWidget(),
      ],
    );
  }
}

class _DiaryErrorView extends StatelessWidget {
  const _DiaryErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('日記の取得に失敗しました'),
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
