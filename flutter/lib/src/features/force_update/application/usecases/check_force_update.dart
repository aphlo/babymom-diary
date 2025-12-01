import 'package:package_info_plus/package_info_plus.dart';

import '../../domain/entities/update_requirement.dart';
import '../../domain/repositories/update_config_repository.dart';
import '../../domain/value_objects/app_version.dart';

class CheckForceUpdate {
  final UpdateConfigRepository _repository;
  final PackageInfo _packageInfo;

  CheckForceUpdate(this._repository, this._packageInfo);

  /// 強制アップデートが必要かチェック
  /// 必要な場合は UpdateRequirement を返し、不要な場合は null
  Future<UpdateRequirement?> execute() async {
    final requirement = await _repository.getUpdateRequirement();
    final currentVersion = AppVersion.parse(_packageInfo.version);

    if (currentVersion < requirement.minimumVersion) {
      return requirement;
    }
    return null;
  }
}
