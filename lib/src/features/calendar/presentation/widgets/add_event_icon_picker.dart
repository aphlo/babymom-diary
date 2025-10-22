import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints.tightFor(width: 96, height: 96),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: selected
              ? Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                )
              : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: path.isEmpty
            ? Text(
                noIconLabel,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              )
            : Image.asset(
                path,
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
