import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/baby_log/presentation/screens/log_list_screen.dart';
import '../../features/baby_log/presentation/screens/add_entry_screen.dart';
import '../../features/vaccines/presentation/screens/vaccines_screen.dart';
import '../../features/mom/presentation/screens/mom_screen.dart';
import '../../features/calendar/presentation/screens/calendar_screen.dart';
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
            const NoTransitionPage(child: LogListScreen()),
      ),
      GoRoute(
        path: '/add',
        name: 'add',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: AddEntryScreen()),
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
            const NoTransitionPage(child: MomScreen()),
      ),
      GoRoute(
        path: '/calendar',
        name: 'calendar',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: CalendarScreen()),
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
            const NoTransitionPage(child: AddChildScreen()),
      ),
      GoRoute(
        path: '/children/manage',
        name: 'children_manage',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: ManageChildrenScreen()),
      ),
      GoRoute(
        path: '/children/edit/:id',
        name: 'children_edit',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return NoTransitionPage(child: EditChildScreen(childId: id));
        },
      ),
      GoRoute(
        path: '/household/share',
        name: 'household_share',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: HouseholdShareScreen()),
      ),
    ],
  );
});
