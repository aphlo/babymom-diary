import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/child_record/presentation/pages/record_table_page.dart';
import '../../features/child_record/presentation/pages/growth_chart_settings_page.dart';
import '../../features/vaccines/presentation/pages/vaccines_page.dart';
import '../../features/mom_record/presentation/pages/mom_record_page.dart';
import '../../features/calendar/presentation/pages/calendar_page.dart';
import '../../features/calendar/presentation/pages/calendar_settings_page.dart';
import '../../features/menu/presentation/pages/menu_page.dart';
import '../../features/menu/children/presentation/pages/add_child_page.dart';
import '../../features/menu/children/presentation/pages/manage_children_page.dart';
import '../../features/menu/children/presentation/pages/edit_child_page.dart';
import '../../features/menu/household/presentation/pages/household_share_page.dart';
import '../../features/menu/household/presentation/pages/household_invitation_create_page.dart';
import '../../features/menu/household/presentation/pages/household_invitation_join_page.dart';
import '../../features/menu/household/presentation/pages/vaccine_visibility_settings_page.dart';
import '../../features/onboarding/application/onboarding_status_provider.dart';
import '../../features/onboarding/presentation/pages/onboarding_child_info_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_greeting_page.dart';
import '../../features/vaccines/presentation/pages/vaccine_detail_page.dart';
import '../../features/vaccines/presentation/pages/vaccine_reservation_page.dart';
import '../../features/vaccines/presentation/pages/vaccine_scheduled_details_page.dart';
import '../../features/vaccines/presentation/pages/vaccine_reschedule_page.dart';
import '../../features/vaccines/presentation/models/vaccine_info.dart';
import '../../features/vaccines/presentation/viewmodels/vaccine_detail_state.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKeyBaby =
    GlobalKey<NavigatorState>(debugLabel: 'shellBaby');
final _shellNavigatorKeyVaccines =
    GlobalKey<NavigatorState>(debugLabel: 'shellVaccines');
final _shellNavigatorKeyMom = GlobalKey<NavigatorState>(debugLabel: 'shellMom');
final _shellNavigatorKeyCalendar =
    GlobalKey<NavigatorState>(debugLabel: 'shellCalendar');
final _shellNavigatorKeyMenu =
    GlobalKey<NavigatorState>(debugLabel: 'shellMenu');

final appRouterProvider = Provider<GoRouter>((ref) {
  final hasCompletedOnboarding = ref.watch(onboardingStatusProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/baby',
    redirect: (context, state) {
      final isOnboardingRoute = state.uri.path.startsWith('/onboarding');

      if (!hasCompletedOnboarding && !isOnboardingRoute) {
        return '/onboarding/greeting';
      }

      if (hasCompletedOnboarding && isOnboardingRoute) {
        return '/baby';
      }

      return null;
    },
    routes: [
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/onboarding/greeting',
        name: 'onboarding_greeting',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: OnboardingGreetingPage()),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/onboarding/child-info',
        name: 'onboarding_child_info',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: OnboardingChildInfoPage()),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return _ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // ベビーの記録タブ
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKeyBaby,
            routes: [
              GoRoute(
                path: '/baby',
                name: 'baby',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: RecordTablePage()),
              ),
            ],
          ),
          // 予防接種タブ
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKeyVaccines,
            routes: [
              GoRoute(
                path: '/vaccines',
                name: 'vaccines',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: VaccinesPage()),
              ),
            ],
          ),
          // ママの記録タブ
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKeyMom,
            routes: [
              GoRoute(
                path: '/mom',
                name: 'mom',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: MomRecordPage()),
              ),
            ],
          ),
          // カレンダータブ
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKeyCalendar,
            routes: [
              GoRoute(
                path: '/calendar',
                name: 'calendar',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: CalendarPage()),
                routes: [
                  GoRoute(
                    path: 'settings',
                    name: 'calendar_settings',
                    pageBuilder: (context, state) =>
                        const CupertinoPage(child: CalendarSettingsPage()),
                  ),
                ],
              ),
            ],
          ),
          // メニュータブ
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKeyMenu,
            routes: [
              GoRoute(
                path: '/menu',
                name: 'menu',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: MenuPage()),
              ),
            ],
          ),
        ],
      ),
      // ルートレベルのルート（タブ外のページ）
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/children/add',
        name: 'children_add',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: AddChildPage()),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/children/manage',
        name: 'children_manage',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: ManageChildrenPage()),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/children/edit/:id',
        name: 'children_edit',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return CupertinoPage(child: EditChildPage(childId: id));
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/household/share',
        name: 'household_share',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: HouseholdSharePage()),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/household/share/create',
        name: 'household_share_create',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: HouseholdInvitationCreatePage()),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/household/share/join',
        name: 'household_share_join',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: HouseholdInvitationJoinPage()),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/household/vaccine-visibility-settings',
        name: 'vaccine_visibility_settings',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: VaccineVisibilitySettingsPage()),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/growth-chart/settings',
        name: 'growth_chart_settings',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: GrowthChartSettingsPage()),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/vaccines/detail',
        name: 'vaccine_detail',
        pageBuilder: (context, state) {
          final vaccine = state.extra as VaccineInfo;
          return CupertinoPage(
            child: VaccineDetailPage(vaccine: vaccine),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/vaccines/reservation',
        name: 'vaccine_reservation',
        pageBuilder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          final vaccine = params['vaccine'] as VaccineInfo;
          final doseNumber = params['doseNumber'] as int;
          final String? influenzaSeasonLabel =
              params['influenzaSeasonLabel'] as String?;
          final int? influenzaDoseOrder = params['influenzaDoseOrder'] as int?;
          return CupertinoPage(
            child: VaccineReservationPage(
              vaccine: vaccine,
              doseNumber: doseNumber,
              influenzaSeasonLabel: influenzaSeasonLabel,
              influenzaDoseOrder: influenzaDoseOrder,
            ),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/vaccines/scheduled-details',
        name: 'vaccine_scheduled_details',
        pageBuilder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          final vaccine = params['vaccine'] as VaccineInfo;
          final doseNumber = params['doseNumber'] as int;
          final statusInfo = params['statusInfo'] as DoseStatusInfo;
          final String? influenzaSeasonLabel =
              params['influenzaSeasonLabel'] as String?;
          final int? influenzaDoseOrder = params['influenzaDoseOrder'] as int?;
          return CupertinoPage(
            child: VaccineScheduledDetailsPage(
              vaccine: vaccine,
              doseNumber: doseNumber,
              statusInfo: statusInfo,
              influenzaSeasonLabel: influenzaSeasonLabel,
              influenzaDoseOrder: influenzaDoseOrder,
            ),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/vaccines/reschedule',
        name: 'vaccine_reschedule',
        pageBuilder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          final vaccine = params['vaccine'] as VaccineInfo;
          final doseNumber = params['doseNumber'] as int;
          final statusInfo = params['statusInfo'] as DoseStatusInfo;
          final String? influenzaSeasonLabel =
              params['influenzaSeasonLabel'] as String?;
          final int? influenzaDoseOrder = params['influenzaDoseOrder'] as int?;
          return CupertinoPage(
            child: VaccineReschedulePage(
              vaccine: vaccine,
              doseNumber: doseNumber,
              statusInfo: statusInfo,
              influenzaSeasonLabel: influenzaSeasonLabel,
              influenzaDoseOrder: influenzaDoseOrder,
            ),
          );
        },
      ),
    ],
  );
});

// StatefulNavigationShellを使用したスキャフォールドウィジェット
class _ScaffoldWithNavBar extends StatelessWidget {
  const _ScaffoldWithNavBar({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onDestinationSelected(int index) {
    // 同じタブを再度タップした場合、ルートページに戻る
    if (index == navigationShell.currentIndex) {
      // 現在のブランチのナビゲーターキーを取得してポップ
      final navigatorKeys = [
        _shellNavigatorKeyBaby,
        _shellNavigatorKeyVaccines,
        _shellNavigatorKeyMom,
        _shellNavigatorKeyCalendar,
        _shellNavigatorKeyMenu,
      ];

      final currentNavigator = navigatorKeys[index].currentState;
      if (currentNavigator != null && currentNavigator.canPop()) {
        // ネストされたルートがある場合、ルートまでポップバック
        currentNavigator.popUntil((route) => route.isFirst);
      }
    } else {
      // 別のタブに切り替え
      navigationShell.goBranch(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.child_care),
            label: 'ベビーの記録',
          ),
          NavigationDestination(
            icon: Icon(Icons.vaccines),
            label: '予防接種',
          ),
          NavigationDestination(
            icon: Icon(Icons.face_4),
            label: 'ママの記録',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today),
            label: 'カレンダー',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu),
            label: 'メニュー',
          ),
        ],
      ),
    );
  }
}
