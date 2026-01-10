import 'package:flutter/material.dart';

import '../../../../../core/types/child_icon.dart';
import '../../../../ads/application/services/banner_ad_manager.dart';
import '../../../../ads/presentation/widgets/banner_ad_widget.dart';
import '../../../../baby_food/domain/entities/baby_food_record.dart';
import '../../../../baby_food/domain/entities/custom_ingredient.dart';
import '../../../../baby_food/domain/value_objects/food_category.dart';
import 'category_ingredient_list.dart';
import 'ingredient_stat.dart';

class BabyFoodIngredientList extends StatelessWidget {
  const BabyFoodIngredientList({
    super.key,
    required this.householdId,
    required this.records,
    required this.customIngredients,
    required this.hiddenIngredients,
    required this.childIcon,
  });

  final String householdId;
  final List<BabyFoodRecord> records;
  final List<CustomIngredient> customIngredients;
  final Set<String> hiddenIngredients;
  final ChildIcon childIcon;

  @override
  Widget build(BuildContext context) {
    // 全記録から食材ごとの情報を集計
    final ingredientStats = _aggregateIngredientStats(records);

    return DefaultTabController(
      length: FoodCategory.values.length,
      child: Column(
        children: [
          // カテゴリサブタブ
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: FoodCategory.values.map((category) {
              return Tab(
                text: category.label,
              );
            }).toList(),
            labelColor: Colors.pink,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.pink,
          ),
          // 食材リスト
          Expanded(
            child: TabBarView(
              children: FoodCategory.values.map((category) {
                return CategoryIngredientList(
                  householdId: householdId,
                  category: category,
                  ingredientStats: ingredientStats,
                  customIngredients: customIngredients
                      .where((i) => i.category == category)
                      .toList(),
                  hiddenIngredients: hiddenIngredients,
                  childIcon: childIcon,
                );
              }).toList(),
            ),
          ),
          // 広告バナー
          const BannerAdWidget(slot: BannerAdSlot.babyFood),
        ],
      ),
    );
  }

  /// 記録から食材ごとの統計を集計
  Map<String, IngredientStat> _aggregateIngredientStats(
    List<BabyFoodRecord> records,
  ) {
    final stats = <String, IngredientStat>{};

    for (final record in records) {
      for (final item in record.items) {
        final key = item.ingredientId;
        if (stats.containsKey(key)) {
          // 既存の食材を更新
          // recordsは最新順なので、最初に見つかった反応を維持する
          final existing = stats[key]!;
          stats[key] = IngredientStat(
            ingredientId: item.ingredientId,
            ingredientName: item.ingredientName,
            category: item.category,
            hasEaten: true,
            latestReaction: existing.latestReaction ?? item.reaction,
            eatCount: existing.eatCount + 1,
            // アレルギーは一度でもtrueなら維持
            hasAllergy: existing.hasAllergy || (item.hasAllergy ?? false),
          );
        } else {
          // 新しい食材を追加
          stats[key] = IngredientStat(
            ingredientId: item.ingredientId,
            ingredientName: item.ingredientName,
            category: item.category,
            hasEaten: true,
            latestReaction: item.reaction,
            eatCount: 1,
            hasAllergy: item.hasAllergy ?? false,
          );
        }
      }
    }

    return stats;
  }
}
