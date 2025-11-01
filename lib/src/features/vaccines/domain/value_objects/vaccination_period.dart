import 'package:meta/meta.dart';

@immutable
class VaccinationPeriod {
  const VaccinationPeriod({
    required this.id,
    required this.label,
    required this.order,
  });

  final String id;
  final String label;
  final int order;
}

const List<VaccinationPeriod> standardVaccinationPeriods = <VaccinationPeriod>[
  VaccinationPeriod(id: '0ヶ月', label: '0ヶ月', order: 0),
  VaccinationPeriod(id: '1ヶ月', label: '1ヶ月', order: 1),
  VaccinationPeriod(id: '2ヶ月', label: '2ヶ月', order: 2),
  VaccinationPeriod(id: '3ヶ月', label: '3ヶ月', order: 3),
  VaccinationPeriod(id: '4ヶ月', label: '4ヶ月', order: 4),
  VaccinationPeriod(id: '5ヶ月', label: '5ヶ月', order: 5),
  VaccinationPeriod(id: '6ヶ月', label: '6ヶ月', order: 6),
  VaccinationPeriod(id: '7ヶ月', label: '7ヶ月', order: 7),
  VaccinationPeriod(id: '8ヶ月', label: '8ヶ月', order: 8),
  VaccinationPeriod(id: '9-11ヶ月', label: '9-11ヶ月', order: 9),
  VaccinationPeriod(id: '12-15ヶ月', label: '12-15ヶ月', order: 10),
  VaccinationPeriod(id: '16-17ヶ月', label: '16〜17ヶ月', order: 11),
  VaccinationPeriod(id: '18-23ヶ月', label: '18〜23ヶ月', order: 12),
  VaccinationPeriod(id: '2才', label: '2才', order: 13),
  VaccinationPeriod(id: '3才', label: '3才', order: 14),
  VaccinationPeriod(id: '4才', label: '4才', order: 15),
  VaccinationPeriod(id: '5才', label: '5才', order: 16),
  VaccinationPeriod(id: '6才', label: '6才', order: 17),
];
