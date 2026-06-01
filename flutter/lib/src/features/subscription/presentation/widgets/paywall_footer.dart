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

  static const _termsUrl =
      'https://striped-polonium-ee6.notion.site/milu-2b1de238aa6080acb2a3cbe274d05564?source=copy_link';
  static const _privacyUrl =
      'https://striped-polonium-ee6.notion.site/milu-2b1de238aa60803697b1f06f3c32d2ec?source=copy_link';

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
      fontSize: 11,
      color: context.subtextColor,
      decoration: TextDecoration.underline,
    );
    final dividerStyle = TextStyle(
      fontSize: 11,
      color: context.subtextColor.withValues(alpha: 0.5),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: isRestoring ? null : onRestore,
            child: isRestoring
                ? const SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(strokeWidth: 1.5),
                  )
                : Text('購入を復元', style: style),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('|', style: dividerStyle),
          ),
          GestureDetector(
            onTap: () => _launchUrl(context, _termsUrl),
            child: Text('利用規約', style: style),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('|', style: dividerStyle),
          ),
          GestureDetector(
            onTap: () => _launchUrl(context, _privacyUrl),
            child: Text('プライバシーポリシー', style: style),
          ),
        ],
      ),
    );
  }
}
