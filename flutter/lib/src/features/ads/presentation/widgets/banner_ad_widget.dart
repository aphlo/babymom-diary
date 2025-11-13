import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../application/providers/ad_providers.dart';

class BannerAdWidget extends ConsumerStatefulWidget {
  const BannerAdWidget({super.key});

  @override
  ConsumerState<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends ConsumerState<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  Future<void> _loadAd() async {
    final config = ref.read(adConfigProvider);
    final repository = ref.read(adRepositoryProvider);

    try {
      final ad = await repository.loadBannerAd(config.bannerAdUnitId);
      if (mounted) {
        setState(() {
          _bannerAd = ad;
          _isLoaded = true;
        });
      }
    } catch (e) {
      // Failed to load ad
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // バナー広告の標準的な高さ（AdSize.bannerは50px）を最初から確保
    const double bannerHeight = 50.0;

    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: bannerHeight,
        child: _isLoaded && _bannerAd != null
            ? AdWidget(ad: _bannerAd!)
            : const SizedBox.shrink(),
      ),
    );
  }
}
