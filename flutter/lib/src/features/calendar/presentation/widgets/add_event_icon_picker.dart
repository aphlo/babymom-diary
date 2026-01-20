import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';

class AddEventIconPicker extends StatelessWidget {
  const AddEventIconPicker({
    required this.iconPaths,
    required this.selectedPath,
    required this.onChanged,
    this.noIconLabel = 'アイコンなし',
    super.key,
  });

  final List<String> iconPaths;
  final String selectedPath;
  final ValueChanged<String> onChanged;
  final String noIconLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemBuilder: (context, index) {
          final path = iconPaths[index];
          return _IconChoice(
            path: path,
            selected: selectedPath == path,
            onTap: () => onChanged(path),
            noIconLabel: noIconLabel,
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: iconPaths.length,
      ),
    );
  }
}

class _IconChoice extends StatelessWidget {
  const _IconChoice({
    required this.path,
    required this.selected,
    required this.onTap,
    required this.noIconLabel,
  });

  final String path;
  final bool selected;
  final VoidCallback onTap;
  final String noIconLabel;

  @override
  Widget build(BuildContext context) {
    Widget? iconContent;
    if (path.isEmpty) {
      iconContent = Text(
        noIconLabel,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall,
      );
    } else {
      Widget image = Image.asset(
        path,
        fit: BoxFit.contain,
      );

      // ダークモード時は白い背景を追加
      if (context.isDarkMode) {
        image = Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: image,
        );
      }

      iconContent = image;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints.tightFor(width: 96, height: 96),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: selected
              ? Border.all(
                  color: context.primaryColor,
                  width: 2,
                )
              : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: iconContent,
      ),
    );
  }
}
