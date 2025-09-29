class ChildSummary {
  const ChildSummary({
    required this.id,
    required this.name,
    this.birthday,
    this.color,
  });

  final String id;
  final String name;
  final DateTime? birthday;
  final String? color;

  ChildSummary copyWith({
    String? id,
    String? name,
    DateTime? birthday,
    String? color,
  }) {
    return ChildSummary(
      id: id ?? this.id,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'birthday': birthday?.toIso8601String(),
        'color': color,
      };

  factory ChildSummary.fromJson(Map<String, dynamic> json) {
    final birthdayRaw = json['birthday'];
    return ChildSummary(
      id: json['id'] as String,
      name: (json['name'] as String?) ?? '未設定',
      birthday: birthdayRaw is String ? DateTime.tryParse(birthdayRaw) : null,
      color: json['color'] as String?,
    );
  }

  bool isSameAs(ChildSummary other) {
    return id == other.id &&
        name == other.name &&
        birthday == other.birthday &&
        color == other.color;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChildSummary && isSameAs(other);
  }

  @override
  int get hashCode => Object.hash(id, name, birthday, color);
}
