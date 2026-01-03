import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/types/child_icon.dart';
import '../../../ads/application/services/banner_ad_manager.dart';
import '../../../ads/presentation/widgets/banner_ad_widget.dart';
import '../../../menu/children/application/child_context_provider.dart';
import '../../domain/entities/baby_food_record.dart';
import '../../domain/value_objects/food_category.dart';
import '../models/baby_food_draft.dart';
import '../models/ingredient_record_info.dart';
import '../providers/baby_food_providers.dart';
import '../viewmodels/baby_food_sheet_view_model.dart';
import '../viewmodels/ingredient_detail_state.dart';
import '../viewmodels/ingredient_detail_view_model.dart';
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

    // カスタム食材リスト（FABと記録タップ時に必要）
    final customIngredientsAsync =
        ref.watch(customIngredientsProvider(householdId));

    // ViewModelの引数を作成
    final args = IngredientDetailArgs(
      householdId: householdId,
      ingredientId: ingredientId,
      ingredientName: ingredientName,
      category: category,
    );

    // ViewModelを監視
    final state = ref.watch(ingredientDetailViewModelProvider(args));
    final viewModel =
        ref.read(ingredientDetailViewModelProvider(args).notifier);

    // UIイベントを処理
    ref.listen<IngredientDetailState>(
      ingredientDetailViewModelProvider(args),
      (previous, next) {
        final event = next.pendingUiEvent;
        if (event != null && event != previous?.pendingUiEvent) {
          event.when(
            showMessage: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
            navigateBack: () {
              Navigator.of(context).pop();
            },
          );
          viewModel.clearUiEvent();
        }
      },
    );

    // フィルタリング済み記録を監視
    final recordsQuery = IngredientRecordsQuery(
      householdId: householdId,
      childId: childId,
      ingredientId: ingredientId,
    );
    final ingredientRecordsAsync =
        ref.watch(ingredientRecordsProvider(recordsQuery));

    // 全記録（編集時に必要）
    final allRecordsAsync = ref.watch(
      watchBabyFoodRecordsProvider(householdId: householdId, childId: childId),
    );

    final hiddenIngredientsAsync =
        ref.watch(hiddenIngredientsProvider(householdId));

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(state.currentIngredientName),
        actions: [
          if (state.isCustomIngredient)
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              color: Colors.white,
              onSelected: (value) => _handleMenuAction(
                context: context,
                action: value,
                viewModel: viewModel,
                currentName: state.currentIngredientName,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'edit', child: Text('編集')),
                const PopupMenuItem(value: 'delete', child: Text('削除')),
              ],
            ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          heroTag: 'ingredient_detail_fab',
          onPressed: () => _handleAddRecord(
            context: context,
            householdId: householdId,
            childId: childId,
            ingredientId: ingredientId,
            ingredientName: state.currentIngredientName,
            category: category,
            isCustomIngredient: state.isCustomIngredient,
            customIngredientsAsync: customIngredientsAsync,
            hiddenIngredientsAsync: hiddenIngredientsAsync,
          ),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ingredientRecordsAsync.when(
              data: (records) => IngredientDetailBody(
                records: records,
                childIcon: childIcon,
                onRecordTap: (recordInfo) => _handleRecordTap(
                  context: context,
                  recordInfo: recordInfo,
                  allRecordsAsync: allRecordsAsync,
                  householdId: householdId,
                  childId: childId,
                  ingredientId: ingredientId,
                  customIngredientsAsync: customIngredientsAsync,
                  hiddenIngredientsAsync: hiddenIngredientsAsync,
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('エラー: $e')),
            ),
          ),
          const BannerAdWidget(slot: BannerAdSlot.babyFood),
        ],
      ),
    );
  }

  /// メニューアクションの処理
  Future<void> _handleMenuAction({
    required BuildContext context,
    required String action,
    required IngredientDetailViewModel viewModel,
    required String currentName,
  }) async {
    switch (action) {
      case 'edit':
        final newName = await _showEditDialog(context, currentName);
        if (newName != null) {
          await viewModel.updateIngredientName(newName);
        }
      case 'delete':
        final confirmed = await _showDeleteConfirmation(context, currentName);
        if (confirmed) {
          await viewModel.deleteIngredient();
        }
    }
  }

  /// 編集ダイアログを表示
  Future<String?> _showEditDialog(
      BuildContext context, String currentName) async {
    return showDialog<String>(
      context: context,
      builder: (dialogContext) {
        final controller = TextEditingController(text: currentName);
        final formKey = GlobalKey<FormState>();

        return AlertDialog(
          title: const Text('食材名を編集'),
          content: SizedBox(
            width: 300,
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: '食材名',
                  hintText: '食材名を入力',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '食材名を入力してください';
                  }
                  return null;
                },
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState?.validate() == true) {
                  Navigator.of(dialogContext).pop(controller.text.trim());
                }
              },
              child: const Text('保存'),
            ),
          ],
        );
      },
    );
  }

  /// 削除確認ダイアログを表示
  Future<bool> _showDeleteConfirmation(
      BuildContext context, String currentName) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('カスタム食材を削除'),
        content: Text('「$currentName」を削除しますか？\n'
            'この食材を含む記録からも削除されます。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('削除'),
          ),
        ],
      ),
    );
    return confirmed ?? false;
  }

  /// FABから新規記録を追加
  Future<void> _handleAddRecord({
    required BuildContext context,
    required String householdId,
    required String childId,
    required String ingredientId,
    required String ingredientName,
    required FoodCategory category,
    required bool isCustomIngredient,
    required AsyncValue customIngredientsAsync,
    required AsyncValue hiddenIngredientsAsync,
  }) async {
    final customIngredients = customIngredientsAsync.value ?? [];
    final hiddenIngredients = hiddenIngredientsAsync.value ?? <String>{};
    final now = DateTime.now();

    final preSelectedItem = isCustomIngredient
        ? BabyFoodItemDraft.fromCustom(
            id: ingredientId,
            name: ingredientName,
            category: category,
          )
        : BabyFoodItemDraft.fromPreset(
            ingredientName: ingredientName,
            category: category,
          );

    final draft = BabyFoodDraft(
      existingId: null,
      recordedAt: now,
      items: [preSelectedItem],
      note: null,
    );

    final args = BabyFoodSheetArgs(
      householdId: householdId,
      childId: childId,
      initialDraft: draft,
      customIngredients: customIngredients,
      hiddenIngredients: hiddenIngredients,
      skipIngredientSelection: true,
    );

    await showBabyFoodSheet(context: context, args: args, selectedDate: now);
  }

  /// 記録タップ時の処理
  Future<void> _handleRecordTap({
    required BuildContext context,
    required IngredientRecordInfo recordInfo,
    required AsyncValue<List<BabyFoodRecord>> allRecordsAsync,
    required String householdId,
    required String childId,
    required String ingredientId,
    required AsyncValue customIngredientsAsync,
    required AsyncValue hiddenIngredientsAsync,
  }) async {
    final allRecords = allRecordsAsync.value;
    if (allRecords == null) return;

    final record = allRecords.firstWhere((r) => r.id == recordInfo.recordId);
    final customIngredients = customIngredientsAsync.value ?? [];
    final hiddenIngredients = hiddenIngredientsAsync.value ?? <String>{};

    final fullDraft = BabyFoodDraft.fromRecord(record);
    final filteredItems = fullDraft.items
        .where((item) => item.ingredientId == ingredientId)
        .toList();
    final draft = fullDraft.copyWith(items: filteredItems);

    final args = BabyFoodSheetArgs(
      householdId: householdId,
      childId: childId,
      initialDraft: draft,
      customIngredients: customIngredients,
      hiddenIngredients: hiddenIngredients,
      skipIngredientSelection: true,
    );

    await showBabyFoodSheet(
      context: context,
      args: args,
      selectedDate: record.recordedAt,
    );
  }
}
