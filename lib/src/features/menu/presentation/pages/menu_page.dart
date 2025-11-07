import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/features/ads/presentation/widgets/banner_ad_widget.dart';
import 'package:babymom_diary/src/features/menu/children/data/infrastructure/child_firestore_data_source.dart';
import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/features/menu/children/application/selected_child_provider.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

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
    return '${d.year}年${d.month}月${d.day}日生';
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
          final ds = ChildFirestoreDataSource(
              ref.watch(firebaseFirestoreProvider), hid);
          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: ds.childrenQuery().snapshots(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snap.hasError) {
                return Center(child: Text('子どもの読み込みに失敗しました\n${snap.error}'));
              }
              final docs = snap.data?.docs ?? const [];
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        // 子ども一覧セクション
                        for (final d in docs) ...[
                          _ChildListTile(
                            id: d.id,
                            name: (d.data()['name'] as String?) ?? '未設定',
                            color: _parseColor(d.data()['color'] as String?),
                            subtitle: _formatBirthday(
                                d.data()['birthday'] as Timestamp?),
                          ),
                          const Divider(height: 0),
                        ],
                        ListTile(
                          tileColor: Colors.white,
                          leading: const Icon(Icons.add),
                          title: const Text('子どもの追加'),
                          onTap: () => context.push('/children/add'),
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
                        const Divider(height: 0),
                        ListTile(
                          tileColor: Colors.white,
                          leading: const Icon(Icons.vaccines),
                          title: const Text('ワクチンの表示・非表示'),
                          subtitle: const Text('表示するワクチンを選択'),
                          onTap: () => context
                              .push('/household/vaccine-visibility-settings'),
                        ),
                        const Divider(height: 0),
                      ],
                    ),
                  ),
                  const BannerAdWidget(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _ChildListTile extends ConsumerWidget {
  const _ChildListTile(
      {required this.id,
      required this.name,
      required this.color,
      required this.subtitle});
  final String id;
  final String name;
  final Color color;
  final String subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(
      selectedChildControllerProvider.select((v) => v.value == id),
    );
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      key: ValueKey('child-$id'),
      tileColor: isSelected ? scheme.primaryContainer : Colors.white,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () =>
                ref.read(selectedChildControllerProvider.notifier).select(id),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: color,
            child: const Icon(Icons.child_care, color: Colors.white),
          ),
        ],
      ),
      title: Text(name),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push('/children/edit/$id'),
    );
  }
}
