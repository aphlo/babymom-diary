import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../application/services/banner_ad_manager.dart';

/// アダプティブバナー広告を表示するウィジェット
///
/// 画面幅に応じた最適なサイズのバナー広告を表示する。
/// BannerAdManagerによりプリロードされた広告があれば即座に表示する。
///
/// [slot] パラメータで各画面用の広告スロットを指定する。
class BannerAdWidget extends ConsumerStatefulWidget {
  const BannerAdWidget({
    super.key,
    required this.slot,
  });

  /// この広告が使用するスロット
  final BannerAdSlot slot;

  @override
  ConsumerState<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends ConsumerState<BannerAdWidget> {
  BannerAd? _bannerAd;
  AdSize? _adSize;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoaded) {
      _loadAd();
    }
  }

  Future<void> _loadAd() async {
    _isLoaded = true;

    final manager = ref.read(bannerAdManagerProvider);

    // キャッシュがなければプリロード完了を待機
    if (!manager.hasAd(widget.slot)) {
      await manager.waitForPreload(widget.slot);
    }

    // キャッシュから取得
    if (manager.hasAd(widget.slot) && mounted) {
      final (ad, size) = manager.consumeAd(widget.slot);
      if (ad != null) {
        setState(() {
          _bannerAd = ad;
          _adSize = size;
        });
      }
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // デフォルトの高さ
    final double bannerHeight = _adSize?.height.toDouble() ?? 60.0;

    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: bannerHeight,
        child: _bannerAd != null
            ? AdWidget(ad: _bannerAd!)
            : const SizedBox.shrink(),
      ),
    );
  }
}
