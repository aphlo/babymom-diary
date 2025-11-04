import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/dose_record.dart';

import '../models/vaccine_info.dart';
import '../styles/vaccine_schedule_highlight_styles.dart';
import '../styles/vaccine_type_styles.dart';
import 'vaccine_type_badge.dart';

const double _doseBadgeDiameter = 24;
const double _doseBadgeDiameterSmall = 20;
const double _gridBorderOverlap = 0.6;

class HeaderCornerCell extends StatelessWidget {
  const HeaderCornerCell({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Text(
        text,
        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class HeaderPeriodCell extends StatelessWidget {
  const HeaderPeriodCell({
    super.key,
    required this.label,
    this.scheduledDate,
  });

  final String label;
  final DateTime? scheduledDate;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    if (scheduledDate == null) {
      return Center(
        child: Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    final DateTime date = scheduledDate!;
    final String yearText = date.year.toString();
    final String monthText = date.month.toString().padLeft(2, '0');
    final String dayText = date.day.toString().padLeft(2, '0');

    final TextStyle baseStyle = textTheme.labelSmall?.copyWith(
          color: textTheme.bodyMedium?.color,
          height: 1.0,
        ) ??
        const TextStyle(fontSize: 9, height: 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _ScaledHeaderLabel(
            text: yearText,
            style: baseStyle.copyWith(
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 1),
          _ScaledHeaderLabel(
            text: '$monthText/$dayText',
            style: baseStyle.copyWith(
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 1),
          _ScaledHeaderLabel(
            text: label,
            style: baseStyle.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScaledHeaderLabel extends StatelessWidget {
  const _ScaledHeaderLabel({
    required this.text,
    required this.style,
  });

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: Text(
          text,
          style: style,
          maxLines: 1,
          softWrap: false,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class VaccineNameCell extends StatelessWidget {
  const VaccineNameCell({
    super.key,
    required this.vaccine,
  });

  final VaccineInfo vaccine;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final VaccineTypeStyles styles = vaccineTypeStyles(vaccine.category);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            vaccine.name,
            style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          VaccineTypeBadge(
            label: styles.label,
            backgroundColor: styles.backgroundColor,
            foregroundColor: styles.foregroundColor,
            borderColor: styles.borderColor,
          ),
        ],
      ),
    );
  }
}

enum DoseArrowSegment { start, middle, end }

class DoseScheduleCell extends StatelessWidget {
  const DoseScheduleCell({
    super.key,
    required this.doseNumbers,
    this.arrowSegment,
    this.highlightStyle,
    this.doseStatuses = const <int, DoseStatus?>{},
  });

  final List<int> doseNumbers;
  final DoseArrowSegment? arrowSegment;
  final VaccinePeriodHighlightStyle? highlightStyle;
  final Map<int, DoseStatus?> doseStatuses;

  @override
  Widget build(BuildContext context) {
    final Color arrowColor = Colors.grey.shade600;
    final Color? badgeFillColor = highlightStyle?.badgeFillColor;
    final Color? badgeTextColor = highlightStyle?.badgeTextColor;
    final Color? badgeBorderColor = highlightStyle?.badgeBorderColor;

    if (arrowSegment != null) {
      switch (arrowSegment!) {
        case DoseArrowSegment.start:
          return Stack(
            children: <Widget>[
              SizedBox.expand(
                child: _ArrowLineSegment(
                  color: arrowColor,
                  startFraction: 0.5,
                  startOffset: _doseBadgeDiameter / 2,
                  endFraction: 1,
                  endOffset: _gridBorderOverlap,
                ),
              ),
              if (doseNumbers.isNotEmpty)
                Center(
                  child: DoseNumberBadge(
                    number: doseNumbers.first,
                    size: _doseBadgeDiameter,
                    fontSize: 12,
                    backgroundColor: badgeFillColor,
                    textColor: badgeTextColor,
                    borderColor: badgeBorderColor,
                    status: doseStatuses[doseNumbers.first],
                  ),
                ),
            ],
          );
        case DoseArrowSegment.middle:
          return SizedBox.expand(
            child: _ArrowLineSegment(
              color: arrowColor,
              startFraction: 0,
              startOffset: -_gridBorderOverlap,
              endFraction: 1,
              endOffset: _gridBorderOverlap,
            ),
          );
        case DoseArrowSegment.end:
          return SizedBox.expand(
            child: _ArrowLineSegment(
              color: arrowColor,
              showArrowHead: true,
              startFraction: 0,
              startOffset: -_gridBorderOverlap,
              endFraction: 0.5,
              endOffset: 0,
            ),
          );
      }
    }

    if (doseNumbers.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<int> displayNumbers = List<int>.of(doseNumbers)..sort();

    final bool isMultipleDoses = displayNumbers.length > 1;
    final double badgeSize =
        isMultipleDoses ? _doseBadgeDiameterSmall : _doseBadgeDiameter;
    final double spacing = isMultipleDoses ? 2 : 4;
    final double fontSize = isMultipleDoses ? 10 : 12;

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: displayNumbers
            .asMap()
            .entries
            .map(
              (MapEntry<int, int> entry) => Padding(
                padding: EdgeInsets.only(
                  left: entry.key > 0 ? spacing : 0,
                ),
                child: DoseNumberBadge(
                  number: entry.value,
                  size: badgeSize,
                  fontSize: fontSize,
                  backgroundColor: badgeFillColor,
                  textColor: badgeTextColor,
                  borderColor: badgeBorderColor,
                  status: doseStatuses[entry.value],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class DoseNumberBadge extends StatelessWidget {
  const DoseNumberBadge({
    super.key,
    required this.number,
    this.size = _doseBadgeDiameter,
    this.fontSize = 12,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.status,
  });

  final int number;
  final double size;
  final double fontSize;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final DoseStatus? status;

  @override
  Widget build(BuildContext context) {
    final Color fallbackColor = Colors.grey.shade600;
    Color resolvedTextColor = textColor ?? fallbackColor;
    Color resolvedBorderColor = borderColor ?? fallbackColor;
    Color? resolvedBackgroundColor = backgroundColor;

    if (status == DoseStatus.scheduled) {
      resolvedBackgroundColor = AppColors.reserved;
      resolvedBorderColor = AppColors.reserved;
      resolvedTextColor = Colors.white;
    } else if (status == DoseStatus.completed) {
      resolvedBackgroundColor = AppColors.vaccinated;
      resolvedBorderColor = AppColors.vaccinated;
      resolvedTextColor = Colors.white;
    }

    final TextStyle textStyle =
        Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: resolvedTextColor,
                  fontWeight: FontWeight.w700,
                  fontSize: fontSize,
                ) ??
            TextStyle(
              color: resolvedTextColor,
              fontWeight: FontWeight.w700,
              fontSize: fontSize,
            );

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: resolvedBackgroundColor,
        border: Border.all(color: resolvedBorderColor, width: 1.5),
      ),
      child: Text(
        number.toString(),
        style: textStyle,
      ),
    );
  }
}

class _ArrowLineSegment extends StatelessWidget {
  const _ArrowLineSegment({
    required this.color,
    this.showArrowHead = false,
    required this.startFraction,
    required this.endFraction,
    this.startOffset = 0,
    this.endOffset = 0,
  });

  final Color color;
  final bool showArrowHead;
  final double startFraction;
  final double endFraction;
  final double startOffset;
  final double endOffset;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : _periodFallbackWidth;
        final double height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : _periodFallbackWidth;

        return CustomPaint(
          size: Size(width, height),
          painter: _ArrowPainter(
            color: color,
            showArrowHead: showArrowHead,
            startX: width * startFraction + startOffset,
            tipX: width * endFraction + endOffset,
          ),
        );
      },
    );
  }
}

const double _periodFallbackWidth = 48;

class _ArrowPainter extends CustomPainter {
  const _ArrowPainter({
    required this.color,
    required this.showArrowHead,
    required this.startX,
    required this.tipX,
  });

  final Color color;
  final bool showArrowHead;
  final double startX;
  final double tipX;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double centerY = size.height / 2;
    final double arrowHeadLength = showArrowHead ? 10 : 0;
    final double lineStart = startX;
    final double lineEnd = (showArrowHead ? tipX - arrowHeadLength : tipX);

    if (lineEnd > lineStart) {
      canvas.drawLine(
        Offset(lineStart, centerY),
        Offset(lineEnd, centerY),
        paint,
      );
    }

    if (showArrowHead) {
      final double arrowHeadWidth = 6;
      final Offset tip = Offset(tipX, centerY);
      final Offset upper =
          Offset(tip.dx - arrowHeadLength, centerY - arrowHeadWidth);
      final Offset lower =
          Offset(tip.dx - arrowHeadLength, centerY + arrowHeadWidth);
      canvas.drawLine(tip, upper, paint);
      canvas.drawLine(tip, lower, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.showArrowHead != showArrowHead ||
        oldDelegate.startX != startX ||
        oldDelegate.tipX != tipX;
  }
}

class GridCell extends StatelessWidget {
  const GridCell({
    super.key,
    required this.width,
    required this.height,
    required this.border,
    required this.child,
    this.backgroundColor,
  });

  final double width;
  final double height;
  final Border border;
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        border: border,
      ),
      child: child,
    );
  }
}
