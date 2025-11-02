import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/child_record/presentation/pages/record_table_page.dart';
import '../../features/vaccines/presentation/pages/vaccines_page.dart';
import '../../features/mom_record/presentation/pages/mom_record_page.dart';
import '../../features/calendar/presentation/pages/calendar_page.dart';
import '../../features/calendar/presentation/pages/calendar_settings_page.dart';
import '../../features/menu/presentation/pages/menu_page.dart';
import '../../features/children/presentation/pages/add_child_page.dart';
import '../../features/children/presentation/pages/manage_children_page.dart';
import '../../features/children/presentation/pages/edit_child_page.dart';
import '../../features/household/presentation/pages/household_share_page.dart';
import '../../features/vaccines/presentation/pages/vaccine_detail_page.dart';
import '../../features/vaccines/presentation/pages/vaccine_reservation_page.dart';
import '../../features/vaccines/presentation/models/vaccine_info.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/baby',
    routes: [
      GoRoute(
        path: '/',
        redirect: (_, __) => '/baby',
      ),
      GoRoute(
        path: '/baby',
        name: 'baby',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: RecordTablePage()),
      ),
      GoRoute(
        path: '/vaccines',
        name: 'vaccines',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: VaccinesPage()),
      ),
      GoRoute(
        path: '/mom',
        name: 'mom',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: MomRecordPage()),
      ),
      GoRoute(
        path: '/calendar',
        name: 'calendar',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: CalendarPage()),
      ),
      GoRoute(
        path: '/calendar/settings',
        name: 'calendar_settings',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: CalendarSettingsPage()),
      ),
      GoRoute(
        path: '/menu',
        name: 'menu',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: MenuPage()),
      ),
      GoRoute(
        path: '/children/add',
        name: 'children_add',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: AddChildPage()),
      ),
      GoRoute(
        path: '/children/manage',
        name: 'children_manage',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: ManageChildrenPage()),
      ),
      GoRoute(
        path: '/children/edit/:id',
        name: 'children_edit',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return CupertinoPage(child: EditChildPage(childId: id));
        },
      ),
      GoRoute(
        path: '/household/share',
        name: 'household_share',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: HouseholdSharePage()),
      ),
      GoRoute(
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
    ],
  );
});
