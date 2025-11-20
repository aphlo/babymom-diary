import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/features/ads/presentation/widgets/banner_ad_widget.dart';
import 'package:babymom_diary/src/features/menu/children/data/infrastructure/child_firestore_data_source.dart';
import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/features/menu/children/application/child_color_provider.dart';
import 'package:babymom_diary/src/features/menu/children/application/selected_child_provider.dart';
import 'package:babymom_diary/src/features/menu/data_management/application/providers/data_management_providers.dart';
import 'package:babymom_diary/src/features/menu/data_management/presentation/widgets/delete_data_confirmation_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});
  static const _termsUrl =
      'https://striped-polonium-ee6.notion.site/milu-2b1de238aa6080acb2a3cbe274d05564?source=copy_link';
  static const _privacyUrl =
      'https://striped-polonium-ee6.notion.site/milu-2b1de238aa60803697b1f06f3c32d2ec?source=copy_link';

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
                        if (docs.isEmpty) ...[
                          const _ChildrenEmptyState(),
                          const SizedBox(height: 16),
                        ],
                        for (final d in docs) ...[
                          _ChildListTile(
                            id: d.id,
                            name: (d.data()['name'] as String?) ?? '未設定',
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
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          minLeadingWidth: 40,
                        ),
                        const Divider(height: 0),

                        const SizedBox(height: 24),

                        const Divider(height: 0),
                        ListTile(
                          tileColor: Colors.white,
                          leading: const Icon(Icons.group_add),
                          title: const Text('世帯の共有'),
                          subtitle: const Text('招待コードの発行 / コードで参加'),
                          onTap: () => context.push('/household/share'),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        const Divider(height: 0),
                        ListTile(
                          tileColor: Colors.white,
                          leading: const Icon(Icons.show_chart),
                          title: const Text('成長曲線の設定'),
                          subtitle: const Text('修正月齢での表示設定'),
                          onTap: () => context.push('/growth-chart/settings'),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        const Divider(height: 0),
                        ListTile(
                          tileColor: Colors.white,
                          leading: const Icon(Icons.vaccines),
                          title: const Text('ワクチンの表示・非表示'),
                          subtitle: const Text('表示するワクチンを選択'),
                          onTap: () => context
                              .push('/household/vaccine-visibility-settings'),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        const Divider(height: 0),

                        const SizedBox(height: 24),
                        const Divider(height: 0),
                        ListTile(
                          tileColor: Colors.white,
                          leading: const Icon(Icons.delete_forever,
                              color: Colors.red),
                          title: const Text(
                            'データの削除',
                            style: TextStyle(color: Colors.red),
                          ),
                          subtitle: const Text('すべてのデータを削除'),
                          onTap: () => _handleDeleteData(context, ref, hid),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        const Divider(height: 0),
                        const SizedBox(height: 24),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'アプリの情報',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        const Divider(height: 0),
                        ListTile(
                          tileColor: Colors.white,
                          leading: const Icon(Icons.description_outlined),
                          title: const Text('利用規約'),
                          onTap: () => _launchExternalUrl(context, _termsUrl),
                          trailing: const Icon(Icons.open_in_new),
                        ),
                        const Divider(height: 0),
                        ListTile(
                          tileColor: Colors.white,
                          leading: const Icon(Icons.privacy_tip_outlined),
                          title: const Text('プライバシーポリシー'),
                          onTap: () => _launchExternalUrl(context, _privacyUrl),
                          trailing: const Icon(Icons.open_in_new),
                        ),
                        const Divider(height: 0),
                        const _AppVersionFooter(),
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

  Future<void> _launchExternalUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.inAppWebView,
    );
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('外部サイトを開けませんでした')),
      );
    }
  }

  Future<void> _handleDeleteData(
      BuildContext context, WidgetRef ref, String householdId) async {
    // Show confirmation dialog
    final confirmed = await DeleteDataConfirmationDialog.show(context);
    if (!confirmed) return;

    if (!context.mounted) return;

    // Show loading snackbar instead of dialog to avoid Navigator issues
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            SizedBox(width: 16),
            Text('データを削除しています...'),
          ],
        ),
        duration: Duration(days: 1), // Will be dismissed manually
      ),
    );

    try {
      // Execute deletion
      final deleteUseCase = ref.read(deleteAllHouseholdDataProvider);
      await deleteUseCase.execute(householdId);

      if (!context.mounted) return;

      // Clear the loading snackbar
      ScaffoldMessenger.of(context).clearSnackBars();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('データを削除しました'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      // Clear the loading snackbar
      ScaffoldMessenger.of(context).clearSnackBars();

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('削除に失敗しました: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }
}

class _ChildrenEmptyState extends StatelessWidget {
  const _ChildrenEmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Column(
        children: [
          Icon(
            Icons.child_care_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            '子どもが登録されていません',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '下のボタンから子どもを追加してください',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ChildListTile extends ConsumerWidget {
  const _ChildListTile({
    required this.id,
    required this.name,
    required this.subtitle,
  });
  final String id;
  final String name;
  final String subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(
      selectedChildControllerProvider.select((v) => v.value == id),
    );
    // SharedPreferencesから色を取得
    final color = ref
        .watch(childColorProvider.notifier)
        .getColor(id, defaultColor: AppColors.primary);

    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      key: ValueKey('child-$id'),
      tileColor: isSelected ? scheme.primaryContainer : Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      minLeadingWidth: 40,
      leading: InkWell(
        onTap: () =>
            ref.read(selectedChildControllerProvider.notifier).select(id),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
          child: Icon(
            isSelected ? Icons.check_circle : Icons.circle_outlined,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey,
            size: 28,
          ),
        ),
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 16,
            child: const Icon(Icons.child_care, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push('/children/edit/$id'),
    );
  }
}

class _AppVersionFooter extends StatelessWidget {
  const _AppVersionFooter();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final packageInfo = snapshot.data!;
        final version = packageInfo.version;

        return Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.centerRight,
          child: Text(
            'バージョン $version',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                ),
          ),
        );
      },
    );
  }
}
