class VaccineInfo {
  const VaccineInfo({
    required this.name,
    required this.category,
    required this.requirement,
  });

  final String name;
  final VaccineCategory category;
  final VaccineRequirement requirement;
}

enum VaccineCategory { live, inactivated }

enum VaccineRequirement { mandatory, optional }
