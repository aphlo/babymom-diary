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
import 'package:babymom_diary/src/core/theme/theme_mode_provider.dart';
import 'package:babymom_diary/src/features/ads/infrastructure/services/admob_service.dart';
import 'package:babymom_diary/src/features/ads/application/services/banner_ad_manager.dart';
import 'package:babymom_diary/src/features/subscription/application/providers/subscription_providers.dart';
import 'package:babymom_diary/src/features/menu/children/application/children_local_provider.dart';
import 'package:babymom_diary/src/features/menu/children/application/selected_child_provider.dart';
import 'package:babymom_diary/src/features/menu/children/application/selected_child_snapshot_provider.dart';
import 'package:babymom_diary/src/features/menu/children/domain/entities/child_summary.dart';
import 'package:babymom_diary/src/core/analytics/analytics_service.dart';
import 'package:babymom_diary/src/features/widget/application/providers/widget_providers.dart';
import 'package:babymom_diary/src/core/deeplink/deep_link_service.dart';
import 'package:babymom_diary/src/features/review_prompt/review_prompt.dart';
import 'package:babymom_diary/src/features/push_notification/infrastructure/services/push_notification_service.dart';

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

  final childrenRaw = prefs.getString(ChildrenLocal.prefsKey(hid));
  final initialChildren = childrenRaw == null
      ? const <ChildSummary>[]
      : ChildrenLocal.decodeList(childrenRaw);

  final snapshotRaw = prefs.getString(SelectedChildSnapshot.prefsKey(hid));
  final initialSnapshot = snapshotRaw == null
      ? null
      : SelectedChildSnapshot.decodeSnapshot(snapshotRaw);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        analyticsEnabledProvider.overrideWithValue(enableAnalytics),
      ],
      child: App(
        appTitle: appTitle,
        initialHouseholdId: hid,
        initialChildren: initialChildren,
        initialSnapshot: initialSnapshot,
      ),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({
    super.key,
    required this.appTitle,
    required this.initialHouseholdId,
    this.initialChildren = const [],
    this.initialSnapshot,
  });

  final String appTitle;
  final String initialHouseholdId;
  final List<ChildSummary> initialChildren;
  final ChildSummary? initialSnapshot;

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  String? _previousHouseholdId;
  bool _adPreloadStarted = false;
  ProviderSubscription<ReviewPromptViewState>? _reviewPromptSub;

  @override
  void initState() {
    super.initState();
    _previousHouseholdId = widget.initialHouseholdId;
    // 最初のフレームが描画された後にATT許可をリクエストとディープリンク初期化
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AdMobService.requestATTPermission();
      _initializeDeepLinks();
      _initializePushNotifications();
      _incrementAppLaunchCount();
      _setupReviewPromptListener();
    });
  }

  /// アプリ起動カウントを増加
  Future<void> _incrementAppLaunchCount() async {
    try {
      final incrementLaunchCount =
          ref.read(incrementLaunchCountUseCaseProvider);
      await incrementLaunchCount();
    } catch (_) {
      // エラーは無視（クリティカルでない処理のため）
    }
  }

  /// レビュープロンプトの状態を監視
  void _setupReviewPromptListener() {
    debugPrint('[ReviewPrompt] Setting up listener');
    _reviewPromptSub = ref.listenManual<ReviewPromptViewState>(
      reviewPromptViewModelProvider,
      (previous, next) {
        debugPrint(
            '[ReviewPrompt] Listener triggered: previous=${previous?.shouldShowDialog}, next=${next.shouldShowDialog}');
        if (next.shouldShowDialog && mounted) {
          debugPrint('[ReviewPrompt] Showing dialog...');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // MaterialApp内のcontextを使用（rootNavigatorKeyから取得）
            final navigatorContext = rootNavigatorKey.currentContext;
            if (mounted && navigatorContext != null) {
              ref
                  .read(reviewPromptViewModelProvider.notifier)
                  .showDialogIfNeeded(navigatorContext);
            }
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _reviewPromptSub?.close();
    super.dispose();
  }

  /// ディープリンクサービスを初期化
  Future<void> _initializeDeepLinks() async {
    final deepLinkService = ref.read(deepLinkServiceProvider);
    await deepLinkService.initialize();
  }

  /// プッシュ通知サービスを初期化
  Future<void> _initializePushNotifications() async {
    try {
      final pushNotificationService = ref.read(pushNotificationServiceProvider);
      await pushNotificationService.initialize();
      pushNotificationService.setupForegroundHandler();
    } catch (e) {
      // プッシュ通知の初期化エラーは無視（クリティカルでない処理のため）
      debugPrint('Failed to initialize push notifications: $e');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preloadBannerAds();
  }

  /// 初期タブ（ベビーの記録）のバナー広告をプリロードする
  void _preloadBannerAds() {
    if (_adPreloadStarted) return;
    _adPreloadStarted = true;

    // プレミアムユーザーはプリロードしない
    final premium = ref.read(isPremiumProvider);
    if (premium) return;

    // 初期タブのバナー広告のみプリロード（他タブはタブ切り替え時にロード）
    final screenWidth = MediaQuery.of(context).size.width;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final manager = ref.read(bannerAdManagerProvider);
      manager.preloadInitialTab(screenWidth);
    });
  }

  @override
  Widget build(BuildContext context) {
    final householdAsync = ref.watch(fbcore.currentHouseholdIdProvider);
    final householdId = householdAsync.value ?? widget.initialHouseholdId;
    final router = ref.watch(appRouterProvider);
    final theme = ref.watch(appThemeProvider(householdId));
    final darkTheme = ref.watch(appDarkThemeProvider(householdId));
    final themeMode = ref.watch(themeModeProvider);

    // ウィジェットデータの自動同期を有効化
    ref.watch(widgetAutoSyncProvider);

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
        darkTheme: darkTheme,
        themeMode: themeMode,
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
      darkTheme: darkTheme,
      themeMode: themeMode,
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
