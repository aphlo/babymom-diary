import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/preferences/shared_preferences_provider.dart';
import '../domain/repositories/review_prompt_repository.dart';
import '../infrastructure/repositories/review_prompt_repository_impl.dart';
import '../infrastructure/services/in_app_review_service.dart';
import '../presentation/controllers/review_prompt_controller.dart';
import 'usecases/check_review_prompt.dart';
import 'usecases/increment_launch_count.dart';
import 'usecases/increment_record_count.dart';
import 'usecases/mark_as_dissatisfied.dart';
import 'usecases/mark_as_reviewed.dart';
import 'usecases/record_dialog_shown.dart';

part 'review_prompt_providers.g.dart';

@Riverpod(keepAlive: true)
ReviewPromptRepository reviewPromptRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ReviewPromptRepositoryImpl(prefs);
}

@Riverpod(keepAlive: true)
InAppReviewService inAppReviewService(Ref ref) {
  return InAppReviewService();
}

@Riverpod(keepAlive: true)
CheckReviewPrompt checkReviewPromptUseCase(Ref ref) {
  final repository = ref.watch(reviewPromptRepositoryProvider);
  return CheckReviewPrompt(repository);
}

@Riverpod(keepAlive: true)
IncrementRecordCount incrementRecordCountUseCase(Ref ref) {
  final repository = ref.watch(reviewPromptRepositoryProvider);
  return IncrementRecordCount(repository);
}

@Riverpod(keepAlive: true)
IncrementLaunchCount incrementLaunchCountUseCase(Ref ref) {
  final repository = ref.watch(reviewPromptRepositoryProvider);
  return IncrementLaunchCount(repository);
}

@Riverpod(keepAlive: true)
MarkAsReviewed markAsReviewedUseCase(Ref ref) {
  final repository = ref.watch(reviewPromptRepositoryProvider);
  return MarkAsReviewed(repository);
}

@Riverpod(keepAlive: true)
MarkAsDissatisfied markAsDissatisfiedUseCase(Ref ref) {
  final repository = ref.watch(reviewPromptRepositoryProvider);
  return MarkAsDissatisfied(repository);
}

@Riverpod(keepAlive: true)
RecordDialogShown recordDialogShownUseCase(Ref ref) {
  final repository = ref.watch(reviewPromptRepositoryProvider);
  return RecordDialogShown(repository);
}

@Riverpod(keepAlive: true)
ReviewPromptController reviewPromptController(Ref ref) {
  return ReviewPromptController(ref);
}
