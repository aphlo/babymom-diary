import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../core/theme/semantic_colors.dart';
import '../../../ads/application/providers/ad_free_providers.dart';
import '../../../ads/infrastructure/services/admob_service.dart';
import '../../../subscription/application/providers/subscription_providers.dart';

class MenuAdFreeRewardSection extends ConsumerStatefulWidget {
  const MenuAdFreeRewardSection({super.key});

  @override
  ConsumerState<MenuAdFreeRewardSection> createState() =>
      _MenuAdFreeRewardSectionState();
}

class _MenuAdFreeRewardSectionState
    extends ConsumerState<MenuAdFreeRewardSection> {
  bool _isLoadingAd = false;

  void _showAd() async {
    if (_isLoadingAd) return;

    setState(() {
      _isLoadingAd = true;
    });

    try {
      final adUnitId = AdMobService.getRewardedAdUnitId();
      await RewardedAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            if (!mounted) {
              ad.dispose();
              return;
            }
            setState(() {
              _isLoadingAd = false;
            });

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('広告の表示に失敗しました。')),
                  );
                }
              },
            );

            ad.show(
              onUserEarnedReward: (adWithoutPersonalizedAds, reward) async {
                if (!mounted) return;
                await ref
                    .read(adFreeUntilProvider.notifier)
                    .setAdFreeDuration(const Duration(hours: 12));
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('12時間バナー広告が非表示になりました！')),
                  );
                }
              },
            );
          },
          onAdFailedToLoad: (error) {
            if (mounted) {
              setState(() {
                _isLoadingAd = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('動画の読み込みに失敗しました。時間をおいて再度お試しください。'),
                ),
              );
            }
            debugPrint('RewardedAd failed to load: $error');
          },
        ),
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingAd = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('エラーが発生しました: $e')),
        );
      }
    }
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours時間$minutes分$seconds秒';
  }

  @override
  Widget build(BuildContext context) {
    final isPremium = ref.watch(isPremiumProvider);
    if (isPremium) {
      return const SizedBox.shrink();
    }

    final isAdFreeActive = ref.watch(isAdFreeActiveProvider);
    final remainingTimeAsync = ref.watch(adFreeRemainingTimeProvider);

    Widget wrapInPadding(Widget child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: context.menuSectionBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: context.menuSectionBorder,
              width: 1.0,
            ),
          ),
          child: child,
        ),
      );
    }

    if (isAdFreeActive) {
      return remainingTimeAsync.when(
        data: (remaining) {
          final timeStr = remaining != null ? _formatDuration(remaining) : '';
          return wrapInPadding(
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              leading: const Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: 24,
              ),
              title: const Text(
                '広告非表示特典が有効です',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '残り時間: $timeStr',
                style: TextStyle(
                  fontSize: 12,
                  color: context.textSecondary,
                ),
              ),
            ),
          );
        },
        loading: () => wrapInPadding(
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            leading: const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            title: const Text('残り時間を計算中...'),
          ),
        ),
        error: (_, __) => wrapInPadding(
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            leading: const Icon(Icons.error_outline, color: Colors.red),
            title: const Text('残り時間の取得に失敗しました'),
          ),
        ),
      );
    }

    return wrapInPadding(
      ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        leading: _isLoadingAd
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(
                Icons.play_circle_fill_rounded,
                color: Color(0xFFE87086),
                size: 24,
              ),
        title: Text(
          _isLoadingAd ? '動画を読み込み中...' : '動画を見て12時間広告を非表示に',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: _isLoadingAd
            ? null
            : Icon(
                Icons.chevron_right,
                color: context.subtextColor,
                size: 20,
              ),
        onTap: _isLoadingAd ? null : _showAd,
      ),
    );
  }
}
