import 'package:flutter/material.dart';

import '../models/vaccine_info.dart';
import '../styles/vaccine_type_styles.dart';
import 'vaccine_type_badge.dart';

const double _doseBadgeDiameter = 24;
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
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

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
}

class VaccineNameCell extends StatelessWidget {
  const VaccineNameCell({
    super.key,
    required this.vaccine,
  });

  final VaccineInfo vaccine;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    final VaccineTypeStyles styles =
        vaccineTypeStyles(vaccine.category, colorScheme);

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
  });

  final List<int> doseNumbers;
  final DoseArrowSegment? arrowSegment;

  @override
  Widget build(BuildContext context) {
    final Color arrowColor = Colors.grey.shade600;

    if (arrowSegment != null) {
      switch (arrowSegment!) {
        case DoseArrowSegment.start:
          if (doseNumbers.isEmpty) {
            return const SizedBox.shrink();
          }
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
              Center(child: DoseNumberBadge(number: doseNumbers.first)),
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

    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 4,
        runSpacing: 4,
        children: displayNumbers
            .map(
              (int number) => DoseNumberBadge(number: number),
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
  });

  final int number;

  @override
  Widget build(BuildContext context) {
    final Color color = Colors.grey.shade600;
    final TextStyle textStyle =
        Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ) ??
            TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            );

    return Container(
      width: _doseBadgeDiameter,
      height: _doseBadgeDiameter,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.5),
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
