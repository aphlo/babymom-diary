import 'package:flutter/material.dart';

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
      color: Colors.grey.shade100,
      child: Row(
        children: [
          Text(
            stepTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
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
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '記録したい食材がない場合は',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
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
                color: Colors.grey.shade600,
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
