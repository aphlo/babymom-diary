import 'package:flutter/material.dart';

import '../models/widget_record_category.dart';

/// カテゴリ選択セクション
class CategorySelectorSection extends StatelessWidget {
  const CategorySelectorSection({
    super.key,
    required this.title,
    required this.categories,
    required this.availableCategories,
    required this.onReplace,
    required this.onReorder,
  });

  final String title;
  final List<WidgetRecordCategory> categories;
  final List<WidgetRecordCategory> availableCategories;
  final void Function(int index, WidgetRecordCategory newCategory) onReplace;
  final void Function(int oldIndex, int newIndex) onReorder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: title),
        _CategoryList(
          categories: categories,
          availableCategories: availableCategories,
          onReorder: onReorder,
          onReplace: onReplace,
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
  });

  final String title;

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
        ],
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({
    required this.categories,
    required this.availableCategories,
    required this.onReorder,
    required this.onReplace,
  });

  final List<WidgetRecordCategory> categories;
  final List<WidgetRecordCategory> availableCategories;
  final void Function(int oldIndex, int newIndex) onReorder;
  final void Function(int index, WidgetRecordCategory newCategory) onReplace;

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
            availableCategories: availableCategories,
            showTopBorder: index > 0,
            onReplace: (newCategory) => onReplace(index, newCategory),
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
    required this.availableCategories,
    required this.showTopBorder,
    required this.onReplace,
  });

  final int index;
  final WidgetRecordCategory category;
  final List<WidgetRecordCategory> availableCategories;
  final bool showTopBorder;
  final void Function(WidgetRecordCategory newCategory) onReplace;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: showTopBorder
            ? Border(top: BorderSide(color: Colors.grey[200]!))
            : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16, right: 8),
        leading: ReorderableDragStartListener(
          index: index,
          child: const Icon(Icons.drag_handle, color: Colors.grey),
        ),
        title: Row(
          children: [
            Image.asset(
              category.iconAssetPath(
                isDark: Theme.of(context).brightness == Brightness.dark,
              ),
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                category.label,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit_outlined, size: 20),
          color: Colors.grey,
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          tooltip: '項目を変更',
          onPressed: availableCategories.isNotEmpty
              ? () => _showReplaceDialog(context)
              : null,
        ),
      ),
    );
  }

  Future<void> _showReplaceDialog(BuildContext context) async {
    final selected = await showModalBottomSheet<WidgetRecordCategory>(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '変更する項目を選択',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Divider(height: 1),
            ...availableCategories.map(
              (cat) => ListTile(
                leading: Image.asset(
                  cat.iconAssetPath(
                    isDark: Theme.of(context).brightness == Brightness.dark,
                  ),
                  width: 24,
                  height: 24,
                ),
                title: Text(cat.label),
                onTap: () => Navigator.of(context).pop(cat),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );

    if (selected != null) {
      onReplace(selected);
    }
  }
}
