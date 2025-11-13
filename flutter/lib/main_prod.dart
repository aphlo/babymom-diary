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

  // AdMob初期化
  await AdMobService.initialize();

  await runBabymomDiaryApp(appTitle: 'Milu');
}
