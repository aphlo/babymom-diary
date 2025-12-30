import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/types/child_icon.dart';
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

    // 選択中の子供のアイコンを取得
    final childIcon = childContext.selectedChildSummary?.icon ?? ChildIcon.bear;

    return recordsAsync.when(
      data: (records) => customIngredientsAsync.when(
        data: (customIngredients) => hiddenIngredientsAsync.when(
          data: (hiddenIngredients) => _BabyFoodIngredientList(
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

class _BabyFoodIngredientList extends StatelessWidget {
  const _BabyFoodIngredientList({
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
                return _CategoryIngredientList(
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
          // recordsは最新順なので、最初に見つかった反応を維持する
          final existing = stats[key]!;
          stats[key] = _IngredientStat(
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
          stats[key] = _IngredientStat(
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

class _CategoryIngredientList extends ConsumerWidget {
  const _CategoryIngredientList({
    required this.householdId,
    required this.category,
    required this.ingredientStats,
    required this.customIngredients,
    required this.hiddenIngredients,
    required this.childIcon,
  });

  final String householdId;
  final FoodCategory category;
  final Map<String, _IngredientStat> ingredientStats;
  final List<CustomIngredient> customIngredients;
  final Set<String> hiddenIngredients;
  final ChildIcon childIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // プリセット食材を取得（非表示を除外）
    final visiblePresetIngredients = category.presetIngredients
        .where((name) => !hiddenIngredients.contains(name))
        .toList();
    // カスタム食材（非表示を除外）
    final visibleCustomIngredients = customIngredients
        .where((i) => !hiddenIngredients.contains(i.id))
        .toList();

    // リストの項目数:
    // プリセット食材 + カスタム食材セクションヘッダー（カスタム食材がある場合）
    // + カスタム食材 + 食材追加ボタン
    final hasCustomIngredients = visibleCustomIngredients.isNotEmpty;
    final totalItems = visiblePresetIngredients.length +
        (hasCustomIngredients ? 1 : 0) + // セクションヘッダー
        visibleCustomIngredients.length +
        1; // 食材追加ボタン

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: totalItems,
      itemBuilder: (context, index) {
        // プリセット食材
        if (index < visiblePresetIngredients.length) {
          final ingredientName = visiblePresetIngredients[index];
          final stat = ingredientStats[ingredientName];
          return Column(
            children: [
              _IngredientListTile(
                ingredientId: ingredientName,
                ingredientName: ingredientName,
                category: category,
                hasEaten: stat?.hasEaten ?? false,
                reaction: stat?.latestReaction,
                hasAllergy: stat?.hasAllergy ?? false,
                childIcon: childIcon,
              ),
              const Divider(height: 1),
            ],
          );
        }

        final offsetIndex = index - visiblePresetIngredients.length;

        // カスタム食材セクションヘッダー
        if (hasCustomIngredients && offsetIndex == 0) {
          return const _SectionHeader(title: '追加した食材');
        }

        // カスタム食材
        final customIndex =
            hasCustomIngredients ? offsetIndex - 1 : offsetIndex;
        if (customIndex < visibleCustomIngredients.length) {
          final customIngredient = visibleCustomIngredients[customIndex];
          final stat = ingredientStats[customIngredient.id];
          return Column(
            children: [
              _CustomIngredientListTile(
                householdId: householdId,
                ingredient: customIngredient,
                category: category,
                hasEaten: stat?.hasEaten ?? false,
                reaction: stat?.latestReaction,
                hasAllergy: stat?.hasAllergy ?? false,
                childIcon: childIcon,
              ),
              const Divider(height: 1),
            ],
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
    required this.category,
    required this.hasEaten,
    required this.reaction,
    required this.hasAllergy,
    required this.childIcon,
  });

  final String householdId;
  final CustomIngredient ingredient;
  final FoodCategory category;
  final bool hasEaten;
  final BabyFoodReaction? reaction;
  final bool hasAllergy;
  final ChildIcon childIcon;

  void _navigateToDetail(BuildContext context) {
    context.push(
      '/baby-food/ingredient-detail',
      extra: {
        'ingredientId': ingredient.id,
        'ingredientName': ingredient.name,
        'category': category,
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () => _navigateToDetail(context),
      leading: Container(
        width: 64,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: hasEaten ? Colors.green.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasEaten ? Colors.green.shade200 : Colors.grey.shade300,
          ),
        ),
        child: Text(
          hasEaten ? '食べた' : 'まだ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: hasEaten ? Colors.green.shade700 : Colors.grey.shade500,
          ),
        ),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              ingredient.name,
              style: hasAllergy ? const TextStyle(color: Colors.red) : null,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (hasAllergy) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Text(
                'アレルギー',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade700,
                ),
              ),
            ),
          ],
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 反応の表示
          if (reaction != null)
            _ReactionIcon(reaction: reaction!, childIcon: childIcon),
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
    required this.ingredientId,
    required this.ingredientName,
    required this.category,
    required this.hasEaten,
    required this.reaction,
    required this.hasAllergy,
    required this.childIcon,
  });

  final String ingredientId;
  final String ingredientName;
  final FoodCategory category;
  final bool hasEaten;
  final BabyFoodReaction? reaction;
  final bool hasAllergy;
  final ChildIcon childIcon;

  void _navigateToDetail(BuildContext context) {
    context.push(
      '/baby-food/ingredient-detail',
      extra: {
        'ingredientId': ingredientId,
        'ingredientName': ingredientName,
        'category': category,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _navigateToDetail(context),
      leading: Container(
        width: 64,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: hasEaten ? Colors.green.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasEaten ? Colors.green.shade200 : Colors.grey.shade300,
          ),
        ),
        child: Text(
          hasEaten ? '食べた' : 'まだ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: hasEaten ? Colors.green.shade700 : Colors.grey.shade500,
          ),
        ),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              ingredientName,
              style: hasAllergy ? const TextStyle(color: Colors.red) : null,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (hasAllergy) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Text(
                'アレルギー',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade700,
                ),
              ),
            ),
          ],
        ],
      ),
      trailing: reaction != null
          ? _ReactionIcon(reaction: reaction!, childIcon: childIcon)
          : null,
    );
  }
}

class _ReactionIcon extends StatelessWidget {
  const _ReactionIcon({
    required this.reaction,
    required this.childIcon,
  });

  final BabyFoodReaction reaction;
  final ChildIcon childIcon;

  String get _imagePath {
    return switch (reaction) {
      BabyFoodReaction.good => childIcon.goodReactionPath,
      BabyFoodReaction.normal => childIcon.normalReactionPath,
      BabyFoodReaction.bad => childIcon.badReactionPath,
    };
  }

  Color get _backgroundColor {
    return switch (reaction) {
      BabyFoodReaction.good => Colors.green.withValues(alpha: 0.1),
      BabyFoodReaction.normal => Colors.orange.withValues(alpha: 0.1),
      BabyFoodReaction.bad => Colors.red.withValues(alpha: 0.1),
    };
  }

  String get _label {
    return switch (reaction) {
      BabyFoodReaction.good => 'すき',
      BabyFoodReaction.normal => 'ふつう',
      BabyFoodReaction.bad => 'にがて',
    };
  }

  Color get _labelColor {
    return switch (reaction) {
      BabyFoodReaction.good => Colors.green.shade700,
      BabyFoodReaction.normal => Colors.orange.shade700,
      BabyFoodReaction.bad => Colors.red.shade700,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: _backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            _imagePath,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          _label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: _labelColor,
          ),
        ),
      ],
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
    required this.hasAllergy,
  });

  final String ingredientId;
  final String ingredientName;
  final FoodCategory category;
  final bool hasEaten;
  final BabyFoodReaction? latestReaction;
  final int eatCount;
  final bool hasAllergy;
}
