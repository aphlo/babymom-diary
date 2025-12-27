import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/firebase/household_service.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/types/child_icon.dart';
import '../../../../../core/types/gender.dart';
import '../../application/children_stream_provider.dart';
import '../../domain/entities/child_summary.dart';

class ManageChildrenPage extends ConsumerWidget {
  const ManageChildrenPage({super.key});

  String _formatBirthday(DateTime birthday) {
    return '${birthday.year}年${birthday.month}月${birthday.day}日生';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHid = ref.watch(currentHouseholdIdProvider);
    return asyncHid.when(
      data: (hid) {
        final childrenAsync = ref.watch(childrenStreamProvider(hid));
        return Scaffold(
          backgroundColor: AppColors.pageBackground,
          appBar: AppBar(
            leading: BackButton(onPressed: () => context.pop()),
            title: const Text('子どもの追加・編集'),
          ),
          body: childrenAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, __) => Center(child: Text('読み込みに失敗しました\n$e')),
            data: (children) => _buildChildrenList(context, ref, children),
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, __) => Scaffold(body: Center(child: Text('読み込みに失敗しました\n$e'))),
    );
  }

  Widget _buildChildrenList(
    BuildContext context,
    WidgetRef ref,
    List<ChildSummary> children,
  ) {
    return ListView.separated(
      itemCount: children.length + 1,
      separatorBuilder: (_, __) => const Divider(height: 0),
      itemBuilder: (context, index) {
        if (index == children.length) {
          return ListTile(
            tileColor: Colors.white,
            leading: const Icon(Icons.add),
            title: const Text('新規追加'),
            onTap: () => context.push('/children/add'),
          );
        }
        final child = children[index];
        return ListTile(
          tileColor: Colors.white,
          leading: Image.asset(child.icon.assetPath, width: 40, height: 40),
          title: Text(child.name),
          subtitle: Text(
            '${_formatBirthday(child.birthday)} ${child.gender.labelJa}',
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/children/edit/${child.id}'),
        );
      },
    );
  }
}
