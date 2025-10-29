import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart'
    as fbcore;
import 'package:babymom_diary/src/core/preferences/shared_preferences_provider.dart';
import 'package:babymom_diary/src/core/router/app_router.dart';
import 'package:babymom_diary/src/core/theme/app_theme_provider.dart';
import 'package:babymom_diary/src/features/children/application/children_local_provider.dart';
import 'package:babymom_diary/src/features/children/application/selected_child_snapshot_provider.dart';
import 'package:babymom_diary/src/features/children/domain/entities/child_summary.dart';

Future<void> runBabymomDiaryApp({
  required String appTitle,
}) async {
  await FirebaseAuth.instance.signInAnonymously();

  final prefs = await SharedPreferences.getInstance();
  final householdService = fbcore.HouseholdService(
    FirebaseAuth.instance,
    FirebaseFirestore.instance,
  );
  final hid = await householdService.ensureHousehold();

  final childrenRaw = prefs.getString(ChildrenLocalNotifier.prefsKey(hid));
  final initialChildren = childrenRaw == null
      ? const <ChildSummary>[]
      : ChildrenLocalNotifier.decodeList(childrenRaw);

  final snapshotRaw =
      prefs.getString(SelectedChildSnapshotNotifier.prefsKey(hid));
  final initialSnapshot =
      snapshotRaw == null ? null : decodeSelectedChildSnapshot(snapshotRaw);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        fbcore.currentHouseholdIdProvider.overrideWith((ref) async => hid),
        childrenLocalProvider(hid).overrideWith((ref) {
          return ChildrenLocalNotifier.withInitial(hid, initialChildren);
        }),
        selectedChildSnapshotProvider(hid).overrideWith((ref) {
          return SelectedChildSnapshotNotifier.withInitial(
            hid,
            initialSnapshot,
          );
        }),
      ],
      child: App(
        appTitle: appTitle,
        initialHouseholdId: hid,
      ),
    ),
  );
}

class App extends ConsumerWidget {
  const App({
    super.key,
    required this.appTitle,
    required this.initialHouseholdId,
  });

  final String appTitle;
  final String initialHouseholdId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final householdAsync = ref.watch(fbcore.currentHouseholdIdProvider);
    final householdId = householdAsync.value ?? initialHouseholdId;
    final router = ref.watch(appRouterProvider);
    final theme = ref.watch(appThemeProvider(householdId));

    if (householdAsync.hasError) {
      final e = householdAsync.error;
      return MaterialApp(
        title: appTitle,
        theme: theme,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [
          Locale('ja'),
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
      );
    }

    return MaterialApp.router(
      title: appTitle,
      theme: theme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('ja'),
        Locale('en'),
      ],
    );
  }
}
