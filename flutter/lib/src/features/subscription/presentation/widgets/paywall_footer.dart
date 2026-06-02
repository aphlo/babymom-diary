import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/semantic_colors.dart';

class PaywallFooter extends StatelessWidget {
  const PaywallFooter({
    super.key,
    required this.isRestoring,
    required this.onRestore,
  });

  final bool isRestoring;
  final VoidCallback onRestore;

  static const _termsUrl = 'https://babymom-diary.web.app/terms.html';
  static const _privacyUrl = 'https://babymom-diary.web.app/privacy.html';
  static const _legalUrl = 'https://babymom-diary.web.app/tokushoho.html';

  Future<void> _launchUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final launched = await launchUrl(uri, mode: LaunchMode.inAppWebView);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ページを開けませんでした')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: 10.5,
      color: context.subtextColor,
      decoration: TextDecoration.underline,
    );
    final dividerStyle = TextStyle(
      fontSize: 10.5,
      color: context.subtextColor.withValues(alpha: 0.3),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        runSpacing: 4,
        children: [
          GestureDetector(
            onTap: isRestoring ? null : onRestore,
            child: isRestoring
                ? const SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(strokeWidth: 1.5),
                  )
                : Text('復元', style: style),
          ),
          Text('|', style: dividerStyle),
          GestureDetector(
            onTap: () => _launchUrl(context, _termsUrl),
            child: Text('利用規約', style: style),
          ),
          Text('|', style: dividerStyle),
          GestureDetector(
            onTap: () => _launchUrl(context, _privacyUrl),
            child: Text('プライバシー', style: style),
          ),
          Text('|', style: dividerStyle),
          GestureDetector(
            onTap: () => _launchUrl(context, _legalUrl),
            child: Text('特定商取引法', style: style),
          ),
        ],
      ),
    );
  }
}
