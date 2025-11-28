import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key});

  static final _tabs = <_Tab>[
    const _Tab('/baby', 'ベビーの記録', Icons.child_care),
    const _Tab('/vaccines', '予防接種', Icons.vaccines),
    const _Tab('/mom', 'ママの記録', Icons.face_4),
    const _Tab('/calendar', 'カレンダー', Icons.calendar_today),
    const _Tab('/menu', 'メニュー', Icons.menu),
  ];

  int _indexForLocation(String location) {
    if (location == '/' ||
        location.startsWith('/baby') ||
        location.startsWith('/add')) {
      return 0;
    }
    for (var i = 0; i < _tabs.length; i++) {
      if (location.startsWith(_tabs[i].route)) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final currentIndex = _indexForLocation(location);

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) {
        final to = _tabs[index].route;
        if (to != location) {
          context.go(to);
        }
      },
      destinations: [
        for (final t in _tabs)
          NavigationDestination(
            icon: Icon(t.icon),
            label: t.label,
          ),
      ],
    );
  }
}

class _Tab {
  const _Tab(this.route, this.label, this.icon);
  final String route;
  final String label;
  final IconData icon;
}
