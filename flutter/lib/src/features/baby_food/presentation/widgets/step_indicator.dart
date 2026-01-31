import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';

/// ステップインジケーター
class StepIndicator extends StatelessWidget {
  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.stepTitle,
  });

  final int currentStep;
  final String stepTitle;

  @override
  Widget build(BuildContext context) {
    final isIngredientStep = currentStep == 0;
    final isAmountStep = currentStep == 1;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: context.stepIndicatorBackground,
      child: Row(
        children: [
          Text(
            stepTitle,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: context.textPrimary,
            ),
          ),
          const Spacer(),
          if (isIngredientStep)
            GestureDetector(
              onTap: () => _showIngredientHelpDialog(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.help_outline,
                    size: 16,
                    color: context.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '記録したい食材がない場合は',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.textSecondary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          if (isAmountStep)
            Text(
              '量や反応の入力は任意です',
              style: TextStyle(
                fontSize: 12,
                color: context.textSecondary,
              ),
            ),
        ],
      ),
    );
  }

  void _showIngredientHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('食材の追加について'),
        content: const Text(
          'ベビーの記録画面の「離乳食」タブから食材を追加してください。\n\n'
          '追加した食材は、すべての記録で選択できるようになります。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }
}
