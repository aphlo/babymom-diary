import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers/ad_providers.dart';

part 'banner_ad_manager.g.dart';

/// バナー広告のスロット識別子
///
/// 各画面で使用する広告を識別するために使用
enum BannerAdSlot {
  // ベビーの記録タブ
  feedingTable,
  babyFood,
  growthChart,
  growthRecordList,

  // 予防接種タブ
  vaccines,

  // ママの記録タブ
  momRecordOverview,
  momDiaryOverview,

  // メニュータブ
  menu,

  // 設定画面（遅延ロード）
  householdShare,
  ingredientSettings,
  growthChartSettings,
  widgetSettings,
  feedingTableSettings,
  notificationSettings,
  vaccineVisibilitySettings,
}

/// ボトムナビゲーションのタブ
enum BottomNavTab {
  baby,
  vaccines,
  mom,
  calendar,
  menu,
}

/// タブごとの広告スロットマッピング
extension BannerAdSlotExtension on BannerAdSlot {
  /// このスロットが属するタブ（設定画面はnull）
  BottomNavTab? get tab {
    switch (this) {
      case BannerAdSlot.feedingTable:
      case BannerAdSlot.babyFood:
      case BannerAdSlot.growthChart:
      case BannerAdSlot.growthRecordList:
        return BottomNavTab.baby;
      case BannerAdSlot.vaccines:
        return BottomNavTab.vaccines;
      case BannerAdSlot.momRecordOverview:
      case BannerAdSlot.momDiaryOverview:
        return BottomNavTab.mom;
      case BannerAdSlot.menu:
        return BottomNavTab.menu;
      // 設定画面は遅延ロード
      case BannerAdSlot.householdShare:
      case BannerAdSlot.ingredientSettings:
      case BannerAdSlot.growthChartSettings:
      case BannerAdSlot.widgetSettings:
      case BannerAdSlot.feedingTableSettings:
      case BannerAdSlot.notificationSettings:
      case BannerAdSlot.vaccineVisibilitySettings:
        return null;
    }
  }

  /// 設定画面かどうか
  bool get isSettingsScreen => tab == null;
}

/// タブに属するスロット一覧を取得
extension BottomNavTabExtension on BottomNavTab {
  List<BannerAdSlot> get slots {
    return BannerAdSlot.values.where((slot) => slot.tab == this).toList();
  }
}

/// 各スロットの広告状態
class _SlotState {
  BannerAd? ad;
  AdSize? adSize;
  bool isLoading = false;
  Completer<void>? loadCompleter;

  void dispose() {
    ad?.dispose();
    ad = null;
    adSize = null;
  }
}

/// バナー広告のプリロードとキャッシュを管理するサービス
///
/// タブ切り替え時にそのタブの広告をプリロードし、
/// 設定画面は画面遷移時に遅延ロードする
class BannerAdManager {
  final Ref _ref;
  final Map<BannerAdSlot, _SlotState> _slots = {};
  final Set<BottomNavTab> _preloadedTabs = {};
  bool _isDisposed = false;
  double? _screenWidth;

  BannerAdManager(this._ref) {
    // 各スロットの状態を初期化
    for (final slot in BannerAdSlot.values) {
      _slots[slot] = _SlotState();
    }
  }

  /// 指定スロットにキャッシュされた広告があるかどうか
  bool hasAd(BannerAdSlot slot) => _slots[slot]?.ad != null;

  /// 指定スロットの広告サイズ
  AdSize? getAdSize(BannerAdSlot slot) => _slots[slot]?.adSize;

  /// 指定タブの広告をプリロードする
  ///
  /// 既にプリロード済みのタブは再ロードしない
  Future<void> preloadTab(BottomNavTab tab, double width) async {
    if (_isDisposed) return;
    _screenWidth = width;

    // 既にプリロード済みならスキップ
    if (_preloadedTabs.contains(tab)) return;
    _preloadedTabs.add(tab);

    // タブに属するスロットを並行してプリロード
    final slots = tab.slots;
    await Future.wait(
      slots.map((slot) => preload(slot, width)),
    );
  }

  /// 初期タブ（ベビーの記録）の広告をプリロードする
  Future<void> preloadInitialTab(double width) async {
    await preloadTab(BottomNavTab.baby, width);
  }

  /// 指定スロットの広告をプリロードする
  Future<void> preload(BannerAdSlot slot, double width) async {
    final slotState = _slots[slot];
    if (slotState == null || _isDisposed) return;
    if (slotState.ad != null) {
      // 既にロード済みの場合、待機中のCompleterがあれば完了させる
      slotState.loadCompleter?.complete();
      return;
    }

    // 既にロード中の場合は既存のCompleterを待機
    if (slotState.isLoading && slotState.loadCompleter != null) {
      await slotState.loadCompleter!.future;
      return;
    }

    slotState.isLoading = true;

    // Completerがまだ無ければ作成（待機中のウィジェットに通知するため）
    slotState.loadCompleter ??= Completer<void>();
    final completer = slotState.loadCompleter!;

    try {
      final config = _ref.read(adConfigProvider);

      // Anchored Adaptive Bannerを使用
      // iPadなど大画面でnullが返される場合はLeaderboardサイズにフォールバック
      final adaptiveSize =
          await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        width.truncate(),
      );

      final AdSize adSize;
      // iPadなど大画面でnullが返される場合のフォールバック
      if (adaptiveSize == null) {
        // 幅に応じて適切なフォールバックサイズを選択
        if (width >= 728) {
          adSize = AdSize.leaderboard; // 728x90
        } else if (width >= 468) {
          adSize = AdSize.fullBanner; // 468x60
        } else {
          adSize = AdSize.banner; // 320x50
        }
      } else {
        adSize = adaptiveSize;
      }

      if (_isDisposed) {
        slotState.isLoading = false;
        if (!completer.isCompleted) completer.complete();
        return;
      }

      final ad = await _loadBannerAd(config.bannerAdUnitId, adSize);

      if (_isDisposed) {
        ad?.dispose();
        slotState.isLoading = false;
        if (!completer.isCompleted) completer.complete();
        return;
      }

      slotState.ad = ad;
      slotState.adSize = adSize;
    } catch (e) {
      // 広告の読み込み失敗は無視
    } finally {
      slotState.isLoading = false;
      if (!completer.isCompleted) {
        completer.complete();
      }
    }
  }

  /// 指定スロットのプリロード完了を待機する
  ///
  /// プリロードがまだ開始されていない場合もCompleterを作成して待機する。
  /// これにより、BannerAdWidgetがpreloadより先に呼ばれても正しく待機できる。
  Future<void> waitForPreload(BannerAdSlot slot) async {
    final slotState = _slots[slot];
    if (slotState == null) return;

    // Completerがまだ無ければ作成（preloadが後から呼ばれた時に完了通知を受け取れるように）
    slotState.loadCompleter ??= Completer<void>();

    if (!slotState.loadCompleter!.isCompleted) {
      await slotState.loadCompleter!.future;
    }
  }

  /// 指定スロットの広告を取得する
  ///
  /// 取得後、そのスロットの広告は消費され、
  /// バックグラウンドで次の広告がプリフェッチされる
  (BannerAd?, AdSize?) consumeAd(BannerAdSlot slot) {
    final slotState = _slots[slot];
    if (slotState == null) return (null, null);

    final ad = slotState.ad;
    final size = slotState.adSize;

    // 広告を消費（次回用にクリア）
    slotState.ad = null;
    slotState.adSize = null;
    slotState.loadCompleter = null; // 次回のプリロード待機用にリセット

    // 次の広告をバックグラウンドでプリフェッチ
    if (_screenWidth != null) {
      _prefetchSlot(slot);
    }

    return (ad, size);
  }

  /// 指定スロットの次の広告をプリフェッチ
  void _prefetchSlot(BannerAdSlot slot) {
    Future.microtask(() async {
      if (_isDisposed || _screenWidth == null) return;
      await preload(slot, _screenWidth!);
    });
  }

  Future<BannerAd?> _loadBannerAd(String adUnitId, AdSize adSize) async {
    final completer = Completer<BannerAd?>();

    final ad = BannerAd(
      adUnitId: adUnitId,
      size: adSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!completer.isCompleted) {
            completer.complete(ad as BannerAd);
          }
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (!completer.isCompleted) {
            completer.complete(null);
          }
        },
      ),
    );

    await ad.load();

    // タイムアウト付きで待機（最大5秒）
    return completer.future.timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        if (!completer.isCompleted) {
          ad.dispose();
        }
        return null;
      },
    );
  }

  void dispose() {
    _isDisposed = true;
    for (final slotState in _slots.values) {
      slotState.dispose();
    }
    _slots.clear();
  }
}

/// BannerAdManagerのプロバイダー
@Riverpod(keepAlive: true)
BannerAdManager bannerAdManager(Ref ref) {
  final manager = BannerAdManager(ref);
  ref.onDispose(() => manager.dispose());
  return manager;
}
