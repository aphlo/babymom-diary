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

    return recordsAsync.when(
      data: (records) => customIngredientsAsync.when(
        data: (customIngredients) => _BabyFoodIngredientList(
          householdId: householdId,
          records: records,
          customIngredients: customIngredients,
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
    required this.householdId,
    required this.records,
    required this.customIngredients,
  });

  final String householdId;
  final List<BabyFoodRecord> records;
  final List<CustomIngredient> customIngredients;

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
                  householdId: householdId,
                  category: category,
                  ingredientStats: ingredientStats,
                  customIngredients: customIngredients
                      .where((i) => i.category == category)
                      .toList(),
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

class _CategoryIngredientList extends ConsumerWidget {
  const _CategoryIngredientList({
    required this.householdId,
    required this.category,
    required this.ingredientStats,
    required this.customIngredients,
  });

  final String householdId;
  final FoodCategory category;
  final Map<String, _IngredientStat> ingredientStats;
  final List<CustomIngredient> customIngredients;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // プリセット食材を取得
    final presetIngredients = category.presetIngredients;

    // リストの項目数:
    // プリセット食材 + カスタム食材セクションヘッダー（カスタム食材がある場合）
    // + カスタム食材 + 食材追加ボタン
    final hasCustomIngredients = customIngredients.isNotEmpty;
    final totalItems = presetIngredients.length +
        (hasCustomIngredients ? 1 : 0) + // セクションヘッダー
        customIngredients.length +
        1; // 食材追加ボタン

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: totalItems,
      itemBuilder: (context, index) {
        // プリセット食材
        if (index < presetIngredients.length) {
          final ingredientName = presetIngredients[index];
          final stat = ingredientStats[ingredientName];
          return _IngredientListTile(
            ingredientName: ingredientName,
            hasEaten: stat?.hasEaten ?? false,
            reaction: stat?.latestReaction,
            eatCount: stat?.eatCount ?? 0,
          );
        }

        final offsetIndex = index - presetIngredients.length;

        // カスタム食材セクションヘッダー
        if (hasCustomIngredients && offsetIndex == 0) {
          return const _SectionHeader(title: '追加した食材');
        }

        // カスタム食材
        final customIndex =
            hasCustomIngredients ? offsetIndex - 1 : offsetIndex;
        if (customIndex < customIngredients.length) {
          final customIngredient = customIngredients[customIndex];
          final stat = ingredientStats[customIngredient.id];
          return _CustomIngredientListTile(
            householdId: householdId,
            ingredient: customIngredient,
            hasEaten: stat?.hasEaten ?? false,
            reaction: stat?.latestReaction,
            eatCount: stat?.eatCount ?? 0,
          );
        }

        // 食材追加ボタン
        return _AddIngredientButton(
          householdId: householdId,
          category: category,
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}

class _AddIngredientButton extends ConsumerWidget {
  const _AddIngredientButton({
    required this.householdId,
    required this.category,
  });

  final String householdId;
  final FoodCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.add, color: Colors.pink),
      title: const Text(
        '食材を追加',
        style: TextStyle(color: Colors.pink),
      ),
      onTap: () => _showAddIngredientDialog(context, ref),
    );
  }

  Future<void> _showAddIngredientDialog(
      BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Text('${category.label}に食材を追加'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: '食材名を入力',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Text('追加'),
          ),
        ],
      ),
    );

    if (name != null && name.trim().isNotEmpty && context.mounted) {
      final useCase = ref.read(addCustomIngredientUseCaseProvider(householdId));
      try {
        await useCase.call(name: name.trim(), category: category);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('「$name」を追加しました')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('追加に失敗しました: $e')),
          );
        }
      }
    }
  }
}

class _CustomIngredientListTile extends ConsumerWidget {
  const _CustomIngredientListTile({
    required this.householdId,
    required this.ingredient,
    required this.hasEaten,
    required this.reaction,
    required this.eatCount,
  });

  final String householdId;
  final CustomIngredient ingredient;
  final bool hasEaten;
  final BabyFoodReaction? reaction;
  final int eatCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(ingredient.name),
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
          // 3点リーダーメニュー
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  _showEditDialog(context, ref);
                case 'delete':
                  _showDeleteConfirmation(context, ref);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, size: 20),
                    SizedBox(width: 8),
                    Text('編集'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 20, color: Colors.red),
                    SizedBox(width: 8),
                    Text('削除', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController(text: ingredient.name);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('食材を編集'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: '食材名を入力',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Text('保存'),
          ),
        ],
      ),
    );

    if (newName != null && newName.trim().isNotEmpty && context.mounted) {
      final useCase =
          ref.read(updateCustomIngredientUseCaseProvider(householdId));
      try {
        await useCase.call(
            ingredientId: ingredient.id, newName: newName.trim());
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('「$newName」に変更しました')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('編集に失敗しました: $e')),
          );
        }
      }
    }
  }

  Future<void> _showDeleteConfirmation(
      BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('食材を削除'),
        content: Text('「${ingredient.name}」を削除しますか？\n\n'
            '※過去の記録からは削除されません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final useCase =
          ref.read(deleteCustomIngredientUseCaseProvider(householdId));
      try {
        await useCase.call(ingredientId: ingredient.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('「${ingredient.name}」を削除しました')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('削除に失敗しました: $e')),
          );
        }
      }
    }
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
