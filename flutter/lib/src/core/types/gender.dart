enum Gender { unknown, male, female }

extension GenderX on Gender {
  String get key {
    switch (this) {
      case Gender.male:
        return 'male';
      case Gender.female:
        return 'female';
      case Gender.unknown:
      default:
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
      default:
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
    default:
      return Gender.unknown;
  }
}
