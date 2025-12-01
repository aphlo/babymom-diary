import 'package:meta/meta.dart';

import '../value_objects/app_version.dart';

@immutable
class UpdateRequirement {
  final AppVersion minimumVersion;
  final String message;
  final String storeUrl;

  const UpdateRequirement({
    required this.minimumVersion,
    required this.message,
    required this.storeUrl,
  });
}
