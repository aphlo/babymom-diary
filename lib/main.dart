import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'src/core/router/app_router.dart';
import 'src/core/theme/app_theme.dart';
import 'src/core/firebase/household_service.dart' as fbcore;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signInAnonymously();
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Gate the app until initial household setup completes
    final initHousehold = ref.watch(fbcore.currentHouseholdIdProvider);

    return initHousehold.when(
      data: (_) {
        final router = ref.watch(appRouterProvider);
        return MaterialApp.router(
          title: 'Milu',
          theme: buildTheme(),
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          supportedLocales: const [
            Locale('ja'),
            Locale('en'),
          ],
        );
      },
      loading: () => MaterialApp(
        title: 'Milu',
        theme: buildTheme(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [
          Locale('ja'),
          Locale('en'),
        ],
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (e, __) => MaterialApp(
        title: 'Milu',
        theme: buildTheme(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [
          Locale('ja'),
          Locale('en'),
        ],
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                '初期化に失敗しました\n$e',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
