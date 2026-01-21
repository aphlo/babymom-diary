import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/sale_info.dart';
import '../../infrastructure/sources/sale_remote_config_source.dart';

part 'sale_providers.g.dart';

/// サブスクリプションのセール情報プロバイダー
@riverpod
SaleInfo subscriptionSaleInfo(Ref ref) {
  final remoteConfig = FirebaseRemoteConfig.instance;
  final source = SaleRemoteConfigSource(remoteConfig);
  return source.getSaleInfo();
}
