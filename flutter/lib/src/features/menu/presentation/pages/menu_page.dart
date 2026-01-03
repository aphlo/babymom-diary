import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/features/menu/children/application/children_stream_provider.dart';
import 'package:babymom_diary/src/features/menu/children/domain/entities/child_summary.dart';
import 'package:babymom_diary/src/features/menu/data_management/application/providers/data_management_providers.dart';
import 'package:babymom_diary/src/features/menu/data_management/presentation/widgets/delete_data_confirmation_dialog.dart';
import 'package:babymom_diary/src/features/menu/presentation/widgets/app_version_footer.dart';
import 'package:babymom_diary/src/features/menu/presentation/widgets/child_list_tile.dart';
import 'package:babymom_diary/src/features/menu/presentation/widgets/children_empty_state.dart';
import 'package:babymom_diary/src/features/menu/presentation/widgets/menu_section.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});
  static const _termsUrl =
      'https://striped-polonium-ee6.notion.site/milu-2b1de238aa6080acb2a3cbe274d05564?source=copy_link';
  static const _privacyUrl =
      'https://striped-polonium-ee6.notion.site/milu-2b1de238aa60803697b1f06f3c32d2ec?source=copy_link';

  String _formatBirthday(DateTime birthday) {
    return '${birthday.year}年${birthday.month}月${birthday.day}日生';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHid = ref.watch(currentHouseholdIdProvider);
    final membershipType = ref.watch(currentMembershipTypeProvider).value;
    // nullの場合は安全側に倒してfalseとする（ローディング中は非オーナー扱い）
    final isOwner = membershipType == 'owner';
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(title: const Text('メニュー')),
      body: asyncHid.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, __) => Center(child: Text('読み込みに失敗しました\n$e')),
        data: (hid) {
          final childrenAsync = ref.watch(childrenStreamProvider(hid));
          return childrenAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, __) => Center(child: Text('子どもの読み込みに失敗しました\n$e')),
            data: (children) =>
                _buildMenuList(context, ref, hid, children, isOwner),
          );
        },
      ),
    );
  }

  Widget _buildMenuList(
    BuildContext context,
    WidgetRef ref,
    String hid,
    List<ChildSummary> children,
    bool isOwner,
  ) {
    return ListView(
      children: [
        // 子ども一覧セクション
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

        const SizedBox(height: 24),

        MenuSection(
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
              onTap: () =>
                  context.push('/household/vaccine-visibility-settings'),
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
        ),

        const SizedBox(height: 24),
        // データ削除メニューはオーナーのみ表示
        if (isOwner) ...[
          MenuSection(
            children: [
              ListTile(
                leading: const Icon(Icons.delete_forever, color: Colors.red),
                title: const Text(
                  'データの削除',
                  style: TextStyle(color: Colors.red),
                ),
                subtitle: const Text('すべてのデータを削除'),
                onTap: () => _handleDeleteData(context, ref, hid),
                trailing: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
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
        MenuSection(
          children: [
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: const Text('利用規約'),
              onTap: () => _launchExternalUrl(context, _termsUrl),
              trailing: const Icon(Icons.open_in_new),
            ),
            const Divider(height: 0),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('プライバシーポリシー'),
              onTap: () => _launchExternalUrl(context, _privacyUrl),
              trailing: const Icon(Icons.open_in_new),
            ),
            const Divider(height: 0),
            ListTile(
              leading: const Icon(Icons.article_outlined),
              title: const Text('ライセンス'),
              onTap: () => showLicensePage(
                context: context,
                applicationName: 'milu',
                applicationLegalese: '© 2025 aphlo',
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        const AppVersionFooter(),
      ],
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
