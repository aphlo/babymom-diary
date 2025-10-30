class VaccineInfo {
  const VaccineInfo({
    required this.name,
    required this.category,
    required this.requirement,
    this.doseSchedules = const <String, List<int>>{},
  });

  final String name;
  final VaccineCategory category;
  final VaccineRequirement requirement;
  final Map<String, List<int>> doseSchedules;
}

enum VaccineCategory { live, inactivated }

enum VaccineRequirement { mandatory, optional }
