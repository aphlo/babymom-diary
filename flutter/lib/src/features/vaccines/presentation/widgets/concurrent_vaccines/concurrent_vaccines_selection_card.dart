import 'package:flutter/material.dart';

import '../../../../../core/theme/semantic_colors.dart';
import '../../../domain/entities/vaccination_record.dart';
import '../../../domain/value_objects/vaccine_category.dart' as vo;
import '../shared/requirement_badge.dart';
import '../shared/vaccine_type_badge.dart';
import '../../styles/vaccine_type_styles.dart';

/// 同時接種するワクチンを選択するカード
///
/// 予約ページで使用される
class ConcurrentVaccinesSelectionCard extends StatelessWidget {
  const ConcurrentVaccinesSelectionCard({
    super.key,
    required this.availableVaccines,
    required this.selectedVaccines,
    required this.isExpanded,
    required this.onToggleExpanded,
    required this.onToggleVaccine,
  });

  final List<VaccinationRecord> availableVaccines;
  final List<VaccinationRecord> selectedVaccines;
  final bool isExpanded;
  final VoidCallback onToggleExpanded;
  final ValueChanged<String> onToggleVaccine;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
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
        children: [
          InkWell(
            onTap: onToggleExpanded,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '同時接種するワクチン',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (selectedVaccines.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            '${selectedVaccines.length}個のワクチンを選択中',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: context.primaryColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: context.primaryColor,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            const Divider(height: 1),
            if (availableVaccines.isEmpty)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  '同時接種可能なワクチンがありません',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: context.textSecondary,
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: availableVaccines.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final VaccinationRecord vaccine = availableVaccines[index];
                  final bool isSelected = selectedVaccines
                      .any((v) => v.vaccineId == vaccine.vaccineId);
                  final orderedDoses = vaccine.orderedDoses;
                  final int nextDose = orderedDoses.length + 1;

                  return CheckboxListTile(
                    value: isSelected,
                    onChanged: (_) => onToggleVaccine(vaccine.vaccineId),
                    title: Text(
                      '${vaccine.vaccineName} $nextDose回目',
                      style: theme.textTheme.bodyLarge,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          RequirementBadge(requirement: vaccine.requirement),
                          const SizedBox(width: 8),
                          _VaccineTypeBadge(category: vaccine.category),
                        ],
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                },
              ),
          ],
        ],
      ),
    );
  }
}

class _VaccineTypeBadge extends StatelessWidget {
  const _VaccineTypeBadge({required this.category});

  final vo.VaccineCategory category;

  @override
  Widget build(BuildContext context) {
    final typeStyles = vaccineTypeStyles(category, context: context);

    return VaccineTypeBadge(
      label: typeStyles.label,
      backgroundColor: typeStyles.backgroundColor,
      foregroundColor: typeStyles.foregroundColor,
      borderColor: typeStyles.borderColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      fontSize: 12,
      fontWeight: FontWeight.w700,
      borderWidth: 0,
    );
  }
}
