import 'package:meta/meta.dart';

import 'vaccine.dart';
import '../value_objects/vaccination_period.dart';

@immutable
class VaccineMaster {
  const VaccineMaster({
    required this.periods,
    required this.vaccines,
    this.version,
    this.publishedAt,
  });

  final List<VaccinationPeriod> periods;
  final List<Vaccine> vaccines;
  final String? version;
  final DateTime? publishedAt;
}
