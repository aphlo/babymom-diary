import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';

import '../../models/vaccine_info.dart';
import '../../viewmodels/vaccine_detail_state.dart';

class ScheduledDoseBottomSheet extends StatelessWidget {
  const ScheduledDoseBottomSheet({
    super.key,
    required this.vaccine,
    required this.doseNumber,
    required this.statusInfo,
    required this.onMarkAsCompleted,
    required this.onShowDetails,
  });

  final VaccineInfo vaccine;
  final int doseNumber;
  final DoseStatusInfo statusInfo;
  final VoidCallback onMarkAsCompleted;
  final VoidCallback onShowDetails;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String doseLabel = '$doseNumber回目';

    return Container(
      decoration: BoxDecoration(
        color: context.cardBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.tableBorderColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '${vaccine.name} $doseLabel',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_available,
                    color: context.reservedContainerAccent,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '予約済み',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: context.reservedContainerAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: onMarkAsCompleted,
                icon: const Icon(Icons.check_circle),
                label: const Text('接種済みにする'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: context.completedButtonBackground,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: onShowDetails,
                icon: const Icon(Icons.info_outline),
                label: const Text('詳細を確認する'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
