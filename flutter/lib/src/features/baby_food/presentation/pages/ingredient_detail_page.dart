import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/types/child_icon.dart';
import '../../../ads/application/services/banner_ad_manager.dart';
import '../../../ads/presentation/widgets/banner_ad_widget.dart';
import '../../../menu/children/application/child_context_provider.dart';
import '../../domain/entities/baby_food_record.dart';
import '../../domain/entities/custom_ingredient.dart';
import '../../domain/value_objects/food_category.dart';
import '../models/baby_food_draft.dart';
import '../models/ingredient_record_info.dart';
import '../providers/baby_food_providers.dart';
import '../viewmodels/baby_food_sheet_view_model.dart';
import '../widgets/baby_food_sheet.dart';
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

    final customIngredientsAsync =
        ref.watch(customIngredientsProvider(householdId));

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(title: Text(ingredientName)),
      body: Column(
        children: [
          Expanded(
            child: recordsAsync.when(
              data: (records) {
                // この食材を含む記録をフィルタリング
                final ingredientRecords = _filterRecordsForIngredient(records);
                return IngredientDetailBody(
                  records: ingredientRecords,
                  childIcon: childIcon,
                  onRecordTap: (recordInfo) => _handleRecordTap(
                    context: context,
                    ref: ref,
                    recordInfo: recordInfo,
                    allRecords: records,
                    householdId: householdId,
                    childId: childId,
                    customIngredientsAsync: customIngredientsAsync,
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('エラー: $e')),
            ),
          ),
          const BannerAdWidget(slot: BannerAdSlot.babyFood),
        ],
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
            recordId: record.id,
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

  /// 記録タップ時の処理
  Future<void> _handleRecordTap({
    required BuildContext context,
    required WidgetRef ref,
    required IngredientRecordInfo recordInfo,
    required List<BabyFoodRecord> allRecords,
    required String householdId,
    required String childId,
    required AsyncValue<List<CustomIngredient>> customIngredientsAsync,
  }) async {
    // 該当する記録を検索
    final record = allRecords.firstWhere(
      (r) => r.id == recordInfo.recordId,
    );

    // カスタム食材を取得
    final customIngredients = customIngredientsAsync.value ?? [];

    // ドラフトを作成（選択された食材のみにフィルタリング）
    final fullDraft = BabyFoodDraft.fromRecord(record);
    final filteredItems = fullDraft.items
        .where((item) => item.ingredientId == ingredientId)
        .toList();
    final draft = fullDraft.copyWith(items: filteredItems);

    // 編集シートを表示（食材選択ステップをスキップ）
    final args = BabyFoodSheetArgs(
      householdId: householdId,
      childId: childId,
      initialDraft: draft,
      customIngredients: customIngredients,
      skipIngredientSelection: true,
    );

    await showBabyFoodSheet(
      context: context,
      args: args,
      selectedDate: record.recordedAt,
    );
  }
}
