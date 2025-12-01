import 'package:flutter/foundation.dart';

import '../../domain/entities/update_requirement.dart';
import '../../domain/repositories/update_config_repository.dart';
import '../../domain/value_objects/app_version.dart';
import '../sources/remote_config_data_source.dart';

class UpdateConfigRepositoryImpl implements UpdateConfigRepository {
  final RemoteConfigDataSource _dataSource;
  final TargetPlatform _platform;

  UpdateConfigRepositoryImpl(this._dataSource, this._platform);

  @override
  Future<UpdateRequirement> getUpdateRequirement() async {
    final minimumVersionString = _dataSource.getMinimumVersion(_platform);
    final message = _dataSource.getMessage();
    final storeUrl = _dataSource.getStoreUrl(_platform);

    return UpdateRequirement(
      minimumVersion: AppVersion.parse(minimumVersionString),
      message: message,
      storeUrl: storeUrl,
    );
  }
}
