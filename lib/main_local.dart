import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'bootstrap.dart';
import 'firebase_options_local.dart';
import 'src/app/app_runner.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap(
    options: DefaultFirebaseOptions.currentPlatform,
    useEmulator: true,
    emulatorConfig: FirebaseEmulatorConfig(
      host: _resolveEmulatorHost(),
    ),
  );
  await runBabymomDiaryApp(appTitle: 'Milu (Local)');
}

String _resolveEmulatorHost() {
  const hostOverride = String.fromEnvironment(
    'BABYMOM_FIREBASE_EMULATOR_HOST',
    defaultValue: '',
  );
  if (hostOverride.isNotEmpty) {
    return hostOverride;
  }
  if (defaultTargetPlatform == TargetPlatform.android) {
    return '10.0.2.2';
  }
  return 'localhost';
}
