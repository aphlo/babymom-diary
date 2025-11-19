import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingGreetingPage extends StatelessWidget {
  const OnboardingGreetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/icons/milu_greeting.JPG',
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              bottom: 32,
              right: 24,
              child: FilledButton(
                onPressed: () => context.go('/onboarding/child-info'),
                child: const Text('次へ'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
