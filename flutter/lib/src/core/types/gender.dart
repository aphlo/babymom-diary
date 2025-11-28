enum Gender { unknown, male, female }

extension GenderX on Gender {
  String get key {
    switch (this) {
      case Gender.male:
        return 'male';
      case Gender.female:
        return 'female';
      case Gender.unknown:
        return 'unknown';
    }
  }

  String get labelJa {
    switch (this) {
      case Gender.male:
        return '（男）';
      case Gender.female:
        return '（女）';
      case Gender.unknown:
        return '';
    }
  }
}

Gender genderFromKey(String? key) {
  switch (key) {
    case 'male':
      return Gender.male;
    case 'female':
      return Gender.female;
    case 'unknown':
      return Gender.unknown;
  }
  return Gender.unknown;
}
