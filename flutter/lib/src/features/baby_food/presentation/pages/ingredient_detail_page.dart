import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/types/child_icon.dart';
import '../../../menu/children/application/child_context_provider.dart';
import '../../domain/entities/baby_food_record.dart';
import '../../domain/value_objects/food_category.dart';
import '../models/ingredient_record_info.dart';
import '../providers/baby_food_providers.dart';
import '../widgets/ingredient_detail_body.dart';

/// 食材の詳細画面
class IngredientDetailPage extends ConsumerWidget {
  const IngredientDetailPage({
    super.key,
    required this.ingredientId,
    required this.ingredientName,
    required this.category,
  });

  final String ingredientId;
  final String ingredientName;
  final FoodCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childContext = ref.watch(childContextProvider).value;
    if (childContext == null || childContext.selectedChildId == null) {
      return Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(title: Text(ingredientName)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final householdId = childContext.householdId;
    final childId = childContext.selectedChildId!;
    final childIcon = childContext.selectedChildSummary?.icon ?? ChildIcon.bear;

    final recordsAsync = ref.watch(
      watchBabyFoodRecordsProvider(
        householdId: householdId,
        childId: childId,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(title: Text(ingredientName)),
      body: recordsAsync.when(
        data: (records) {
          // この食材を含む記録をフィルタリング
          final ingredientRecords = _filterRecordsForIngredient(records);
          return IngredientDetailBody(
            records: ingredientRecords,
            childIcon: childIcon,
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラー: $e')),
      ),
    );
  }

  /// この食材を含む記録のみをフィルタリング
  List<IngredientRecordInfo> _filterRecordsForIngredient(
    List<BabyFoodRecord> records,
  ) {
    final result = <IngredientRecordInfo>[];

    for (final record in records) {
      for (final item in record.items) {
        if (item.ingredientId == ingredientId) {
          result.add(IngredientRecordInfo(
            recordedAt: record.recordedAt,
            amount: item.amountDisplay,
            reaction: item.reaction,
            memo: item.memo,
            hasAllergy: item.hasAllergy ?? false,
          ));
        }
      }
    }

    // 日付の新しい順にソート
    result.sort((a, b) => b.recordedAt.compareTo(a.recordedAt));
    return result;
  }
}
