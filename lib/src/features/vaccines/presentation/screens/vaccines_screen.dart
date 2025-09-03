import 'package:flutter/material.dart';
import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';

class VaccinesScreen extends StatelessWidget {
  const VaccinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('予防接種')),
      body: const Center(child: Text('予防接種の記録（準備中）')),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}
