import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../child_record.dart';
import '../models/growth_chart_data.dart';

class GrowthChart extends StatelessWidget {
  const GrowthChart({
    required this.data,
    required this.ageRange,
    super.key,
  });

  final GrowthChartData data;
  final AgeRange ageRange;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final axis = _axisSettingsFor(ageRange);
    double weightToY(double weight) =>
        ((weight - axis.weightBaselineKg) / axis.weightStepKg)
            .clamp(0, axis.maxTicks.toDouble());
    double yToWeight(double y) => y * axis.weightStepKg + axis.weightBaselineKg;

    final anchorY =
        (axis.weightAnchorKg - axis.weightBaselineKg) / axis.weightStepKg;

    double heightToY(double height) =>
        anchorY + (height - axis.heightBaselineCm) / axis.heightStepCm;
    double yToHeight(double y) =>
        (y - anchorY) * axis.heightStepCm + axis.heightBaselineCm;

    final maxY = axis.maxTicks.toDouble();

    double clampY(double value) => math.min(maxY, math.max(0, value));

    List<FlSpot> buildCurveSpots({
      required List<GrowthCurvePoint> source,
      required Percentile percentile,
      required double Function(double) toY,
    }) {
      if (source.isEmpty) {
        return const <FlSpot>[];
      }

      final spots = source
          .map(
            (point) => FlSpot(
              point.ageInMonths,
              clampY(toY(point.valueFor(percentile))),
            ),
          )
          .toList(growable: true);

      final lastPoint = source.last;
      final maxX = ageRange.maxMonths;
      if (lastPoint.ageInMonths < maxX) {
        final lastValue = lastPoint.valueFor(percentile);
        double projectedValue = lastValue;
        if (source.length >= 2) {
          final previousPoint = source[source.length - 2];
          final previousValue = previousPoint.valueFor(percentile);
          final deltaMonths = lastPoint.ageInMonths - previousPoint.ageInMonths;
          if (deltaMonths.abs() > 1e-6) {
            final slope = (lastValue - previousValue) / deltaMonths;
            projectedValue = lastValue + slope * (maxX - lastPoint.ageInMonths);
          }
        }
        spots.add(
          FlSpot(
            maxX,
            clampY(toY(projectedValue)),
          ),
        );
      }

      return List<FlSpot>.from(spots, growable: false);
    }

    List<FlSpot> heightSpots(Percentile percentile) {
      return buildCurveSpots(
        source: data.heightCurve,
        percentile: percentile,
        toY: heightToY,
      );
    }

    List<FlSpot> weightSpots(Percentile percentile) {
      return buildCurveSpots(
        source: data.weightCurve,
        percentile: percentile,
        toY: weightToY,
      );
    }

    final heightMeasurementSpots = data.measurements
        .where((m) => m.hasHeight)
        .map((m) => FlSpot(
              m.ageInMonths,
              math.min(maxY, math.max(0, heightToY(m.height!))),
            ))
        .toList(growable: false);

    final weightMeasurementSpots = data.measurements
        .where((m) => m.hasWeight)
        .map((m) => FlSpot(
              m.ageInMonths,
              math.min(maxY, math.max(0, weightToY(m.weight!))),
            ))
        .toList(growable: false);

    double bottomInterval() {
      final maxMonths = ageRange.maxMonths;
      if (maxMonths <= 12) return 1;
      if (maxMonths <= 24) return 2;
      return 6;
    }

    const heightCurveColor = Color(0xFFE87086);
    const weightCurveColor = Color(0xFF2196F3);
    final heightBandColor = heightCurveColor.withOpacity(0.25);
    final weightBandColor = weightCurveColor.withOpacity(0.25);
    const heightLabelColor = heightCurveColor;
    const weightLabelColor = weightCurveColor;

    double? maxLabel(Set<double> labels) {
      if (labels.isEmpty) {
        return null;
      }
      return labels.reduce(math.max);
    }

    final maxWeightLabel = maxLabel(axis.weightLabels);
    final maxHeightLabel = maxLabel(axis.heightLabels);

    final bars = <LineChartBarData>[
      _bandLine(heightSpots(Percentile.p97), Colors.transparent),
      _bandLine(heightSpots(Percentile.p3), Colors.transparent),
      _bandLine(weightSpots(Percentile.p97), Colors.transparent),
      _bandLine(weightSpots(Percentile.p3), Colors.transparent),
      _measurementDots(heightMeasurementSpots, heightCurveColor),
      _measurementDots(weightMeasurementSpots, weightCurveColor),
    ];

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: ageRange.maxMonths,
        minY: 0,
        maxY: maxY,
        lineTouchData: const LineTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                final weight = yToWeight(value);
                final snapped = _snapToStep(weight, axis.weightStepKg);
                if (!axis.weightLabels.contains(snapped)) {
                  return const SizedBox.shrink();
                }
                final textStyle =
                    (theme.textTheme.labelSmall ?? const TextStyle())
                        .copyWith(color: weightLabelColor);
                if (maxWeightLabel != null && snapped == maxWeightLabel) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('(kg)', style: textStyle),
                      Text(
                        snapped.toStringAsFixed(0),
                        style: textStyle,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  );
                }
                return Text(
                  snapped.toStringAsFixed(0),
                  style: textStyle,
                  textAlign: TextAlign.right,
                );
              },
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                final height = yToHeight(value);
                final snapped = _snapToStep(
                      height - axis.heightBaselineCm,
                      axis.heightStepCm,
                    ) +
                    axis.heightBaselineCm;
                if (!axis.heightLabels.contains(snapped)) {
                  return const SizedBox.shrink();
                }
                final textStyle =
                    (theme.textTheme.labelSmall ?? const TextStyle())
                        .copyWith(color: heightLabelColor);
                if (maxHeightLabel != null && snapped == maxHeightLabel) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('(cm)', style: textStyle),
                      Text(
                        snapped.toStringAsFixed(0),
                        style: textStyle,
                      ),
                    ],
                  );
                }
                return Text(
                  snapped.toStringAsFixed(0),
                  style: textStyle,
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: bottomInterval(),
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                if (value < 0 || value > ageRange.maxMonths + 0.01) {
                  return const SizedBox.shrink();
                }
                final display = value.toStringAsFixed(value % 1 == 0 ? 0 : 1);
                return Text(display, style: theme.textTheme.labelSmall);
              },
            ),
          ),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          drawVerticalLine: true,
          verticalInterval: bottomInterval(),
          drawHorizontalLine: true,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) => FlLine(
            color: theme.dividerColor.withOpacity(0.3),
            strokeWidth: 0.5,
          ),
          getDrawingVerticalLine: (value) => FlLine(
            color: theme.dividerColor.withOpacity(0.25),
            strokeWidth: 0.5,
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: theme.dividerColor.withOpacity(0.6),
            width: 0.5,
          ),
        ),
        lineBarsData: bars,
        betweenBarsData: [
          BetweenBarsData(
            fromIndex: 0,
            toIndex: 1,
            color: heightBandColor.withOpacity(0.25),
          ),
          BetweenBarsData(
            fromIndex: 2,
            toIndex: 3,
            color: weightBandColor.withOpacity(0.25),
          ),
        ],
      ),
    );
  }

  LineChartBarData _bandLine(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 2,
      dotData: const FlDotData(show: false),
    );
  }

  LineChartBarData _measurementDots(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      color: Colors.transparent,
      barWidth: 0,
      isCurved: false,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
          radius: 4,
          color: Colors.white,
          strokeColor: color,
          strokeWidth: 2,
        ),
      ),
    );
  }
}

double _snapToStep(double value, double step) {
  if (step == 0) {
    return value;
  }
  final snapped = (value / step).round() * step;
  return double.parse(snapped.toStringAsFixed(6));
}

_AxisSettings _axisSettingsFor(AgeRange range) {
  switch (range) {
    case AgeRange.fourYears:
      return _AxisSettings(
        weightStepKg: 2,
        weightBaselineKg: 0,
        weightAnchorKg: 0,
        heightBaselineCm: 30,
        heightStepCm: 5,
        maxTicks: 17,
        weightLabels: {
          for (final v in [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24])
            v.toDouble(),
        },
        heightLabels: {
          for (final v in [
            35,
            40,
            45,
            50,
            55,
            60,
            65,
            70,
            75,
            80,
            85,
            90,
            95,
            100,
            105,
            110
          ])
            v.toDouble(),
        },
      );
    case AgeRange.oneYear:
      return _AxisSettings(
        weightStepKg: 1,
        weightBaselineKg: 0,
        weightAnchorKg: 4,
        heightBaselineCm: 30,
        heightStepCm: 5,
        maxTicks: 15,
        weightLabels: {
          for (final v in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]) v.toDouble(),
        },
        heightLabels: {
          for (final v in [30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80])
            v.toDouble(),
        },
      );
    case AgeRange.twoYears:
      return _AxisSettings(
        weightStepKg: 2,
        weightBaselineKg: 0,
        weightAnchorKg: 6,
        heightBaselineCm: 40,
        heightStepCm: 5,
        maxTicks: 15,
        weightLabels: {
          for (final v in [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]) v.toDouble(),
        },
        heightLabels: {
          for (final v in [40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100])
            v.toDouble(),
        },
      );
  }
}

class _AxisSettings {
  const _AxisSettings({
    required this.weightStepKg,
    required this.weightBaselineKg,
    required this.weightAnchorKg,
    required this.heightBaselineCm,
    required this.heightStepCm,
    required this.maxTicks,
    required this.weightLabels,
    required this.heightLabels,
  });

  final double weightStepKg;
  final double weightBaselineKg;
  final double weightAnchorKg;
  final double heightBaselineCm;
  final double heightStepCm;
  final int maxTicks;
  final Set<double> weightLabels;
  final Set<double> heightLabels;
}
