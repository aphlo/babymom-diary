import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/baby_log/presentation/screens/log_list_screen.dart';
import '../../features/baby_log/presentation/screens/add_entry_screen.dart';
import '../../features/vaccines/presentation/screens/vaccines_screen.dart';
import '../../features/mom/presentation/screens/mom_screen.dart';
import '../../features/calendar/presentation/screens/calendar_screen.dart';
import '../../features/menu/presentation/screens/menu_screen.dart';

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
    ],
  );
});
