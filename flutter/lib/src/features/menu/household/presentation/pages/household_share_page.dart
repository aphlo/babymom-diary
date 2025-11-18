import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_colors.dart';

class HouseholdSharePage extends StatelessWidget {
  const HouseholdSharePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
        title: const Text('世帯の共有'),
      ),
      body: ListView(
        children: const [
          _MenuListTile(
            icon: Icons.qr_code,
            title: '招待コードの発行',
            description: '新しい招待コードの発行や有効なコードを確認',
            route: '/household/share/create',
          ),
          Divider(height: 0),
          _MenuListTile(
            icon: Icons.group_add,
            title: '招待コードで参加',
            description: '受け取った招待コードを入力して世帯に参加',
            route: '/household/share/join',
          ),
          Divider(height: 0),
        ],
      ),
    );
  }
}

class _MenuListTile extends StatelessWidget {
  const _MenuListTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.route,
  });

  final IconData icon;
  final String title;
  final String description;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(description),
      trailing: const Icon(Icons.chevron_right),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      minLeadingWidth: 40,
      onTap: () => context.push(route),
    );
  }
}
