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
          leading: const Icon(Icons.child_care),
          title: const Text('ベビーの記録の設定'),
          subtitle: const Text('授乳表・離乳食・成長曲線'),
          onTap: () => context.push('/baby-record/settings'),
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
          leading: const Icon(Icons.notifications_outlined),
          title: const Text('通知設定'),
          subtitle: const Text('プッシュ通知の設定'),
          onTap: () => context.push('/notification/settings'),
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
        const Divider(height: 0),
        ListTile(
          leading: const Icon(Icons.sync),
          title: const Text('機種変更・データ引き継ぎ'),
          subtitle: const Text('アカウントの作成 / ログイン'),
          onTap: () => context.push('/menu/account-link'),
          trailing: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
