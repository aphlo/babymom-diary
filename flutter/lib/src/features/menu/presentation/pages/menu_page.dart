import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
import 'package:babymom_diary/src/features/menu/presentation/widgets/menu_delete_data_section.dart';
import 'package:babymom_diary/src/features/menu/presentation/widgets/menu_premium_section.dart';
import 'package:babymom_diary/src/features/menu/presentation/widgets/menu_settings_section.dart';
import 'package:babymom_diary/src/features/menu/presentation/widgets/menu_user_id_section.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHid = ref.watch(currentHouseholdIdProvider);
    final membershipType = ref.watch(currentMembershipTypeProvider).value;
    // nullの場合は安全側に倒してfalseとする（ローディング中は非オーナー扱い）
    final isOwner = membershipType == 'owner';

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
                  data: (children) => _MenuListView(
                      hid: hid, children: children, isOwner: isOwner),
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
    required this.isOwner,
  });

  final String hid;
  final List<ChildSummary> children;
  final bool isOwner;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MenuChildrenSection(children: children),
        const SizedBox(height: 24),
        const MenuPremiumSection(),
        const SizedBox(height: 24),
        const MenuSettingsSection(),
        const SizedBox(height: 24),
        const MenuAppearanceSection(),
        const SizedBox(height: 24),
        const MenuAppInfoSection(),
        const MenuUserIdSection(),
        const AppVersionFooter(),
        if (isOwner) MenuDeleteDataSection(householdId: hid),
      ],
    );
  }
}
