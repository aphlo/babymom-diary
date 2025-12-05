import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/widget_settings_view_model.dart';
import '../widgets/category_selector_section.dart';

class WidgetSettingsPage extends ConsumerWidget {
  const WidgetSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(widgetSettingsViewModelProvider);
    final viewModel = ref.read(widgetSettingsViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ウィジェット設定'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                CategorySelectorSection(
                  title: '直近の記録表示',
                  subtitle: '最大3項目',
                  categories: state.displayCategories,
                  availableCategories: state.availableDisplayCategories,
                  canAdd: state.canAddDisplayCategory,
                  onAdd: viewModel.addDisplayCategory,
                  onRemove: viewModel.removeDisplayCategory,
                  onReorder: viewModel.reorderDisplayCategories,
                ),
                const SizedBox(height: 32),
                CategorySelectorSection(
                  title: 'クイックアクション',
                  subtitle: '最大5項目',
                  categories: state.quickActionCategories,
                  availableCategories: state.availableQuickActionCategories,
                  canAdd: state.canAddQuickAction,
                  onAdd: viewModel.addQuickActionCategory,
                  onRemove: viewModel.removeQuickActionCategory,
                  onReorder: viewModel.reorderQuickActionCategories,
                )
              ],
            ),
    );
  }
}
