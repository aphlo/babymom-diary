import 'package:flutter/widgets.dart';

import 'bootstrap.dart';
import 'firebase_options_prod.dart';
import 'src/app/app_runner.dart';
import 'src/features/ads/infrastructure/services/admob_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap(
    options: DefaultFirebaseOptions.currentPlatform,
    useEmulator: false,
  );

  // AdMob SDK初期化（ATT許可は後で最初の画面から呼ぶ）
  await AdMobService.initializeMobileAds();

  await runBabymomDiaryApp(appTitle: 'milu (Local)');
}
