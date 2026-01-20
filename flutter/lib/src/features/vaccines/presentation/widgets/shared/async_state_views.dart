import 'package:flutter/material.dart';

import '../../../../../core/theme/semantic_colors.dart';

/// 子どもが選択されていない時の表示
class NoChildSelectedView extends StatelessWidget {
  const NoChildSelectedView({
    super.key,
    this.message = '子どもを選択すると接種予定を確認できます',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// 非同期処理でエラーが発生した時の表示
class AsyncErrorView extends StatelessWidget {
  const AsyncErrorView({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: context.errorText,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
