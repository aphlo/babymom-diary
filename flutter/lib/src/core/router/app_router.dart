import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../analytics/analytics_service.dart';
import '../../features/ads/application/services/banner_ad_manager.dart';
import '../../features/child_record/presentation/pages/record_table_page.dart';
import '../../features/menu/growth_chart_settings/presentation/pages/growth_chart_settings_page.dart';
import '../../features/vaccines/presentation/pages/vaccines_page.dart';
import '../../features/mom_record/presentation/pages/mom_record_page.dart';
import '../../features/calendar/presentation/pages/calendar_page.dart';
import '../../features/calendar/presentation/pages/calendar_settings_page.dart';
import '../../features/calendar/presentation/pages/add_calendar_event_page.dart';
import '../../features/calendar/domain/entities/calendar_event.dart';
import '../../features/menu/presentation/pages/menu_page.dart';
import '../../features/menu/children/presentation/pages/add_child_page.dart';
import '../../features/menu/children/presentation/pages/manage_children_page.dart';
import '../../features/menu/children/presentation/pages/edit_child_page.dart';
import '../../features/menu/household/presentation/pages/household_share_page.dart';
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
import '../../features/menu/widget_settings/presentation/pages/widget_settings_page.dart';
import '../../features/menu/ingredient_settings/presentation/pages/ingredient_settings_page.dart';
import '../../features/baby_food/presentation/pages/ingredient_detail_page.dart';
import '../../features/baby_food/domain/value_objects/food_category.dart';
import '../../features/feeding_table_settings/presentation/pages/feeding_table_settings_page.dart';
import '../../features/push_notification/presentation/pages/notification_settings_page.dart';

part 'app_router.g.dart';

/// ルートNavigatorのGlobalKey（レビューダイアログ表示などで使用）
final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKeyBaby =
    GlobalKey<NavigatorState>(debugLabel: 'shellBaby');
final _shellNavigatorKeyVaccines =
    GlobalKey<NavigatorState>(debugLabel: 'shellVaccines');
final _shellNavigatorKeyMom = GlobalKey<NavigatorState>(debugLabel: 'shellMom');
final _shellNavigatorKeyCalendar =
    GlobalKey<NavigatorState>(debugLabel: 'shellCalendar');
final _shellNavigatorKeyMenu =
    GlobalKey<NavigatorState>(debugLabel: 'shellMenu');

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final hasCompletedOnboarding = ref.watch(onboardingStatusProvider);
  final analyticsService = ref.watch(analyticsServiceProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/baby',
    observers: [analyticsService.observer],
    redirect: (context, state) {
      // ディープリンク（milu://）はDeepLinkServiceで処理するので、
      // ここでは/babyにリダイレクトして、GoExceptionを回避する
      if (state.uri.scheme == 'milu') {
        return '/baby';
      }

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
        parentNavigatorKey: rootNavigatorKey,
        path: '/onboarding/greeting',
        name: 'onboarding_greeting',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: OnboardingGreetingPage()),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
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
        parentNavigatorKey: rootNavigatorKey,
        path: '/children/add',
        name: 'children_add',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: AddChildPage()),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/children/manage',
        name: 'children_manage',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: ManageChildrenPage()),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/children/edit/:id',
        name: 'children_edit',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return CupertinoPage(child: EditChildPage(childId: id));
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/household/share',
        name: 'household_share',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: HouseholdSharePage()),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/household/vaccine-visibility-settings',
        name: 'vaccine_visibility_settings',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: VaccineVisibilitySettingsPage()),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/growth-chart/settings',
        name: 'growth_chart_settings',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: GrowthChartSettingsPage()),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/widget/settings',
        name: 'widget_settings',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: WidgetSettingsPage()),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/feeding-table/settings',
        name: 'feeding_table_settings',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: FeedingTableSettingsPage()),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/baby-food/ingredients',
        name: 'ingredient_settings',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: IngredientSettingsPage()),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/notification/settings',
        name: 'notification_settings',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: NotificationSettingsPage()),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/baby-food/ingredient-detail',
        name: 'ingredient_detail',
        pageBuilder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          final ingredientId = params['ingredientId'] as String;
          final ingredientName = params['ingredientName'] as String;
          final category = params['category'] as FoodCategory;
          return CupertinoPage(
            child: IngredientDetailPage(
              ingredientId: ingredientId,
              ingredientName: ingredientName,
              category: category,
            ),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
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
        parentNavigatorKey: rootNavigatorKey,
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
        parentNavigatorKey: rootNavigatorKey,
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
        parentNavigatorKey: rootNavigatorKey,
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
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/calendar/add',
        name: 'calendar_add',
        pageBuilder: (context, state) {
          final initialDate = state.extra as DateTime?;
          return CupertinoPage(
            child: AddCalendarEventPage(initialDate: initialDate),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/calendar/edit',
        name: 'calendar_edit',
        pageBuilder: (context, state) {
          final existingEvent = state.extra as CalendarEvent;
          return CupertinoPage(
            child: AddCalendarEventPage(existingEvent: existingEvent),
          );
        },
      ),
    ],
  );
}

// StatefulNavigationShellを使用したスキャフォールドウィジェット
class _ScaffoldWithNavBar extends ConsumerStatefulWidget {
  const _ScaffoldWithNavBar({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<_ScaffoldWithNavBar> createState() =>
      _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends ConsumerState<_ScaffoldWithNavBar> {
  int? _lastPreloadedTabIndex;

  /// タブインデックスをBottomNavTabに変換
  BottomNavTab _indexToTab(int index) {
    return switch (index) {
      0 => BottomNavTab.baby,
      1 => BottomNavTab.vaccines,
      2 => BottomNavTab.mom,
      3 => BottomNavTab.calendar,
      4 => BottomNavTab.menu,
      _ => BottomNavTab.baby,
    };
  }

  /// タブ切り替え時にそのタブの広告をプリロード
  void _preloadAdsForTab(int tabIndex) {
    if (_lastPreloadedTabIndex == tabIndex) return;
    _lastPreloadedTabIndex = tabIndex;

    final tab = _indexToTab(tabIndex);
    final screenWidth = MediaQuery.of(context).size.width;
    final manager = ref.read(bannerAdManagerProvider);
    manager.preloadTab(tab, screenWidth);
  }

  void _onDestinationSelected(int index) {
    // 同じタブを再度タップした場合、ルートページに戻る
    if (index == widget.navigationShell.currentIndex) {
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
      widget.navigationShell.goBranch(index);
      // 切り替え先タブの広告をプリロード
      _preloadAdsForTab(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
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
