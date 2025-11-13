import 'package:flutter/material.dart';

class OtherTagsPreview extends StatelessWidget {
  const OtherTagsPreview({super.key, required this.tags});

  final List<String> tags;

  static const double _iconSize = 22;
  static const double _spacing = 4;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : double.infinity;
        var capacity = tags.length;
        if (availableWidth.isFinite) {
          capacity =
              ((availableWidth + _spacing) / (_iconSize + _spacing)).floor();
          if (capacity <= 0) {
            capacity = 1;
          }
        }

        var needsOverflowIndicator = tags.length > capacity;
        var visibleCount = needsOverflowIndicator ? capacity - 1 : tags.length;
        if (visibleCount < 0) {
          visibleCount = 0;
          needsOverflowIndicator = true;
        }

        final visibleTags = tags.take(visibleCount).toList(growable: false);
        final children = <Widget>[];

        for (final tag in visibleTags) {
          if (children.isNotEmpty) {
            children.add(const SizedBox(width: _spacing));
          }
          children.add(_TagCircle(character: tag.characters.first));
        }

        if (needsOverflowIndicator) {
          if (children.isNotEmpty) {
            children.add(const SizedBox(width: _spacing));
          }
          children.add(const _OverflowCircle());
        }

        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        );
      },
    );
  }
}

class _TagCircle extends StatelessWidget {
  const _TagCircle({required this.character});

  final String character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: OtherTagsPreview._iconSize,
      height: OtherTagsPreview._iconSize,
      decoration: const BoxDecoration(
        color: Color(0xFF8f60ac),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        character,
        style: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _OverflowCircle extends StatelessWidget {
  const _OverflowCircle();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: OtherTagsPreview._iconSize,
      height: OtherTagsPreview._iconSize,
      decoration: const BoxDecoration(
        color: Color(0xFF8f60ac),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '...',
        style: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
