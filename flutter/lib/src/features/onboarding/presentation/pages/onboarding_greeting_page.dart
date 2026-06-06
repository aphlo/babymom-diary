import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';

class OnboardingGreetingPage extends StatefulWidget {
  const OnboardingGreetingPage({super.key});

  @override
  State<OnboardingGreetingPage> createState() => _OnboardingGreetingPageState();
}

class _OnboardingGreetingPageState extends State<OnboardingGreetingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingStep> _steps = const [
    OnboardingStep(
      imagePath: 'assets/icons/onboarding_welcome.png',
      title: 'ダウンロード\nありがとうございます！',
      description: 'milu（ミル）は、毎日の育児記録を家族で簡単に共有し、赤ちゃんの成長を温かく見守るためのアプリです。',
    ),
    OnboardingStep(
      imagePath: 'assets/icons/onboarding_record.png',
      title: '授乳や睡眠をかんたん記録',
      description: '授乳表をはじめ、睡眠や排泄、離乳食などの大切な成長記録を、見やすくシンプルな操作で記録できます。',
    ),
    OnboardingStep(
      imagePath: 'assets/icons/onboarding_vaccine.png',
      title: '複雑な予防接種も安心管理',
      description: '推奨スケジュールを自動算出。忘れがちな接種予定の予約管理も、カレンダー連動でしっかりサポートします。',
    ),
    OnboardingStep(
      imagePath: 'assets/icons/onboarding_share.png',
      title: '家族みんなでリアルタイム共有',
      description: 'パートナーやご家族とアカウントを連携し、日々の育児記録をリアルタイムで共有。全員で成長を見守れます。',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToDecision();
    }
  }

  void _goToDecision() {
    context.go('/onboarding/decision');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: context.surfaceBackground,
      body: SafeArea(
        child: Column(
          children: [
            // 右上のスキップボタン
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, right: 16),
                child: TextButton(
                  onPressed: _goToDecision,
                  child: Text(
                    'スキップ',
                    style: TextStyle(
                      color: context.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // カルーセルのコンテンツ
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _steps.length,
                itemBuilder: (context, index) {
                  final step = _steps[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 画像コンテナ
                        Expanded(
                          flex: 5,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              step.imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        // タイトル
                        Text(
                          step.title,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.textPrimary,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // 説明
                        Text(
                          step.description,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: context.textSecondary,
                            height: 1.6,
                          ),
                        ),
                        const Spacer(flex: 1),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 下部のインジケータとボタン
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0, left: 24, right: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ドットインジケータ
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _steps.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? context.primaryColor
                              : context.inactiveTabColor.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // アクションボタン
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: _onNext,
                      style: FilledButton.styleFrom(
                        backgroundColor: context.primaryColor,
                        foregroundColor: context.onPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        _currentPage == _steps.length - 1 ? 'はじめる' : '次へ',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingStep {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingStep({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}
