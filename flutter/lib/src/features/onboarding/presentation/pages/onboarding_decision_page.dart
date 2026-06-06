import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';
import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/core/widgets/floating_balloons_background.dart';

class OnboardingDecisionPage extends ConsumerStatefulWidget {
  const OnboardingDecisionPage({super.key});

  @override
  ConsumerState<OnboardingDecisionPage> createState() =>
      _OnboardingDecisionPageState();
}

class _OnboardingDecisionPageState
    extends ConsumerState<OnboardingDecisionPage> {
  bool _isLoading = false;

  Future<void> _handleStartFirstTime() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 1. 匿名認証でサインイン
      await FirebaseAuth.instance.signInAnonymously();

      // 2. 世帯（Household）の作成/確認
      final householdService = ref.read(householdServiceProvider);
      await householdService.ensureHousehold();

      if (mounted) {
        // 子どもの登録画面へ遷移
        context.go('/onboarding/child-info');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('初期化に失敗しました: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: context.surfaceBackground,
      body: FloatingBalloonsBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // アプリのロゴか可愛いアイコン
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/icons/onboarding_decision_welcome.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'miluへようこそ！',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '赤ちゃんの成長記録や予防接種の管理を\nはじめましょう',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: context.textSecondary,
                    height: 1.5,
                  ),
                ),
                const Spacer(),
                if (_isLoading)
                  const CircularProgressIndicator()
                else ...[
                  // はじめて利用する
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: _handleStartFirstTime,
                      style: FilledButton.styleFrom(
                        backgroundColor: context.primaryColor,
                        foregroundColor: context.onPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Text(
                        'はじめて利用する',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // データを引き継ぐ / ログイン
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () => context.go('/onboarding/sign-in'),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: context.primaryColor, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        'データを引き継ぐ / ログイン',
                        style: TextStyle(
                          color: context.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
