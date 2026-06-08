import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/semantic_colors.dart';
import '../../../../ads/application/services/banner_ad_manager.dart';
import '../../../../ads/presentation/widgets/banner_ad_widget.dart';

/// ベビーの記録の設定画面
class BabyRecordSettingsPage extends StatelessWidget {
  const BabyRecordSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: const Text('ベビーの記録の設定'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  color: context.cardBackground,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.table_chart_outlined),
                        title: const Text('授乳表の設定'),
                        subtitle: const Text('表示する列のカスタマイズ'),
                        onTap: () => context.push('/feeding-table/settings'),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                      const Divider(height: 0, indent: 16),
                      ListTile(
                        leading: const Icon(Icons.restaurant_menu),
                        title: const Text('離乳食の食材管理'),
                        subtitle: const Text('食材の追加・削除'),
                        onTap: () => context.push('/baby-food/ingredients'),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                      const Divider(height: 0, indent: 16),
                      ListTile(
                        leading: const Icon(Icons.show_chart),
                        title: const Text('成長曲線の設定'),
                        subtitle: const Text('修正月齢での表示設定'),
                        onTap: () => context.push('/growth-chart/settings'),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const BannerAdWidget(slot: BannerAdSlot.babyRecordSettings),
        ],
      ),
    );
  }
}
