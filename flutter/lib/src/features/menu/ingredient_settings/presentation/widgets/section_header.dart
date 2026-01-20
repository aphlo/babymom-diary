import 'package:flutter/material.dart';

import '../../../../../core/theme/semantic_colors.dart';

/// セクションヘッダー
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.dateSectionHeaderBackground,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: context.dateSectionText,
        ),
      ),
    );
  }
}
