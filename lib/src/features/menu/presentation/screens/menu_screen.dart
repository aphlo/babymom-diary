import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';
import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/features/children/data/sources/child_firestore_data_source.dart';
import 'package:babymom_diary/src/core/theme/app_colors.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  Color _parseColor(String? hex) {
    if (hex == null || hex.isEmpty) return Colors.grey;
    final cleaned = hex.replaceFirst('#', '');
    final value = int.tryParse(cleaned, radix: 16);
    if (value == null) return Colors.grey;
    return Color(0xFF000000 | value);
  }

  String _formatBirthday(Timestamp? ts) {
    if (ts == null) return '';
    final d = ts.toDate();
    return '${d.year}年${d.month}月${d.day}日';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHid = ref.watch(currentHouseholdIdProvider);
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(title: const Text('メニュー')),
      body: asyncHid.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, __) => Center(child: Text('読み込みに失敗しました\n$e')),
        data: (hid) {
          final ds = ChildFirestoreDataSource(ref.watch(firebaseFirestoreProvider), hid);
          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: ds.childrenQuery().snapshots(),
            builder: (context, snap) {
              final docs = snap.data?.docs ?? const [];
              return ListView(
                children: [
                  // 子ども一覧セクション
                  for (final d in docs)
                    ListTile(
                      tileColor: Colors.white,
                      leading: CircleAvatar(
                        backgroundColor: _parseColor(d.data()['color'] as String?),
                        child: const Icon(Icons.child_care, color: Colors.white),
                      ),
                      title: Text((d.data()['name'] as String?) ?? '未設定'),
                      subtitle: Text(_formatBirthday(d.data()['birthday'] as Timestamp?)),
                      onTap: () => context.push('/children/edit/${d.id}'),
                    ),
                  const Divider(height: 0),
                  ListTile(
                    tileColor: Colors.white,
                    leading: const Icon(Icons.edit),
                    title: const Text('子どもの追加・編集'),
                    onTap: () => context.push('/children/manage', extra: 'slide'),
                    trailing: const Icon(Icons.chevron_right),
                  ),

                  const SizedBox(height: 24),
                  const Divider(height: 0),
                  ListTile(
                    tileColor: Colors.white,
                    leading: const Icon(Icons.group_add),
                    title: const Text('世帯の共有'),
                    subtitle: const Text('招待コードの発行 / コードで参加'),
                    onTap: () => context.push('/household/share'),
                  ),
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}
