import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:babymom_diary/src/features/menu/presentation/widgets/menu_section.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/core/theme/semantic_colors.dart';
import 'package:babymom_diary/src/features/ads/application/services/banner_ad_manager.dart';
import 'package:babymom_diary/src/features/ads/presentation/widgets/banner_ad_widget.dart';
import 'package:babymom_diary/src/features/menu/children/application/children_stream_provider.dart';
import 'package:babymom_diary/src/features/menu/children/domain/entities/child_summary.dart';
import 'package:babymom_diary/src/features/menu/presentation/widgets/app_version_footer.dart';
import 'package:babymom_diary/src/features/menu/presentation/widgets/menu_appearance_section.dart';
import 'package:babymom_diary/src/features/menu/presentation/widgets/menu_app_info_section.dart';
import 'package:babymom_diary/src/features/menu/presentation/widgets/menu_children_section.dart';

import 'package:babymom_diary/src/features/menu/presentation/widgets/menu_premium_section.dart';
import 'package:babymom_diary/src/features/menu/presentation/widgets/menu_ad_free_reward_section.dart';
import 'package:babymom_diary/src/features/menu/presentation/widgets/menu_settings_section.dart';
import 'package:babymom_diary/src/features/menu/presentation/widgets/menu_user_id_section.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHid = ref.watch(currentHouseholdIdProvider);

    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(title: const Text('メニュー')),
      body: Column(
        children: [
          Expanded(
            child: asyncHid.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, __) => Center(child: Text('読み込みに失敗しました\n$e')),
              data: (hid) {
                final childrenAsync = ref.watch(childrenStreamProvider(hid));
                return childrenAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, __) => Center(child: Text('子どもの読み込みに失敗しました\n$e')),
                  data: (children) =>
                      _MenuListView(hid: hid, children: children),
                );
              },
            ),
          ),
          const BannerAdWidget(slot: BannerAdSlot.menu),
        ],
      ),
    );
  }
}

class _MenuListView extends StatelessWidget {
  const _MenuListView({
    required this.hid,
    required this.children,
  });

  final String hid;
  final List<ChildSummary> children;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MenuChildrenSection(children: children),
        const SizedBox(height: 24),
        const MenuPremiumSection(),
        const SizedBox(height: 12),
        const MenuAdFreeRewardSection(),
        const SizedBox(height: 24),
        const MenuSettingsSection(),
        const SizedBox(height: 24),
        const MenuAppearanceSection(),
        const SizedBox(height: 24),
        const MenuAppInfoSection(),
        const MenuUserIdSection(),
        const AppVersionFooter(),
        const SizedBox(height: 24),
        MenuSection(
          children: [
            ListTile(
              leading:
                  const Icon(Icons.no_accounts_outlined, color: Colors.red),
              title: const Text(
                '退会',
                style: TextStyle(color: Colors.red),
              ),
              subtitle: const Text('退会と全データの削除'),
              onTap: () => context.push('/menu/withdraw'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
