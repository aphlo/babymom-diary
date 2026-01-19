import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:babymom_diary/src/features/feeding_table_settings/domain/entities/feeding_table_settings.dart';
import 'package:babymom_diary/src/features/feeding_table_settings/infrastructure/repositories/feeding_table_settings_repository_impl.dart';

part 'feeding_table_settings_providers.g.dart';

/// 授乳表設定をStreamで提供するProvider
@Riverpod(keepAlive: true)
Stream<FeedingTableSettings> feedingTableSettingsStream(Ref ref) {
  final repository = ref.watch(feedingTableSettingsRepositoryProvider);
  return repository.watchSettings();
}

/// 現在の授乳表設定を取得するProvider
@Riverpod(keepAlive: true)
Future<FeedingTableSettings> feedingTableSettings(Ref ref) async {
  final repository = ref.watch(feedingTableSettingsRepositoryProvider);
  return repository.getSettings();
}
