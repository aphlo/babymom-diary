import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../children/domain/entities/child_summary.dart';
import 'child_list_tile.dart';
import 'children_empty_state.dart';
import 'menu_section.dart';

/// メニューの子ども一覧セクション
class MenuChildrenSection extends StatelessWidget {
  const MenuChildrenSection({
    super.key,
    required this.children,
  });

  final List<ChildSummary> children;

  String _formatBirthday(DateTime birthday) {
    return '${birthday.year}年${birthday.month}月${birthday.day}日生';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (children.isEmpty) ...[
          const ChildrenEmptyState(),
          const SizedBox(height: 16),
        ],
        MenuSection(
          children: [
            for (int i = 0; i < children.length; i++) ...[
              ChildListTile(
                id: children[i].id,
                name: children[i].name,
                subtitle: _formatBirthday(children[i].birthday),
                icon: children[i].icon,
              ),
              const Divider(height: 0),
            ],
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('子どもの追加'),
              onTap: () => context.push('/children/add'),
              trailing: const Icon(Icons.chevron_right),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              minLeadingWidth: 40,
            ),
          ],
        ),
      ],
    );
  }
}
