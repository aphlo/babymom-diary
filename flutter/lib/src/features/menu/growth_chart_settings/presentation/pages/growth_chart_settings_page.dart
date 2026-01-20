import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/semantic_colors.dart';
import '../../../../ads/application/services/banner_ad_manager.dart';
import '../../../../ads/presentation/widgets/banner_ad_widget.dart';
import '../../application/growth_chart_settings_provider.dart';

class GrowthChartSettingsPage extends ConsumerWidget {
  const GrowthChartSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useCorrectedAge = ref.watch(growthChartSettingsProvider);

    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: const Text('成長曲線の設定'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '修正月齢の表示について',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '早産のお子さまの成長をより適切に評価するための機能です。\n修正月齢での表示には出産予定日の登録が必要です（設定からいつでも登録できます）。',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: context.textSecondary,
                              height: 1.5,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  color: context.cardBackground,
                  child: SwitchListTile(
                    title: const Text('修正月齢で表示する'),
                    value: useCorrectedAge,
                    onChanged: (value) {
                      ref
                          .read(growthChartSettingsProvider.notifier)
                          .setUseCorrectedAge(value);
                    },
                  ),
                ),
              ],
            ),
          ),
          const BannerAdWidget(slot: BannerAdSlot.growthChartSettings),
        ],
      ),
    );
  }
}
