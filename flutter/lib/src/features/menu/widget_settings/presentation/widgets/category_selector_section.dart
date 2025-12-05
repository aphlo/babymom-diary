import 'package:flutter/material.dart';

import '../models/widget_record_category.dart';

/// カテゴリ選択セクション
class CategorySelectorSection extends StatelessWidget {
  const CategorySelectorSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.categories,
    required this.availableCategories,
    required this.canAdd,
    required this.onAdd,
    required this.onRemove,
    required this.onReorder,
  });

  final String title;
  final String subtitle;
  final List<WidgetRecordCategory> categories;
  final List<WidgetRecordCategory> availableCategories;
  final bool canAdd;
  final void Function(WidgetRecordCategory category) onAdd;
  final void Function(WidgetRecordCategory category) onRemove;
  final void Function(int oldIndex, int newIndex) onReorder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: title, subtitle: subtitle),
        _CategoryList(
          categories: categories,
          onReorder: onReorder,
          onRemove: onRemove,
        ),
        _AddButton(
          canAdd: canAdd,
          availableCategories: availableCategories,
          onAdd: onAdd,
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({
    required this.categories,
    required this.onReorder,
    required this.onRemove,
  });

  final List<WidgetRecordCategory> categories;
  final void Function(int oldIndex, int newIndex) onReorder;
  final void Function(WidgetRecordCategory category) onRemove;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            '項目が選択されていません',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ReorderableListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        buildDefaultDragHandles: false,
        itemCount: categories.length,
        onReorder: onReorder,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _CategoryTile(
            key: ValueKey(category),
            index: index,
            category: category,
            showTopBorder: index > 0,
            onRemove: () => onRemove(category),
          );
        },
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    super.key,
    required this.index,
    required this.category,
    required this.showTopBorder,
    required this.onRemove,
  });

  final int index;
  final WidgetRecordCategory category;
  final bool showTopBorder;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: showTopBorder
            ? Border(top: BorderSide(color: Colors.grey[200]!))
            : null,
      ),
      child: ListTile(
        leading: ReorderableDragStartListener(
          index: index,
          child: const Icon(Icons.drag_handle, color: Colors.grey),
        ),
        title: Row(
          children: [
            Text(
              category.emoji,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 12),
            Text(category.label),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.close, size: 20),
          color: Colors.grey,
          onPressed: onRemove,
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({
    required this.canAdd,
    required this.availableCategories,
    required this.onAdd,
  });

  final bool canAdd;
  final List<WidgetRecordCategory> availableCategories;
  final void Function(WidgetRecordCategory category) onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: OutlinedButton.icon(
        onPressed: canAdd && availableCategories.isNotEmpty
            ? () => _showAddDialog(context)
            : null,
        icon: const Icon(Icons.add),
        label: Text(canAdd ? '項目を追加' : '上限に達しました'),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
        ),
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context) async {
    final selected = await showModalBottomSheet<WidgetRecordCategory>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '追加する項目を選択',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Divider(height: 1),
            ...availableCategories.map(
              (category) => ListTile(
                leading: Text(
                  category.emoji,
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(category.label),
                onTap: () => Navigator.of(context).pop(category),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );

    if (selected != null) {
      onAdd(selected);
    }
  }
}
