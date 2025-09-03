import 'package:flutter/material.dart';
import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('メニュー')),
      body: const Center(child: Text('各種設定・ヘルプ（準備中）')),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}
