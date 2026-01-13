import 'package:babymom_diary/src/features/review_prompt/application/usecases/increment_record_count.dart';
import 'package:babymom_diary/src/features/review_prompt/domain/entities/review_prompt_state.dart';
import 'package:babymom_diary/src/features/review_prompt/domain/repositories/review_prompt_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockReviewPromptRepository extends Mock
    implements ReviewPromptRepository {}

void main() {
  late MockReviewPromptRepository mockRepository;
  late IncrementRecordCount useCase;

  setUp(() {
    mockRepository = MockReviewPromptRepository();
    useCase = IncrementRecordCount(mockRepository);
  });

  group('IncrementRecordCount', () {
    final now = DateTime(2026, 1, 13, 12, 0, 0);

    test('現在2回 → 増加後3回で条件Aを満たしtrueを返す', () async {
      // Arrange
      final initialState = ReviewPromptState(
        recordCount: 2,
        appLaunchCount: 0,
        hasReviewed: false,
        lastShownDate: null,
      );
      final incrementedState = ReviewPromptState(
        recordCount: 3,
        appLaunchCount: 0,
        hasReviewed: false,
        lastShownDate: null,
      );

      when(() => mockRepository.getState())
          .thenAnswer((_) async => initialState);
      when(() => mockRepository.incrementRecordCount())
          .thenAnswer((_) async => incrementedState);

      // Act
      final result = await useCase(now: now);

      // Assert
      expect(result, isTrue);
      verify(() => mockRepository.getState()).called(1);
      verify(() => mockRepository.incrementRecordCount()).called(1);
    });

    test('起動3回、現在記録0回 → 増加後条件Bを満たしtrueを返す', () async {
      // Arrange
      final initialState = ReviewPromptState(
        recordCount: 0,
        appLaunchCount: 3,
        hasReviewed: false,
        lastShownDate: null,
      );
      final incrementedState = ReviewPromptState(
        recordCount: 1,
        appLaunchCount: 3,
        hasReviewed: false,
        lastShownDate: null,
      );

      when(() => mockRepository.getState())
          .thenAnswer((_) async => initialState);
      when(() => mockRepository.incrementRecordCount())
          .thenAnswer((_) async => incrementedState);

      // Act
      final result = await useCase(now: now);

      // Assert
      expect(result, isTrue);
    });

    test('条件を満たさない場合はfalseを返すがカウントは増加する', () async {
      // Arrange
      final initialState = ReviewPromptState(
        recordCount: 0,
        appLaunchCount: 1, // 起動回数不足
        hasReviewed: false,
        lastShownDate: null,
      );
      final incrementedState = ReviewPromptState(
        recordCount: 1,
        appLaunchCount: 1,
        hasReviewed: false,
        lastShownDate: null,
      );

      when(() => mockRepository.getState())
          .thenAnswer((_) async => initialState);
      when(() => mockRepository.incrementRecordCount())
          .thenAnswer((_) async => incrementedState);

      // Act
      final result = await useCase(now: now);

      // Assert
      expect(result, isFalse);
      // falseでもカウントは増加される
      verify(() => mockRepository.incrementRecordCount()).called(1);
    });

    test('レビュー済みの場合はfalseを返すがカウントは増加する', () async {
      // Arrange
      final initialState = ReviewPromptState(
        recordCount: 2,
        appLaunchCount: 5,
        hasReviewed: true, // レビュー済み
        lastShownDate: null,
      );
      final incrementedState = ReviewPromptState(
        recordCount: 3,
        appLaunchCount: 5,
        hasReviewed: true,
        lastShownDate: null,
      );

      when(() => mockRepository.getState())
          .thenAnswer((_) async => initialState);
      when(() => mockRepository.incrementRecordCount())
          .thenAnswer((_) async => incrementedState);

      // Act
      final result = await useCase(now: now);

      // Assert
      expect(result, isFalse);
      verify(() => mockRepository.incrementRecordCount()).called(1);
    });

    test('本日表示済みの場合はfalseを返すがカウントは増加する', () async {
      // Arrange
      final initialState = ReviewPromptState(
        recordCount: 2,
        appLaunchCount: 5,
        hasReviewed: false,
        lastShownDate: '2026-01-13', // 本日
      );
      final incrementedState = ReviewPromptState(
        recordCount: 3,
        appLaunchCount: 5,
        hasReviewed: false,
        lastShownDate: '2026-01-13',
      );

      when(() => mockRepository.getState())
          .thenAnswer((_) async => initialState);
      when(() => mockRepository.incrementRecordCount())
          .thenAnswer((_) async => incrementedState);

      // Act
      final result = await useCase(now: now);

      // Assert
      expect(result, isFalse);
      verify(() => mockRepository.incrementRecordCount()).called(1);
    });
  });
}
