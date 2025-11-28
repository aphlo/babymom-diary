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
import 'package:babymom_diary/src/features/ads/infrastructure/services/admob_service.dart';
import 'package:babymom_diary/src/features/ads/application/services/banner_ad_manager.dart';
import 'package:babymom_diary/src/features/menu/children/application/children_local_provider.dart';
import 'package:babymom_diary/src/features/menu/children/application/selected_child_provider.dart';
import 'package:babymom_diary/src/features/menu/children/application/selected_child_snapshot_provider.dart';
import 'package:babymom_diary/src/features/menu/children/domain/entities/child_summary.dart';
import 'package:babymom_diary/src/core/analytics/analytics_service.dart';

Future<void> runBabymomDiaryApp({
  required String appTitle,
  bool enableAnalytics = false,
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
        childrenLocalProvider(hid).overrideWith((ref) {
          return ChildrenLocalNotifier.withInitial(hid, initialChildren);
        }),
        selectedChildSnapshotProvider(hid).overrideWith((ref) {
          return SelectedChildSnapshotNotifier.withInitial(
            hid,
            initialSnapshot,
          );
        }),
        analyticsEnabledProvider.overrideWithValue(enableAnalytics),
      ],
      child: App(
        appTitle: appTitle,
        initialHouseholdId: hid,
      ),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({
    super.key,
    required this.appTitle,
    required this.initialHouseholdId,
  });

  final String appTitle;
  final String initialHouseholdId;

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  String? _previousHouseholdId;
  bool _adPreloadStarted = false;

  @override
  void initState() {
    super.initState();
    _previousHouseholdId = widget.initialHouseholdId;
    // 最初のフレームが描画された後にATT許可をリクエスト
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AdMobService.requestATTPermission();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preloadBannerAds();
  }

  /// 全画面分のバナー広告をプリロードする
  void _preloadBannerAds() {
    if (_adPreloadStarted) return;
    _adPreloadStarted = true;

    // 全スロットのバナー広告をプリロード（ATT許可と並行して実行）
    final screenWidth = MediaQuery.of(context).size.width;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final manager = ref.read(bannerAdManagerProvider);
      manager.preloadAll(screenWidth);
    });
  }

  @override
  Widget build(BuildContext context) {
    final householdAsync = ref.watch(fbcore.currentHouseholdIdProvider);
    final householdId = householdAsync.value ?? widget.initialHouseholdId;
    final router = ref.watch(appRouterProvider);
    final theme = ref.watch(appThemeProvider(householdId));

    // 世帯IDが変更されたら選択中の子供をリセット
    if (_previousHouseholdId != null && _previousHouseholdId != householdId) {
      _previousHouseholdId = householdId;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _resetSelectedChildForHousehold(householdId);
      });
    }

    if (householdAsync.hasError) {
      final e = householdAsync.error;
      return MaterialApp(
        title: widget.appTitle,
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
      title: widget.appTitle,
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

  /// 世帯が変わったときに、新しい世帯の子供リストを取得し、
  /// 最初の子供を選択状態にする（子供がいなければnull）
  Future<void> _resetSelectedChildForHousehold(String householdId) async {
    // Firestoreから直接子供リストを取得
    final firestore = ref.read(fbcore.firebaseFirestoreProvider);
    final snapshot = await firestore
        .collection('households')
        .doc(householdId)
        .collection('children')
        .orderBy('birthday')
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // 新しい世帯に子供がいれば最初の子供を選択
      await ref
          .read(selectedChildControllerProvider.notifier)
          .select(snapshot.docs.first.id);
    } else {
      // 子供がいなければ選択を解除
      await ref.read(selectedChildControllerProvider.notifier).select(null);
    }
  }
}
