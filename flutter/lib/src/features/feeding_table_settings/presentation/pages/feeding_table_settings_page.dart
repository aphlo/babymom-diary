import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/features/ads/application/services/banner_ad_manager.dart';
import 'package:babymom_diary/src/features/ads/presentation/widgets/banner_ad_widget.dart';
import 'package:babymom_diary/src/features/feeding_table_settings/domain/entities/feeding_table_settings.dart';
import '../viewmodels/feeding_table_settings_state.dart';
import '../viewmodels/feeding_table_settings_view_model.dart';

class FeedingTableSettingsPage extends ConsumerWidget {
  const FeedingTableSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(feedingTableSettingsViewModelProvider);
    final viewModel = ref.read(feedingTableSettingsViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: const Text('授乳表の設定'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Text(
                          '表示する項目を選択してください\nドラッグして順序を変更できます\n※ 最低1つの項目を表示する必要があります',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      _buildVisibleSection(context, state, viewModel),
                      if (state.hiddenCategories.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        _buildHiddenSection(context, state, viewModel),
                      ],
                    ],
                  ),
                ),
                const BannerAdWidget(slot: BannerAdSlot.feedingTableSettings),
              ],
            ),
    );
  }

  Widget _buildVisibleSection(
    BuildContext context,
    FeedingTableSettingsState state,
    FeedingTableSettingsViewModel viewModel,
  ) {
    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              '表示する項目',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.visibleCategories.length,
            onReorder: viewModel.reorderCategories,
            proxyDecorator: (child, index, animation) {
              return Material(
                elevation: 4,
                color: Colors.white,
                child: child,
              );
            },
            itemBuilder: (context, index) {
              final category = state.visibleCategories[index];
              final canToggleOff = state.visibleCategories.length > 1;
              return _CategoryTile(
                key: ValueKey(category),
                category: category,
                isVisible: true,
                canToggle: canToggleOff,
                onToggle: () => viewModel.toggleCategory(category),
                showDragHandle: true,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHiddenSection(
    BuildContext context,
    FeedingTableSettingsState state,
    FeedingTableSettingsViewModel viewModel,
  ) {
    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              '非表示の項目',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          ...state.hiddenCategories.map((category) {
            return _CategoryTile(
              key: ValueKey(category),
              category: category,
              isVisible: false,
              canToggle: true,
              onToggle: () => viewModel.toggleCategory(category),
              showDragHandle: false,
            );
          }),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    super.key,
    required this.category,
    required this.isVisible,
    required this.canToggle,
    required this.onToggle,
    required this.showDragHandle,
  });

  final FeedingTableCategory category;
  final bool isVisible;
  final bool canToggle;
  final VoidCallback onToggle;
  final bool showDragHandle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: showDragHandle
          ? ReorderableDragStartListener(
              index: 0, // Will be overridden by parent
              child: const Icon(Icons.drag_handle, color: Colors.grey),
            )
          : const SizedBox(width: 24),
      title: Text(
        category.label,
        style: TextStyle(
          color: isVisible ? Colors.black : Colors.grey,
        ),
      ),
      trailing: Switch(
        value: isVisible,
        onChanged: canToggle ? (_) => onToggle() : null,
        activeTrackColor: AppColors.primary,
      ),
    );
  }
}
