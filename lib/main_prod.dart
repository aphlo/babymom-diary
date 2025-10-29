import 'package:flutter/widgets.dart';

import 'bootstrap.dart';
import 'firebase_options_prod.dart';
import 'src/app/app_runner.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap(
    options: DefaultFirebaseOptions.currentPlatform,
    useEmulator: false,
  );
  await runBabymomDiaryApp(appTitle: 'Milu');
}
