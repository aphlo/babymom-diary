import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/types/child_icon.dart';
import '../../../../../core/types/gender.dart';

part 'child_summary.freezed.dart';

@freezed
sealed class ChildSummary with _$ChildSummary {
  const ChildSummary._();

  const factory ChildSummary({
    required String id,
    required String name,
    required DateTime birthday,
    DateTime? dueDate,
    required Gender gender,
    required ChildIcon icon,
  }) = _ChildSummary;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'birthday': birthday.toIso8601String(),
        if (dueDate != null) 'dueDate': dueDate!.toIso8601String(),
        'gender': gender.key,
        'icon': icon.key,
      };

  static ChildSummary fromJson(Map<String, dynamic> json) {
    final birthdayRaw = json['birthday'];
    final dueDateRaw = json['dueDate'];
    return ChildSummary(
      id: json['id'] as String,
      name: (json['name'] as String?) ?? '未設定',
      birthday: birthdayRaw is String
          ? DateTime.parse(birthdayRaw)
          : DateTime.now(), // フォールバック
      dueDate: dueDateRaw is String ? DateTime.parse(dueDateRaw) : null,
      gender: genderFromKey(json['gender'] as String?),
      icon: childIconFromKey(json['icon'] as String?),
    );
  }
}
