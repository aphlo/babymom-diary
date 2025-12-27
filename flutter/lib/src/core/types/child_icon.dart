enum ChildIcon { bear, cat, dog, rabbit, snowman }

extension ChildIconX on ChildIcon {
  String get key {
    switch (this) {
      case ChildIcon.bear:
        return 'bear';
      case ChildIcon.cat:
        return 'cat';
      case ChildIcon.dog:
        return 'dog';
      case ChildIcon.rabbit:
        return 'rabbit';
      case ChildIcon.snowman:
        return 'snowman';
    }
  }

  String get assetPath {
    return 'assets/icons/animals/${key}_normal.png';
  }

  String get labelJa {
    switch (this) {
      case ChildIcon.bear:
        return 'くま';
      case ChildIcon.cat:
        return 'ねこ';
      case ChildIcon.dog:
        return 'いぬ';
      case ChildIcon.rabbit:
        return 'うさぎ';
      case ChildIcon.snowman:
        return 'ゆきだるま';
    }
  }
}

ChildIcon childIconFromKey(String? key) {
  switch (key) {
    case 'bear':
      return ChildIcon.bear;
    case 'cat':
      return ChildIcon.cat;
    case 'dog':
      return ChildIcon.dog;
    case 'rabbit':
      return ChildIcon.rabbit;
    case 'snowman':
      return ChildIcon.snowman;
  }
  return ChildIcon.bear;
}
