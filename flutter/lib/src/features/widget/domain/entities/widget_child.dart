import 'package:freezed_annotation/freezed_annotation.dart';

part 'widget_child.freezed.dart';

/// ウィジェットに表示する子供情報
@Freezed(toJson: false, fromJson: false)
sealed class WidgetChild with _$WidgetChild {
  const WidgetChild._();

  const factory WidgetChild({
    required String id,
    required String name,
    required DateTime birthday,
  }) = _WidgetChild;

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
}
