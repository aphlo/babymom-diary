import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../baby_food/domain/entities/baby_food_record.dart';
import '../../../baby_food/domain/entities/custom_ingredient.dart';
import '../../../baby_food/domain/value_objects/baby_food_reaction.dart';
import '../../../baby_food/domain/value_objects/food_category.dart';
import '../../../baby_food/presentation/providers/baby_food_providers.dart';
import '../../../menu/children/application/child_context_provider.dart';

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

    return recordsAsync.when(
      data: (records) => customIngredientsAsync.when(
        data: (customIngredients) => hiddenIngredientsAsync.when(
          data: (hiddenIngredients) => _BabyFoodIngredientList(
            records: records,
            customIngredients: customIngredients,
            hiddenIngredients: hiddenIngredients,
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

class _BabyFoodIngredientList extends StatelessWidget {
  const _BabyFoodIngredientList({
    required this.records,
    required this.customIngredients,
    required this.hiddenIngredients,
  });

  final List<BabyFoodRecord> records;
  final List<CustomIngredient> customIngredients;
  final Set<String> hiddenIngredients;

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
                return _CategoryIngredientList(
                  category: category,
                  ingredientStats: ingredientStats,
                  customIngredients: customIngredients
                      .where((i) => i.category == category)
                      .toList(),
                  hiddenIngredients: hiddenIngredients,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// 記録から食材ごとの統計を集計
  Map<String, _IngredientStat> _aggregateIngredientStats(
    List<BabyFoodRecord> records,
  ) {
    final stats = <String, _IngredientStat>{};

    for (final record in records) {
      for (final item in record.items) {
        final key = item.ingredientId;
        if (stats.containsKey(key)) {
          // 既存の食材を更新
          final existing = stats[key]!;
          stats[key] = _IngredientStat(
            ingredientId: item.ingredientId,
            ingredientName: item.ingredientName,
            category: item.category,
            hasEaten: true,
            latestReaction: item.reaction ?? existing.latestReaction,
            eatCount: existing.eatCount + 1,
          );
        } else {
          // 新しい食材を追加
          stats[key] = _IngredientStat(
            ingredientId: item.ingredientId,
            ingredientName: item.ingredientName,
            category: item.category,
            hasEaten: true,
            latestReaction: item.reaction,
            eatCount: 1,
          );
        }
      }
    }

    return stats;
  }
}

class _CategoryIngredientList extends StatelessWidget {
  const _CategoryIngredientList({
    required this.category,
    required this.ingredientStats,
    required this.customIngredients,
    required this.hiddenIngredients,
  });

  final FoodCategory category;
  final Map<String, _IngredientStat> ingredientStats;
  final List<CustomIngredient> customIngredients;
  final Set<String> hiddenIngredients;

  @override
  Widget build(BuildContext context) {
    // プリセット食材を取得（非表示を除く）
    final visiblePresetIngredients = category.presetIngredients
        .where((name) => !hiddenIngredients.contains(name))
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: visiblePresetIngredients.length + customIngredients.length,
      itemBuilder: (context, index) {
        if (index < visiblePresetIngredients.length) {
          final ingredientName = visiblePresetIngredients[index];
          final stat = ingredientStats[ingredientName];
          return _IngredientListTile(
            ingredientName: ingredientName,
            hasEaten: stat?.hasEaten ?? false,
            reaction: stat?.latestReaction,
            eatCount: stat?.eatCount ?? 0,
          );
        } else {
          final customIngredient =
              customIngredients[index - visiblePresetIngredients.length];
          final stat = ingredientStats[customIngredient.id];
          return _IngredientListTile(
            ingredientName: customIngredient.name,
            hasEaten: stat?.hasEaten ?? false,
            reaction: stat?.latestReaction,
            eatCount: stat?.eatCount ?? 0,
          );
        }
      },
    );
  }
}

class _IngredientListTile extends StatelessWidget {
  const _IngredientListTile({
    required this.ingredientName,
    required this.hasEaten,
    required this.reaction,
    required this.eatCount,
  });

  final String ingredientName;
  final bool hasEaten;
  final BabyFoodReaction? reaction;
  final int eatCount;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(ingredientName),
      subtitle: hasEaten
          ? Text(
              '$eatCount回食べた',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            )
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 食べた/未の表示
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: hasEaten ? Colors.green.shade50 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasEaten ? Colors.green.shade200 : Colors.grey.shade300,
              ),
            ),
            child: Text(
              hasEaten ? '食べた' : '未',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: hasEaten ? Colors.green.shade700 : Colors.grey.shade500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // 反応の表示
          if (reaction != null)
            _ReactionIcon(reaction: reaction!)
          else
            const SizedBox(
              width: 32,
              child: Center(
                child: Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ReactionIcon extends StatelessWidget {
  const _ReactionIcon({required this.reaction});

  final BabyFoodReaction reaction;

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (reaction) {
      BabyFoodReaction.good => (Icons.sentiment_very_satisfied, Colors.green),
      BabyFoodReaction.normal => (Icons.sentiment_neutral, Colors.orange),
      BabyFoodReaction.bad => (Icons.sentiment_very_dissatisfied, Colors.red),
    };

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 24,
        color: color,
      ),
    );
  }
}

/// 食材の統計情報
class _IngredientStat {
  const _IngredientStat({
    required this.ingredientId,
    required this.ingredientName,
    required this.category,
    required this.hasEaten,
    required this.latestReaction,
    required this.eatCount,
  });

  final String ingredientId;
  final String ingredientName;
  final FoodCategory category;
  final bool hasEaten;
  final BabyFoodReaction? latestReaction;
  final int eatCount;
}
