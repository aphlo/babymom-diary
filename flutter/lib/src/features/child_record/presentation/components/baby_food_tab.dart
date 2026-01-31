import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/types/child_icon.dart';
import '../../../baby_food/domain/entities/baby_food_record.dart';
import '../../../baby_food/presentation/providers/baby_food_providers.dart';
import '../../../menu/children/application/child_context_provider.dart';
import 'baby_food/baby_food_ingredient_list.dart';

/// 離乳食タブ - 食材一覧をカテゴリ別に表示
///
/// AutomaticKeepAliveClientMixin を使用して、親タブ（授乳表/成長曲線）への
/// 切り替え時もウィジェット状態を保持し、カテゴリサブタブの選択状態が
/// リセットされないようにする。
class BabyFoodTab extends ConsumerStatefulWidget {
  const BabyFoodTab({super.key});

  @override
  ConsumerState<BabyFoodTab> createState() => _BabyFoodTabState();
}

class _BabyFoodTabState extends ConsumerState<BabyFoodTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin requires this

    final childContext = ref.watch(childContextProvider).value;
    // householdIdが取得できるまではローディング表示
    if (childContext == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final householdId = childContext.householdId;
    final selectedChildId = childContext.selectedChildId;
    final hasValidChild = selectedChildId != null && selectedChildId.isNotEmpty;

    // 子供が選択されていない場合は空のデータを使用
    final recordsAsync = hasValidChild
        ? ref.watch(
            watchBabyFoodRecordsProvider(
              householdId: householdId,
              childId: selectedChildId,
            ),
          )
        : const AsyncValue<List<BabyFoodRecord>>.data(<BabyFoodRecord>[]);
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
