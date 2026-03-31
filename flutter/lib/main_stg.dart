import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'bootstrap.dart';
import 'firebase_options_stg.dart';
import 'src/app/app_runner.dart';
import 'src/features/ads/infrastructure/services/admob_service.dart';
import 'src/features/force_update/force_update.dart';
import 'src/features/subscription/infrastructure/services/revenuecat_service.dart';
import 'src/features/widget/infrastructure/repositories/widget_data_repository_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ウィジェット用App Group初期化（STG環境）
  await WidgetDataRepositoryImpl.initialize(isProduction: false);

  await bootstrap(
    options: DefaultFirebaseOptions.currentPlatform,
    useEmulator: false,
  );

  // Remote Config 初期化
  final remoteConfig = FirebaseRemoteConfig.instance;
  final remoteConfigDataSource = RemoteConfigDataSource(remoteConfig);
  await remoteConfigDataSource.initialize();

  // 強制アップデートチェック
  final packageInfo = await PackageInfo.fromPlatform();
  final updateRepository = UpdateConfigRepositoryImpl(
    remoteConfigDataSource,
    defaultTargetPlatform,
  );
  final checkForceUpdate = CheckForceUpdate(updateRepository, packageInfo);
  final updateRequirement = await checkForceUpdate.execute();

  if (updateRequirement != null) {
    // 強制アップデート画面を表示
    runApp(MaterialApp(
      home: ForceUpdatePage(requirement: updateRequirement),
      debugShowCheckedModeBanner: false,
    ));
    return;
  }

  // RevenueCat SDK初期化（STG環境）
  await RevenueCatService.initialize(isProduction: false);

  // AdMob SDK初期化（ATT許可は後で最初の画面から呼ぶ）
  await AdMobService.initializeMobileAds();

  await runBabymomDiaryApp(appTitle: 'milu (STG)');
}
