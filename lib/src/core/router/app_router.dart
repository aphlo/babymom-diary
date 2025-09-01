import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/baby_log/presentation/screens/log_list_screen.dart';
import '../../features/baby_log/presentation/screens/add_entry_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const LogListScreen(),
      ),
      GoRoute(
        path: '/add',
        name: 'add',
        pageBuilder: (context, state) => const MaterialPage(
          child: AddEntryScreen(),
        ),
      ),
    ],
  );
});