import 'package:freezed_annotation/freezed_annotation.dart';

import '../value_objects/app_version.dart';

part 'update_requirement.freezed.dart';

@freezed
sealed class UpdateRequirement with _$UpdateRequirement {
  const factory UpdateRequirement({
    required AppVersion minimumVersion,
    required String message,
    required String storeUrl,
  }) = _UpdateRequirement;
}
