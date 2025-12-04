import 'package:meta/meta.dart';

/// ウィジェットに表示する子供情報
@immutable
class WidgetChild {
  final String id;
  final String name;
  final DateTime birthday;

  const WidgetChild({
    required this.id,
    required this.name,
    required this.birthday,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'birthday': birthday.toIso8601String().split('T').first,
      };

  factory WidgetChild.fromJson(Map<String, dynamic> json) => WidgetChild(
        id: json['id'] as String,
        name: json['name'] as String,
        birthday: DateTime.parse(json['birthday'] as String),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WidgetChild &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          birthday == other.birthday;

  @override
  int get hashCode => Object.hash(id, name, birthday);
}
