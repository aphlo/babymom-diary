import 'package:meta/meta.dart';

import '../../domain/entities/vaccination_record.dart';
import 'vaccine_info.dart';

@immutable
class VaccinesViewData {
  const VaccinesViewData({
    required this.periodLabels,
    required this.vaccines,
    this.version,
    this.publishedAt,
    this.recordsByVaccine = const <String, VaccinationRecord>{},
  });

  final List<String> periodLabels;
  final List<VaccineInfo> vaccines;
  final String? version;
  final DateTime? publishedAt;
  final Map<String, VaccinationRecord> recordsByVaccine;
}
