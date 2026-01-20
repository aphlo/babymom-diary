import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'menu_section.dart';

/// メニューの設定セクション
class MenuSettingsSection extends StatelessWidget {
  const MenuSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuSection(
      children: [
        ListTile(
          leading: const Icon(Icons.group_add),
          title: const Text('世帯の共有'),
          subtitle: const Text('世帯の共有 / 世帯への参加'),
          onTap: () => context.push('/household/share'),
          trailing: const Icon(Icons.chevron_right),
        ),
        const Divider(height: 0),
        ListTile(
          leading: const Icon(Icons.table_chart_outlined),
          title: const Text('授乳表の設定'),
          subtitle: const Text('表示する列のカスタマイズ'),
          onTap: () => context.push('/feeding-table/settings'),
          trailing: const Icon(Icons.chevron_right),
        ),
        const Divider(height: 0),
        ListTile(
          leading: const Icon(Icons.restaurant_menu),
          title: const Text('離乳食の食材管理'),
          subtitle: const Text('食材の追加・削除'),
          onTap: () => context.push('/baby-food/ingredients'),
          trailing: const Icon(Icons.chevron_right),
        ),
        const Divider(height: 0),
        ListTile(
          leading: const Icon(Icons.show_chart),
          title: const Text('成長曲線の設定'),
          subtitle: const Text('修正月齢での表示設定'),
          onTap: () => context.push('/growth-chart/settings'),
          trailing: const Icon(Icons.chevron_right),
        ),
        const Divider(height: 0),
        ListTile(
          leading: const Icon(Icons.vaccines),
          title: const Text('ワクチンの表示・非表示'),
          subtitle: const Text('表示するワクチンを選択'),
          onTap: () => context.push('/household/vaccine-visibility-settings'),
          trailing: const Icon(Icons.chevron_right),
        ),
        const Divider(height: 0),
        ListTile(
          leading: const Icon(Icons.widgets_outlined),
          title: const Text('ウィジェット設定'),
          subtitle: const Text('表示項目・クイックアクションの設定'),
          onTap: () => context.push('/widget/settings'),
          trailing: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
