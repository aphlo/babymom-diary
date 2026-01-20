import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';
import '../../domain/entities/update_requirement.dart';

/// 強制アップデートが必要な場合に表示する画面。
///
/// 戻るボタンは無効化され、ユーザーはストアでアップデートするしかない。
class ForceUpdatePage extends StatelessWidget {
  final UpdateRequirement requirement;

  const ForceUpdatePage({super.key, required this.requirement});

  static const _primaryColor = Color(0xFFE87086);
  static const _fontFamily = 'MPLUSRounded1c';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: context.surfaceBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const Spacer(flex: 2),
                // アイコン
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: _primaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.download_rounded,
                    size: 56,
                    color: _primaryColor,
                  ),
                ),
                const SizedBox(height: 40),
                // タイトル
                Text(
                  '新しいバージョンが\n利用可能です',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: _fontFamily,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: context.textPrimary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                // メッセージ
                Text(
                  requirement.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: _fontFamily,
                    fontSize: 15,
                    color: context.textSecondary,
                    height: 1.6,
                  ),
                ),
                const Spacer(flex: 3),
                // ボタン
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => _openStore(context, requirement.storeUrl),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'アップデートする',
                      style: TextStyle(
                        fontFamily: _fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openStore(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      final canLaunch = await canLaunchUrl(uri);
      if (canLaunch) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Cannot launch URL: $url');
        if (context.mounted) {
          _showErrorSnackBar(context);
        }
      }
    } catch (e) {
      debugPrint('Error opening store: $e');
      if (context.mounted) {
        _showErrorSnackBar(context);
      }
    }
  }

  void _showErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'ストアを開けませんでした。\nApp Store/Google Play Storeから直接更新してください。',
          style: TextStyle(fontFamily: _fontFamily),
        ),
        duration: Duration(seconds: 5),
      ),
    );
  }
}
