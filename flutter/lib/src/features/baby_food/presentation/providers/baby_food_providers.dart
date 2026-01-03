import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../application/usecases/add_baby_food_record.dart';
import '../../application/usecases/add_custom_ingredient.dart';
import '../../application/usecases/delete_baby_food_record.dart';
import '../../application/usecases/delete_custom_ingredient.dart';
import '../../application/usecases/update_baby_food_record.dart';
import '../../application/usecases/update_custom_ingredient.dart';
import '../../application/usecases/watch_baby_food_records.dart';
import '../../application/usecases/watch_custom_ingredients.dart';
import '../../domain/entities/baby_food_record.dart';
import '../../domain/entities/custom_ingredient.dart';
import '../../domain/repositories/baby_food_record_repository.dart';
import '../../domain/repositories/custom_ingredient_repository.dart';
import '../../infrastructure/repositories/baby_food_record_repository_impl.dart';
import '../../infrastructure/repositories/custom_ingredient_repository_impl.dart';
import '../../infrastructure/sources/baby_food_firestore_data_source.dart';
import '../../infrastructure/sources/custom_ingredient_firestore_data_source.dart';
import '../../infrastructure/sources/hidden_ingredients_firestore_data_source.dart';
import '../models/ingredient_record_info.dart';

part 'baby_food_providers.g.dart';

// ============================================================================
// Data Sources
// ============================================================================

@riverpod
BabyFoodFirestoreDataSource babyFoodDataSource(Ref ref, String householdId) {
  return BabyFoodFirestoreDataSource(householdId: householdId);
}

@riverpod
CustomIngredientFirestoreDataSource customIngredientDataSource(
    Ref ref, String householdId) {
  return CustomIngredientFirestoreDataSource(householdId: householdId);
}

@riverpod
HiddenIngredientsFirestoreDataSource hiddenIngredientsDataSource(
    Ref ref, String householdId) {
  return HiddenIngredientsFirestoreDataSource(householdId: householdId);
}

// ============================================================================
// Repositories
// ============================================================================

@riverpod
BabyFoodRecordRepository babyFoodRecordRepository(Ref ref, String householdId) {
  final dataSource = ref.watch(babyFoodDataSourceProvider(householdId));
  return BabyFoodRecordRepositoryImpl(dataSource: dataSource);
}

@riverpod
CustomIngredientRepository customIngredientRepository(
    Ref ref, String householdId) {
  final dataSource = ref.watch(customIngredientDataSourceProvider(householdId));
  return CustomIngredientRepositoryImpl(dataSource: dataSource);
}

// ============================================================================
// Use Cases
// ============================================================================

@riverpod
AddBabyFoodRecord addBabyFoodRecordUseCase(Ref ref, String householdId) {
  final repository = ref.watch(babyFoodRecordRepositoryProvider(householdId));
  return AddBabyFoodRecord(repository: repository);
}

@riverpod
UpdateBabyFoodRecord updateBabyFoodRecordUseCase(Ref ref, String householdId) {
  final repository = ref.watch(babyFoodRecordRepositoryProvider(householdId));
  return UpdateBabyFoodRecord(repository: repository);
}

@riverpod
DeleteBabyFoodRecord deleteBabyFoodRecordUseCase(Ref ref, String householdId) {
  final repository = ref.watch(babyFoodRecordRepositoryProvider(householdId));
  return DeleteBabyFoodRecord(repository: repository);
}

@riverpod
WatchBabyFoodRecords watchBabyFoodRecordsUseCase(Ref ref, String householdId) {
  final repository = ref.watch(babyFoodRecordRepositoryProvider(householdId));
  return WatchBabyFoodRecords(repository: repository);
}

@riverpod
AddCustomIngredient addCustomIngredientUseCase(Ref ref, String householdId) {
  final repository = ref.watch(customIngredientRepositoryProvider(householdId));
  return AddCustomIngredient(repository: repository);
}

@riverpod
UpdateCustomIngredient updateCustomIngredientUseCase(
    Ref ref, String householdId) {
  final repository = ref.watch(customIngredientRepositoryProvider(householdId));
  return UpdateCustomIngredient(repository: repository);
}

@riverpod
DeleteCustomIngredient deleteCustomIngredientUseCase(
    Ref ref, String householdId) {
  final repository = ref.watch(customIngredientRepositoryProvider(householdId));
  return DeleteCustomIngredient(repository: repository);
}

@riverpod
WatchCustomIngredients watchCustomIngredientsUseCase(
    Ref ref, String householdId) {
  final repository = ref.watch(customIngredientRepositoryProvider(householdId));
  return WatchCustomIngredients(repository: repository);
}

// ============================================================================
// Stream Providers
// ============================================================================

/// 指定した日の離乳食記録を監視
@riverpod
Stream<List<BabyFoodRecord>> dailyBabyFoodRecords(
  Ref ref,
  DailyBabyFoodRecordsQuery query,
) {
  final useCase =
      ref.watch(watchBabyFoodRecordsUseCaseProvider(query.householdId));
  return useCase.call(childId: query.childId, day: query.date);
}

/// 全ての離乳食記録を監視
@riverpod
Stream<List<BabyFoodRecord>> watchBabyFoodRecords(
  Ref ref, {
  required String householdId,
  required String childId,
}) {
  final repository = ref.watch(babyFoodRecordRepositoryProvider(householdId));
  return repository.watchAllRecords(childId);
}

/// カスタム食材を監視
@riverpod
Stream<List<CustomIngredient>> customIngredients(
  Ref ref,
  String householdId,
) {
  final useCase = ref.watch(watchCustomIngredientsUseCaseProvider(householdId));
  return useCase.call();
}

/// 非表示食材IDを監視
@riverpod
Stream<Set<String>> hiddenIngredients(
  Ref ref,
  String householdId,
) {
  final dataSource =
      ref.watch(hiddenIngredientsDataSourceProvider(householdId));
  return dataSource.watch();
}

/// 離乳食記録のクエリパラメータ
class DailyBabyFoodRecordsQuery {
  const DailyBabyFoodRecordsQuery({
    required this.householdId,
    required this.childId,
    required this.date,
  });

  final String householdId;
  final String childId;
  final DateTime date;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DailyBabyFoodRecordsQuery &&
        other.householdId == householdId &&
        other.childId == childId &&
        other.date.year == date.year &&
        other.date.month == date.month &&
        other.date.day == date.day;
  }

  @override
  int get hashCode =>
      Object.hash(householdId, childId, date.year, date.month, date.day);
}

/// 特定食材の記録をフィルタリングするクエリ
class IngredientRecordsQuery {
  const IngredientRecordsQuery({
    required this.householdId,
    required this.childId,
    required this.ingredientId,
  });

  final String householdId;
  final String childId;
  final String ingredientId;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is IngredientRecordsQuery &&
        other.householdId == householdId &&
        other.childId == childId &&
        other.ingredientId == ingredientId;
  }

  @override
  int get hashCode => Object.hash(householdId, childId, ingredientId);
}

/// 特定食材の記録を取得（フィルタリング済み）
@riverpod
List<IngredientRecordInfo> ingredientRecords(
  Ref ref,
  IngredientRecordsQuery query,
) {
  final recordsAsync = ref.watch(
    watchBabyFoodRecordsProvider(
      householdId: query.householdId,
      childId: query.childId,
    ),
  );

  final records = recordsAsync.value ?? [];
  final result = <IngredientRecordInfo>[];

  for (final record in records) {
    for (final item in record.items) {
      if (item.ingredientId == query.ingredientId) {
        result.add(IngredientRecordInfo(
          recordId: record.id,
          recordedAt: record.recordedAt,
          amount: item.amountDisplay,
          reaction: item.reaction,
          memo: item.memo,
          hasAllergy: item.hasAllergy ?? false,
        ));
      }
    }
  }

  // 日付の新しい順にソート
  result.sort((a, b) => b.recordedAt.compareTo(a.recordedAt));
  return result;
}
