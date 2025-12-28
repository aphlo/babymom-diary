import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/features/baby_food/domain/entities/custom_ingredient.dart';
import 'package:babymom_diary/src/features/baby_food/domain/value_objects/food_category.dart';
import 'package:babymom_diary/src/features/baby_food/presentation/providers/baby_food_providers.dart';
import '../viewmodels/ingredient_settings_view_model.dart';

/// 離乳食の食材管理ページ
class IngredientSettingsPage extends ConsumerWidget {
  const IngredientSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHid = ref.watch(currentHouseholdIdProvider);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
        title: const Text('離乳食の食材管理'),
      ),
      body: asyncHid.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, __) => Center(child: Text('読み込みに失敗しました\n$e')),
        data: (hid) => _IngredientSettingsBody(householdId: hid),
      ),
    );
  }
}

class _IngredientSettingsBody extends ConsumerWidget {
  const _IngredientSettingsBody({required this.householdId});

  final String householdId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customIngredientsAsync =
        ref.watch(customIngredientsProvider(householdId));
    final hiddenIngredientsAsync =
        ref.watch(hiddenIngredientsProvider(householdId));
    final state = ref.watch(ingredientSettingsViewModelProvider(householdId));
    final viewModel =
        ref.read(ingredientSettingsViewModelProvider(householdId).notifier);

    return customIngredientsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, __) => Center(child: Text('読み込みに失敗しました\n$e')),
      data: (customIngredients) => hiddenIngredientsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, __) => Center(child: Text('読み込みに失敗しました\n$e')),
        data: (hiddenIngredients) => _buildContent(
          context,
          ref,
          customIngredients,
          hiddenIngredients,
          state,
          viewModel,
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    List<CustomIngredient> customIngredients,
    Set<String> hiddenIngredients,
    IngredientSettingsState state,
    IngredientSettingsViewModel viewModel,
  ) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'カテゴリを選択して、食材の追加・削除ができます。\n削除した食材は記録画面に表示されなくなります。',
            style: TextStyle(color: Colors.black54),
          ),
        ),
        for (final category in FoodCategory.values) ...[
          _CategorySection(
            householdId: householdId,
            category: category,
            customIngredients:
                customIngredients.where((i) => i.category == category).toList(),
            hiddenIngredients: hiddenIngredients,
            isExpanded: state.expandedCategory == category,
            onToggle: () => viewModel.toggleCategory(category),
          ),
        ],
        const SizedBox(height: 32),
      ],
    );
  }
}

class _CategorySection extends ConsumerWidget {
  const _CategorySection({
    required this.householdId,
    required this.category,
    required this.customIngredients,
    required this.hiddenIngredients,
    required this.isExpanded,
    required this.onToggle,
  });

  final String householdId;
  final FoodCategory category;
  final List<CustomIngredient> customIngredients;
  final Set<String> hiddenIngredients;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presetIngredients = category.presetIngredients;
    // 非表示でないプリセット食材の数
    final visiblePresetCount = presetIngredients
        .where((name) => !hiddenIngredients.contains(name))
        .length;
    final totalCount = visiblePresetCount + customIngredients.length;

    return Column(
      children: [
        // カテゴリヘッダー
        Material(
          color: isExpanded ? Colors.pink.shade50 : Colors.white,
          child: InkWell(
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      category.label,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    '$totalCount件',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
        // 食材リスト
        if (isExpanded)
          Container(
            color: Colors.white,
            child: Column(
              children: [
                // カスタム食材追加ボタン
                ListTile(
                  leading: const Icon(Icons.add, color: Colors.pink),
                  title: const Text(
                    '食材を追加',
                    style: TextStyle(color: Colors.pink),
                  ),
                  onTap: () => _showAddIngredientDialog(context, ref),
                ),
                const Divider(height: 1),
                // カスタム食材
                if (customIngredients.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '追加した食材',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  for (final ingredient in customIngredients)
                    _CustomIngredientTile(
                      householdId: householdId,
                      ingredient: ingredient,
                    ),
                  const Divider(height: 1),
                ],
                // プリセット食材（非表示でないもの）
                _buildPresetSection(context, ref, presetIngredients, false),
                // 非表示にしたプリセット食材
                _buildHiddenPresetSection(context, ref, presetIngredients),
              ],
            ),
          ),
        const Divider(height: 1),
      ],
    );
  }

  Widget _buildPresetSection(BuildContext context, WidgetRef ref,
      List<String> presetIngredients, bool showHidden) {
    final visibleIngredients = presetIngredients
        .where((name) => !hiddenIngredients.contains(name))
        .toList();

    if (visibleIngredients.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'デフォルトの食材',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        for (final ingredientName in visibleIngredients)
          _PresetIngredientTile(
            householdId: householdId,
            ingredientName: ingredientName,
            isHidden: false,
          ),
      ],
    );
  }

  Widget _buildHiddenPresetSection(
      BuildContext context, WidgetRef ref, List<String> presetIngredients) {
    final hiddenPresetIngredients = presetIngredients
        .where((name) => hiddenIngredients.contains(name))
        .toList();

    if (hiddenPresetIngredients.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '削除した食材（タップで復元）',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        for (final ingredientName in hiddenPresetIngredients)
          _PresetIngredientTile(
            householdId: householdId,
            ingredientName: ingredientName,
            isHidden: true,
          ),
      ],
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

class _CustomIngredientTile extends ConsumerWidget {
  const _CustomIngredientTile({
    required this.householdId,
    required this.ingredient,
  });

  final String householdId;
  final CustomIngredient ingredient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(ingredient.name),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline, color: Colors.red),
        onPressed: () => _showDeleteConfirmation(context, ref),
      ),
    );
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

class _PresetIngredientTile extends ConsumerWidget {
  const _PresetIngredientTile({
    required this.householdId,
    required this.ingredientName,
    required this.isHidden,
  });

  final String householdId;
  final String ingredientName;
  final bool isHidden;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isHidden) {
      // 非表示の食材: タップで復元
      return ListTile(
        title: Text(
          ingredientName,
          style: TextStyle(color: Colors.grey.shade500),
        ),
        trailing: TextButton.icon(
          onPressed: () => _unhideIngredient(context, ref),
          icon: const Icon(Icons.restore, size: 18),
          label: const Text('復元'),
        ),
      );
    }

    // 表示中の食材: 削除ボタン付き
    return ListTile(
      title: Text(ingredientName),
      trailing: IconButton(
        icon: Icon(Icons.delete_outline, color: Colors.grey.shade600),
        onPressed: () => _hideIngredient(context, ref),
      ),
    );
  }

  Future<void> _hideIngredient(BuildContext context, WidgetRef ref) async {
    final dataSource =
        ref.read(hiddenIngredientsDataSourceProvider(householdId));
    try {
      await dataSource.hide(ingredientName);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('「$ingredientName」を削除しました')),
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

  Future<void> _unhideIngredient(BuildContext context, WidgetRef ref) async {
    final dataSource =
        ref.read(hiddenIngredientsDataSourceProvider(householdId));
    try {
      await dataSource.unhide(ingredientName);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('「$ingredientName」を復元しました')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('復元に失敗しました: $e')),
        );
      }
    }
  }
}
