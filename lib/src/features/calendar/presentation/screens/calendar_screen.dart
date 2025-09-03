import 'package:flutter/material.dart';
import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('カレンダー')),
      body: const Center(child: Text('カレンダー（準備中）')),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}
