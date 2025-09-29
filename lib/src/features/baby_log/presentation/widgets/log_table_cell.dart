import 'package:flutter/material.dart';

import '../../baby_log.dart';
import 'other_tags_preview.dart';

typedef LogSlotTapCallback = void Function(
  BuildContext context,
  int hour,
  EntryType? type,
  List<Entry> inHour,
);

class LogTableCell extends StatelessWidget {
  const LogTableCell({
    super.key,
    required this.entries,
    required this.hour,
    required this.type,
    required this.onTap,
    required this.rowHeight,
  });

  final List<Entry> entries;
  final int hour;
  final EntryType? type;
  final LogSlotTapCallback onTap;
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    final inHour = entries.where((e) => e.at.hour == hour).toList();
    final filtered =
        type == null ? inHour : inHour.where((e) => e.type == type).toList();

    if (type == EntryType.other) {
      final tags = filtered
          .expand((entry) => entry.tags)
          .map((tag) => tag.trim())
          .where((tag) => tag.isNotEmpty)
          .toList(growable: false);
      final fallbackText = filtered.isEmpty ? '' : '${filtered.length}';

      return InkWell(
        onTap: () => onTap(context, hour, type, inHour),
        child: SizedBox(
          height: rowHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: tags.isEmpty
                ? (fallbackText.isEmpty
                    ? const SizedBox.shrink()
                    : Center(
                        child: _buildCountBadge(
                          context,
                          type,
                          fallbackText,
                        ),
                      ))
                : OtherTagsPreview(tags: tags),
          ),
        ),
      );
    }

    var text = '';
    if (filtered.isNotEmpty) {
      switch (type) {
        case EntryType.formula:
        case EntryType.pump:
          final sum = filtered.fold<double>(0, (p, e) => p + (e.amount ?? 0));
          text = sum == 0 ? '${filtered.length}' : sum.toStringAsFixed(0);
          break;
        case EntryType.breastLeft || EntryType.breastRight:
          text = '${filtered.length}';
          break;
        case EntryType.pee || EntryType.poop:
        case EntryType.other:
        case null:
          text = '${filtered.length}';
          break;
      }
    }

    return InkWell(
      onTap: () => onTap(context, hour, type, inHour),
      child: SizedBox(
        height: rowHeight,
        child: Center(
          child: _buildCountBadge(context, type, text),
        ),
      ),
    );
  }
}

Widget _buildCountBadge(
  BuildContext context,
  EntryType? type,
  String text,
) {
  if (text.isEmpty) {
    return const SizedBox.shrink();
  }

  final scheme = Theme.of(context).colorScheme;
  final colors = _badgeColorsForEntryType(type, scheme);

  return FittedBox(
    fit: BoxFit.scaleDown,
    alignment: Alignment.center,
    child: _CountBadge(
      label: text,
      background: colors.background,
      foreground: colors.foreground,
    ),
  );
}

_BadgeColors _badgeColorsForEntryType(EntryType? type, ColorScheme scheme) {
  switch (type) {
    case EntryType.breastLeft:
      return _BadgeColors(
        background: scheme.primaryContainer,
        foreground: scheme.onPrimaryContainer,
      );
    case EntryType.breastRight:
      return _BadgeColors(
        background: scheme.secondaryContainer,
        foreground: scheme.onSecondaryContainer,
      );
    case EntryType.formula:
      return _BadgeColors(
        background: scheme.tertiaryContainer,
        foreground: scheme.onTertiaryContainer,
      );
    case EntryType.pump:
      return _BadgeColors(
        background: scheme.primary,
        foreground: scheme.onPrimary,
      );
    case EntryType.pee:
      return _BadgeColors(
        background: Colors.amber.shade200,
        foreground: scheme.onPrimaryContainer,
      );
    case EntryType.poop:
      return _BadgeColors(
        background: scheme.secondary,
        foreground: scheme.onSecondary,
      );
    case EntryType.other:
      return _BadgeColors(
        background: scheme.surfaceContainerHighest,
        foreground: scheme.onSurfaceVariant,
      );
    case null:
      return _BadgeColors(
        background: scheme.surfaceContainerHighest,
        foreground: scheme.onSurfaceVariant,
      );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = Theme.of(context).textTheme.labelSmall ??
        const TextStyle(fontSize: 12);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: baseTextStyle.copyWith(
          fontWeight: FontWeight.w700,
          color: foreground,
        ),
      ),
    );
  }
}

class _BadgeColors {
  const _BadgeColors({
    required this.background,
    required this.foreground,
  });

  final Color background;
  final Color foreground;
}
