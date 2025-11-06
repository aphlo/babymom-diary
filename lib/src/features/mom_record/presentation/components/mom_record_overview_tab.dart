import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/firebase/household_service.dart';
import '../../../menu/children/application/children_local_provider.dart';
import '../../../menu/children/application/children_stream_provider.dart';
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
    final asyncHid = ref.watch(currentHouseholdIdProvider);

    Future<void> handleRetry() async {
      await notifier.loadForMonth(state.focusMonth);
    }

    Future<void> handleRecordTap(MomDailyRecordUiModel record) async {
      // 子どもが登録されているかチェック
      final hid = asyncHid.value;
      if (hid == null) {
        // 世帯IDが取得できない場合は何もしない
        return;
      }

      // ローカルキャッシュとストリームの両方から子ども情報をチェック
      final localChildren = ref.read(childrenLocalProvider(hid)).value;
      final streamChildren = ref.read(childrenStreamProvider(hid)).value;

      final hasChildren = (localChildren != null && localChildren.isNotEmpty) ||
          (streamChildren != null && streamChildren.isNotEmpty);

      if (!hasChildren) {
        // 子どもが登録されていない場合、ダイアログを表示
        if (context.mounted) {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('お知らせ'),
              content: const Text('記録を行うには、まず赤ちゃんの情報を登録してください。'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
        return;
      }

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
