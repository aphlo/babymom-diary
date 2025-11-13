import 'package:flutter/material.dart';

class DashedTableBorder extends TableBorder {
  const DashedTableBorder({
    super.top = BorderSide.none,
    super.right = BorderSide.none,
    super.bottom = BorderSide.none,
    super.left = BorderSide.none,
    super.horizontalInside = BorderSide.none,
    super.verticalInside = BorderSide.none,
    super.borderRadius = BorderRadius.zero,
    this.dashPattern = const <double>[1.5, 2.5],
    this.strokeCap = StrokeCap.round,
  });

  final List<double> dashPattern;
  final StrokeCap strokeCap;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    required Iterable<double> rows,
    required Iterable<double> columns,
  }) {
    final bool shouldFallback =
        dashPattern.length < 2 || dashPattern.every((value) => value <= 0);
    if (shouldFallback || borderRadius != BorderRadius.zero) {
      super.paint(canvas, rect, rows: rows, columns: columns);
      return;
    }

    Paint? buildPaint(BorderSide side) {
      if (side.style == BorderStyle.none) {
        return null;
      }
      return Paint()
        ..color = side.color
        ..strokeWidth = side.width
        ..style = PaintingStyle.stroke
        ..strokeCap = strokeCap;
    }

    final Paint? verticalPaint = buildPaint(verticalInside);
    if (verticalPaint != null && columns.isNotEmpty) {
      for (final double x in columns) {
        _drawDashedLine(
          canvas,
          verticalPaint,
          Offset(rect.left + x, rect.top),
          Offset(rect.left + x, rect.bottom),
          dashPattern,
        );
      }
    }

    final Paint? horizontalPaint = buildPaint(horizontalInside);
    if (horizontalPaint != null && rows.isNotEmpty) {
      for (final double y in rows) {
        _drawDashedLine(
          canvas,
          horizontalPaint,
          Offset(rect.left, rect.top + y),
          Offset(rect.right, rect.top + y),
          dashPattern,
        );
      }
    }

    void drawOuter(BorderSide side, Offset start, Offset end) {
      final Paint? paint = buildPaint(side);
      if (paint == null) {
        return;
      }
      _drawDashedLine(canvas, paint, start, end, dashPattern);
    }

    drawOuter(top, rect.topLeft, rect.topRight);
    drawOuter(right, rect.topRight, rect.bottomRight);
    drawOuter(bottom, rect.bottomRight, rect.bottomLeft);
    drawOuter(left, rect.bottomLeft, rect.topLeft);
  }
}

void _drawDashedLine(
  Canvas canvas,
  Paint paint,
  Offset start,
  Offset end,
  List<double> pattern,
) {
  final effectivePattern = pattern.where((value) => value > 0).toList();
  if (effectivePattern.length < 2) {
    canvas.drawLine(start, end, paint);
    return;
  }

  final totalLength = (end - start).distance;
  if (totalLength == 0) {
    return;
  }

  final direction = (end - start) / totalLength;
  var distance = 0.0;
  var patternIndex = 0;
  var current = start;

  while (distance < totalLength) {
    final segmentLength =
        effectivePattern[patternIndex % effectivePattern.length];
    final nextDistance = (distance + segmentLength).clamp(0.0, totalLength);
    final delta = direction * (nextDistance - distance);
    final next = current + delta;

    final isDrawSegment = patternIndex.isEven;
    if (isDrawSegment && (nextDistance - distance) > 0) {
      canvas.drawLine(current, next, paint);
    }

    distance = nextDistance;
    current = next;
    patternIndex++;
    if (distance >= totalLength) {
      break;
    }
  }
}
