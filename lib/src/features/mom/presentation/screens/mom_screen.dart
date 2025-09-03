import 'package:flutter/material.dart';
import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';

class MomScreen extends StatelessWidget {
  const MomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ママの記録')),
      body: const Center(child: Text('ママ向けの機能（準備中）')),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}
