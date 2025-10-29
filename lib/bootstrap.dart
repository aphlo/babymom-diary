import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

/// Configuration for connecting to the Firebase Emulator Suite.
class FirebaseEmulatorConfig {
  const FirebaseEmulatorConfig({
    this.host = 'localhost',
    this.firestorePort = 8080,
    this.authPort = 9099,
    this.storagePort = 9199,
  });

  final String host;
  final int firestorePort;
  final int authPort;
  final int storagePort;
}

/// Initializes Firebase and optionally connects SDKs to the Emulator Suite.
Future<void> bootstrap({
  required FirebaseOptions options,
  required bool useEmulator,
  FirebaseEmulatorConfig emulatorConfig = const FirebaseEmulatorConfig(),
}) async {
  await Firebase.initializeApp(options: options);

  if (!useEmulator) {
    return;
  }

  final host = emulatorConfig.host;
  FirebaseFirestore.instance.useFirestoreEmulator(
    host,
    emulatorConfig.firestorePort,
  );
  await FirebaseAuth.instance.useAuthEmulator(
    host,
    emulatorConfig.authPort,
  );
}
