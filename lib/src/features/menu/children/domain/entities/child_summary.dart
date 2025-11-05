import '../../../../../core/types/gender.dart';

class ChildSummary {
  const ChildSummary({
    required this.id,
    required this.name,
    this.birthday,
    this.color,
    this.gender = Gender.unknown,
  });

  final String id;
  final String name;
  final DateTime? birthday;
  final String? color;
  final Gender gender;

  ChildSummary copyWith({
    String? id,
    String? name,
    DateTime? birthday,
    String? color,
    Gender? gender,
  }) {
    return ChildSummary(
      id: id ?? this.id,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      color: color ?? this.color,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'birthday': birthday?.toIso8601String(),
        'color': color,
        'gender': gender.key,
      };

  factory ChildSummary.fromJson(Map<String, dynamic> json) {
    final birthdayRaw = json['birthday'];
    return ChildSummary(
      id: json['id'] as String,
      name: (json['name'] as String?) ?? '未設定',
      birthday: birthdayRaw is String ? DateTime.tryParse(birthdayRaw) : null,
      color: json['color'] as String?,
      gender: genderFromKey(json['gender'] as String?),
    );
  }

  bool isSameAs(ChildSummary other) {
    return id == other.id &&
        name == other.name &&
        birthday == other.birthday &&
        color == other.color &&
        gender == other.gender;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChildSummary && isSameAs(other);
  }

  @override
  int get hashCode => Object.hash(id, name, birthday, color, gender);
}
