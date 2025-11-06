import '../../../../../core/types/gender.dart';

class ChildSummary {
  const ChildSummary({
    required this.id,
    required this.name,
    required this.birthday,
    required this.dueDate,
    required this.gender,
    this.color,
  });

  final String id;
  final String name;
  final DateTime birthday;
  final DateTime dueDate;
  final String? color;
  final Gender gender;

  ChildSummary copyWith({
    String? id,
    String? name,
    DateTime? birthday,
    DateTime? dueDate,
    String? color,
    Gender? gender,
  }) {
    return ChildSummary(
      id: id ?? this.id,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      dueDate: dueDate ?? this.dueDate,
      color: color ?? this.color,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'birthday': birthday.toIso8601String(),
        'dueDate': dueDate.toIso8601String(),
        'color': color,
        'gender': gender.key,
      };

  factory ChildSummary.fromJson(Map<String, dynamic> json) {
    final birthdayRaw = json['birthday'];
    final dueDateRaw = json['dueDate'];
    return ChildSummary(
      id: json['id'] as String,
      name: (json['name'] as String?) ?? '未設定',
      birthday: birthdayRaw is String
          ? DateTime.parse(birthdayRaw)
          : DateTime.now(), // フォールバック
      dueDate: dueDateRaw is String
          ? DateTime.parse(dueDateRaw)
          : DateTime.now(), // フォールバック
      color: json['color'] as String?,
      gender: genderFromKey(json['gender'] as String?),
    );
  }

  bool isSameAs(ChildSummary other) {
    return id == other.id &&
        name == other.name &&
        birthday == other.birthday &&
        dueDate == other.dueDate &&
        color == other.color &&
        gender == other.gender;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChildSummary && isSameAs(other);
  }

  @override
  int get hashCode => Object.hash(id, name, birthday, dueDate, color, gender);
}
