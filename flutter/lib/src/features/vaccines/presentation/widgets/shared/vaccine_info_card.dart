import 'package:flutter/material.dart';

import '../../../../../core/theme/semantic_colors.dart';
import '../../models/vaccine_info.dart';
import 'vaccine_header.dart';

/// ワクチン情報を表示するカード
///
/// 予約ページ、日程変更ページ、詳細ページで共通して使用される
class VaccineInfoCard extends StatelessWidget {
  const VaccineInfoCard({
    super.key,
    required this.vaccine,
    required this.doseNumber,
    this.influenzaSeasonLabel,
    this.influenzaDoseOrder,
  });

  final VaccineInfo vaccine;
  final int doseNumber;
  final String? influenzaSeasonLabel;
  final int? influenzaDoseOrder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.cardShadow,
            offset: const Offset(0, 8),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VaccineHeader(vaccine: vaccine),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: context.secondaryContainerBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.vaccines,
                  color: context.secondaryContainerAccent,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  _buildDoseLabel(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: context.secondaryContainerAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildDoseLabel() {
    if (!vaccine.id.startsWith('influenza')) {
      return '$doseNumber回目の接種';
    }
    final bool hasSeason = influenzaSeasonLabel != null &&
        influenzaSeasonLabel!.isNotEmpty &&
        influenzaSeasonLabel != '未設定';
    final String orderPart = ((influenzaDoseOrder ?? doseNumber)).toString();
    final String orderLabel = '$orderPart回目';
    if (hasSeason) {
      return '${influenzaSeasonLabel!}$orderLabelの接種';
    }
    return '$orderLabelの接種';
  }
}
