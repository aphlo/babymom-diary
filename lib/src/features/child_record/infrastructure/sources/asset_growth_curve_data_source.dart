import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../core/types/gender.dart';
import '../../child_record.dart';

class AssetGrowthCurveDataSource {
  AssetGrowthCurveDataSource({AssetBundle? bundle})
      : _bundle = bundle ?? rootBundle;

  final AssetBundle _bundle;

  static const _heightAssetPath = 'assets/data/height_curves.json';
  static const _weightAssetPath = 'assets/data/weight_curves.json';

  Map<MeasurementType, Map<Gender, List<GrowthCurvePoint>>>? _cache;

  Future<List<GrowthCurvePoint>> loadCurve({
    required MeasurementType measurement,
    required Gender gender,
  }) async {
    final cache = _cache ??= await _loadAllCurves();
    final genderMap = cache[measurement];
    if (genderMap == null) {
      return const [];
    }
    if (gender == Gender.unknown) {
      return genderMap[Gender.male] ??
          genderMap[Gender.female] ??
          const <GrowthCurvePoint>[];
    }
    return genderMap[gender] ?? const <GrowthCurvePoint>[];
  }

  Future<Map<MeasurementType, Map<Gender, List<GrowthCurvePoint>>>>
      _loadAllCurves() async {
    final heightCurves = await _loadCurvesFromAsset(_heightAssetPath);
    final weightCurves = await _loadCurvesFromAsset(_weightAssetPath);
    return {
      MeasurementType.height: heightCurves,
      MeasurementType.weight: weightCurves,
    };
  }

  Future<Map<Gender, List<GrowthCurvePoint>>> _loadCurvesFromAsset(
    String assetPath,
  ) async {
    final jsonStr = await _bundle.loadString(assetPath);
    final decoded = jsonDecode(jsonStr);
    if (decoded is! Map<String, dynamic>) {
      return const {};
    }

    List<GrowthCurvePoint> parseGender(List<dynamic>? rawList) {
      if (rawList == null) {
        return const [];
      }
      return rawList
          .whereType<Map<String, dynamic>>()
          .map(_pointFromJson)
          .toList(growable: false);
    }

    return {
      Gender.male: parseGender(decoded['male'] as List<dynamic>?),
      Gender.female: parseGender(decoded['female'] as List<dynamic>?),
    };
  }

  GrowthCurvePoint _pointFromJson(Map<String, dynamic> json) {
    final ageRaw = json['ageInMonths'];
    final ageInMonths = ageRaw is num ? ageRaw.toDouble() : 0.0;
    final ageLabel = json['ageLabel'] as String? ?? '';

    double value(String key) {
      final raw = json[key];
      if (raw is num) {
        return raw.toDouble();
      }
      throw FormatException('Missing $key in growth curve point: $json');
    }

    final percentiles = {
      Percentile.p3: value('p3'),
      Percentile.p10: value('p10'),
      Percentile.p25: value('p25'),
      Percentile.p50: value('p50'),
      Percentile.p75: value('p75'),
      Percentile.p90: value('p90'),
      Percentile.p97: value('p97'),
    };

    return GrowthCurvePoint(
      ageInMonths: ageInMonths,
      ageLabel: ageLabel,
      percentiles: percentiles,
    );
  }
}
