import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/firebase/household_service.dart';
import '../../../../../core/types/gender.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../application/child_color_provider.dart';
import '../../data/infrastructure/child_firestore_data_source.dart';

class ManageChildrenPage extends ConsumerWidget {
  const ManageChildrenPage({super.key});

  String _formatBirthday(Timestamp? ts) {
    if (ts == null) return '';
    final d = ts.toDate();
    return '${d.year}年${d.month}月${d.day}日生';
  }

  String _formatGender(String? g) => genderFromKey(g).labelJa;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHid = ref.watch(currentHouseholdIdProvider);
    return asyncHid.when(
      data: (hid) {
        final ds =
            ChildFirestoreDataSource(ref.watch(firebaseFirestoreProvider), hid);
        return Scaffold(
          backgroundColor: AppColors.pageBackground,
          appBar: AppBar(
            leading: BackButton(onPressed: () => context.pop()),
            title: const Text('子どもの追加・編集'),
          ),
          body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: ds.childrenQuery().snapshots(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final docs = snap.data?.docs ?? const [];
              return ListView.separated(
                itemCount: docs.length + 1,
                separatorBuilder: (_, __) => const Divider(height: 0),
                itemBuilder: (context, index) {
                  if (index == docs.length) {
                    return ListTile(
                      tileColor: Colors.white,
                      leading: const Icon(Icons.add),
                      title: const Text('新規追加'),
                      onTap: () => context.push('/children/add'),
                    );
                  }
                  final d = docs[index];
                  final data = d.data();
                  // SharedPreferencesから色を取得
                  final color = ref
                      .read(childColorProvider.notifier)
                      .getColor(d.id, defaultColor: AppColors.primary);
                  return ListTile(
                    tileColor: Colors.white,
                    leading: CircleAvatar(
                        backgroundColor: color,
                        child:
                            const Icon(Icons.child_care, color: Colors.white)),
                    title: Text((data['name'] as String?) ?? '未設定'),
                    subtitle: Text(
                        '${_formatBirthday(data['birthday'] as Timestamp?)} ${_formatGender(data['gender'] as String?)}'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/children/edit/${d.id}'),
                  );
                },
              );
            },
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, __) => Scaffold(body: Center(child: Text('読み込みに失敗しました\n$e'))),
    );
  }
}
