import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/types/child_icon.dart';
import '../../../baby_food/presentation/providers/baby_food_providers.dart';
import '../../../menu/children/application/child_context_provider.dart';
import 'baby_food/baby_food_ingredient_list.dart';

/// 離乳食タブ - 食材一覧をカテゴリ別に表示
class BabyFoodTab extends ConsumerWidget {
  const BabyFoodTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childContext = ref.watch(childContextProvider).value;
    if (childContext == null || childContext.selectedChildId == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final householdId = childContext.householdId;
    final childId = childContext.selectedChildId!;

    final recordsAsync = ref.watch(
      watchBabyFoodRecordsProvider(
        householdId: householdId,
        childId: childId,
      ),
    );
    final customIngredientsAsync =
        ref.watch(customIngredientsProvider(householdId));
    final hiddenIngredientsAsync =
        ref.watch(hiddenIngredientsProvider(householdId));

    // 選択中の子供のアイコンを取得
    final childIcon = childContext.selectedChildSummary?.icon ?? ChildIcon.bear;

    return recordsAsync.when(
      data: (records) => customIngredientsAsync.when(
        data: (customIngredients) => hiddenIngredientsAsync.when(
          data: (hiddenIngredients) => BabyFoodIngredientList(
            householdId: householdId,
            records: records,
            customIngredients: customIngredients,
            hiddenIngredients: hiddenIngredients,
            childIcon: childIcon,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('エラー: $e')),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラー: $e')),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('エラー: $e')),
    );
  }
}
