import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/child_record/presentation/pages/record_table_page.dart';
import '../../features/vaccines/presentation/screens/vaccines_screen.dart';
import '../../features/mom_record/presentation/pages/mom_record_page.dart';
import '../../features/calendar/presentation/pages/calendar_page.dart';
import '../../features/menu/presentation/screens/menu_screen.dart';
import '../../features/children/presentation/screens/add_child_screen.dart';
import '../../features/children/presentation/screens/manage_children_screen.dart';
import '../../features/children/presentation/screens/edit_child_screen.dart';
import '../../features/household/presentation/screens/household_share_screen.dart';

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
            const NoTransitionPage(child: VaccinesScreen()),
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
        path: '/menu',
        name: 'menu',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: MenuScreen()),
      ),
      GoRoute(
        path: '/children/add',
        name: 'children_add',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: AddChildScreen()),
      ),
      GoRoute(
        path: '/children/manage',
        name: 'children_manage',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: ManageChildrenScreen()),
      ),
      GoRoute(
        path: '/children/edit/:id',
        name: 'children_edit',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return CupertinoPage(child: EditChildScreen(childId: id));
        },
      ),
      GoRoute(
        path: '/household/share',
        name: 'household_share',
        pageBuilder: (context, state) =>
            const CupertinoPage(child: HouseholdShareScreen()),
      ),
    ],
  );
});
