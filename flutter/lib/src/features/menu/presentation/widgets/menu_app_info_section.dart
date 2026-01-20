import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/semantic_colors.dart';
import 'menu_section.dart';

/// メニューのアプリ情報セクション
class MenuAppInfoSection extends StatelessWidget {
  const MenuAppInfoSection({super.key});

  static const _aboutUrl = 'https://babymom-diary.web.app/';
  static const _termsUrl =
      'https://striped-polonium-ee6.notion.site/milu-2b1de238aa6080acb2a3cbe274d05564?source=copy_link';
  static const _privacyUrl =
      'https://striped-polonium-ee6.notion.site/milu-2b1de238aa60803697b1f06f3c32d2ec?source=copy_link';
  static const _inquiryUrl =
      'https://koeloop.dev/embed/dddb40ea-a331-4cb9-84bb-b81187047a20?theme=light&locale=ja&primaryColor=%23E87086&showVoting=false&showFeedback=true&showFAQ=true&showEmailField=true';
  static const _operatorUrl = 'https://aphlo.com';

  Future<void> _launchExternalUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.inAppWebView,
    );
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('外部サイトを開けませんでした')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'アプリの情報',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: context.subtextColor,
              ),
            ),
          ),
        ),
        MenuSection(
          children: [
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('このアプリについて'),
              onTap: () => _launchExternalUrl(context, _aboutUrl),
              trailing: const Icon(Icons.open_in_new),
            ),
            const Divider(height: 0),
            ListTile(
              leading: const Icon(Icons.mail_outline),
              title: const Text('お問合せ'),
              onTap: () => _launchExternalUrl(context, _inquiryUrl),
              trailing: const Icon(Icons.open_in_new),
            ),
            const Divider(height: 0),
            ListTile(
              leading: const Icon(Icons.business_outlined),
              title: const Text('運営元情報'),
              onTap: () => _launchExternalUrl(context, _operatorUrl),
              trailing: const Icon(Icons.open_in_new),
            ),
            const Divider(height: 0),
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: const Text('利用規約'),
              onTap: () => _launchExternalUrl(context, _termsUrl),
              trailing: const Icon(Icons.open_in_new),
            ),
            const Divider(height: 0),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('プライバシーポリシー'),
              onTap: () => _launchExternalUrl(context, _privacyUrl),
              trailing: const Icon(Icons.open_in_new),
            ),
            const Divider(height: 0),
            ListTile(
              leading: const Icon(Icons.article_outlined),
              title: const Text('ライセンス'),
              onTap: () => showLicensePage(
                context: context,
                applicationName: 'milu',
                applicationLegalese: '© 2025 aphlo',
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      ],
    );
  }
}
