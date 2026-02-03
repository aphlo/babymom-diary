import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/semantic_colors.dart';
import '../../../ads/application/services/banner_ad_manager.dart';
import '../../../ads/presentation/widgets/banner_ad_widget.dart';
import '../viewmodels/notification_settings_view_model.dart';

class NotificationSettingsPage extends ConsumerStatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  ConsumerState<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState
    extends ConsumerState<NotificationSettingsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationSettingsViewModelProvider.notifier).loadSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationSettingsViewModelProvider);
    final notifier = ref.read(notificationSettingsViewModelProvider.notifier);

    // エラー表示
    ref.listen(notificationSettingsViewModelProvider, (previous, next) {
      if (next.error != null && previous?.error != next.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            behavior: SnackBarBehavior.floating,
          ),
        );
        notifier.clearError();
      }
    });

    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: const Text('通知設定'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      // ワクチンリマインダーセクション
                      _buildSectionHeader(context, '予防接種のリマインダー'),
                      _buildSectionDescription(
                        context,
                        '予防接種の予約日が近づくと通知でお知らせします。',
                      ),
                      Container(
                        color: context.cardBackground,
                        child: Column(
                          children: [
                            SwitchListTile(
                              title: const Text('当日に通知'),
                              subtitle: const Text('予約当日の朝に通知'),
                              value: state.isNotifyTodayEnabled,
                              onChanged: (value) {
                                notifier.toggleNotifyToday(value);
                              },
                            ),
                            const Divider(height: 1),
                            SwitchListTile(
                              title: const Text('前日に通知'),
                              subtitle: const Text('予約前日の朝に通知'),
                              value: state.isNotifyTomorrowEnabled,
                              onChanged: (value) {
                                notifier.toggleNotifyTomorrow(value);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // 毎日のエールセクション
                      _buildSectionHeader(context, '毎日のエール'),
                      _buildSectionDescription(
                        context,
                        '毎日夜に、育児を頑張るあなたへ励ましのメッセージをお届けします。',
                      ),
                      Container(
                        color: context.cardBackground,
                        child: SwitchListTile(
                          title: const Text('エールを受け取る'),
                          subtitle: const Text('毎日20時頃に通知'),
                          value: state.isDailyEncouragementEnabled,
                          onChanged: (value) {
                            notifier.toggleDailyEncouragement(value);
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
                const BannerAdWidget(slot: BannerAdSlot.notificationSettings),
              ],
            ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildSectionDescription(BuildContext context, String description) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Text(
        description,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: context.textSecondary,
              height: 1.5,
            ),
      ),
    );
  }
}
