import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/types/child_icon.dart';

class ChildIconPicker extends StatelessWidget {
  const ChildIconPicker({
    required this.selectedIcon,
    required this.onChanged,
    super.key,
  });

  final ChildIcon selectedIcon;
  final ValueChanged<ChildIcon> onChanged;

  static const List<ChildIcon> _selectableIcons = [
    ChildIcon.bear,
    ChildIcon.cat,
    ChildIcon.dog,
    ChildIcon.rabbit,
    ChildIcon.snowman,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 現在選択中のアイコン表示
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  selectedIcon.assetPath,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '現在設定中のアイコン',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // アイコン選択リスト
        SizedBox(
          height: 112,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemBuilder: (context, index) {
              final icon = _selectableIcons[index];
              return _IconChoice(
                icon: icon,
                selected: selectedIcon == icon,
                onTap: () => onChanged(icon),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemCount: _selectableIcons.length,
          ),
        ),
      ],
    );
  }
}

class _IconChoice extends StatelessWidget {
  const _IconChoice({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final ChildIcon icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints.tightFor(width: 96, height: 96),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: selected
              ? Border.all(
                  color: AppColors.primary,
                  width: 2,
                )
              : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Image.asset(
          icon.assetPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
