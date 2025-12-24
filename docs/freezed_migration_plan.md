# Freezed 移行計画

## 概要

babymom-diaryプロジェクトにfreezedパッケージを導入し、手動実装のボイラープレートコードを削減する。

## 実施日

- 開始日: 2025-12-22
- 対象環境: Flutter 3.38.3 / Dart 3.10.1

## 導入したパッケージバージョン

```yaml
dependencies:
  freezed_annotation: ^3.1.0

dev_dependencies:
  freezed: ^3.2.3
  build_runner: ^2.10.4
  json_serializable: ^6.7.1  # 既存
```

## 重要な技術的知見

### Dart 3.10 + freezed 3.2.3 では `sealed class` が必須

**正しい実装パターン:**

```dart
@freezed
sealed class MyClass with _$MyClass {
  const factory MyClass({
    required String field1,
    String? field2,
  }) = _MyClass;
}
```

**❌ 動作しないパターン（Dart 3.10）:**

```dart
@freezed
class MyClass with _$MyClass {  // ← sealed がないとコンパイルエラー
  const factory MyClass({...}) = _MyClass;
}
```

### Private Constructor が必要な場合

カスタムメソッドや計算プロパティを追加する場合：

```dart
@freezed
sealed class MyClass with _$MyClass {
  const MyClass._();  // ← private constructor

  const factory MyClass({
    required DateTime date,
    String? content,
  }) = _MyClass;

  // カスタムメソッド
  String get formattedDate => DateFormat('yyyy/MM/dd').format(date);

  // ビジネスロジック
  bool isValid() => content != null && content!.isNotEmpty;
}
```

### analysis_options.yaml の設定

```yaml
analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
  errors:
    invalid_annotation_target: ignore
```

## 段階的導入戦略

### Phase 1: Presentation層のState（優先度：高）✅ 完了

**対象**: 22ファイル以上のState/Paramsクラス

**効果**:
- 手動copyWith/equals/hashCode削除
- UI Eventのパターンマッチング改善
- riverpod_generatorとの共存確認

**完了したファイル（2025-12-22）:**
- `lib/src/features/child_record/presentation/viewmodels/record_state.dart`
  - RecordPageState / RecordSlotRequest / RecordEditorRequest / RecordUiEvent
- `lib/src/features/child_record/presentation/viewmodels/growth_chart/growth_chart_state.dart`
- `lib/src/features/child_record/presentation/viewmodels/record_sheet/editable_record_sheet_state.dart`
  - EditableRecordSheetState / EditableRecordSheetViewModelArgs
- `lib/src/features/child_record/presentation/viewmodels/record_sheet/manage_other_tags_state.dart`
- `lib/src/features/calendar/presentation/viewmodels/calendar_state.dart`
- `lib/src/features/calendar/presentation/viewmodels/calendar_settings_state.dart`
- `lib/src/features/calendar/presentation/viewmodels/add_calendar_event_state.dart`
- `lib/src/features/calendar/presentation/viewmodels/edit_calendar_event_state.dart`
- `lib/src/features/vaccines/presentation/viewmodels/vaccine_reservation_state.dart`
  - VaccineReservationState / VaccineReservationParams
- `lib/src/features/vaccines/presentation/viewmodels/vaccine_detail_state.dart`
  - DoseStatusInfo / DoseRecommendationInfo / VaccineDetailState / VaccineDetailParams
- `lib/src/features/vaccines/presentation/viewmodels/concurrent_vaccines_state.dart`
  - ConcurrentVaccineMember / ConcurrentVaccinesState / ConcurrentVaccinesParams
- `lib/src/features/mom_record/presentation/viewmodels/mom_record_page_state.dart`
- `lib/src/features/mom_record/presentation/viewmodels/mom_diary_page_state.dart`
- `lib/src/features/menu/widget_settings/presentation/viewmodels/widget_settings_state.dart`
  - WidgetSettingsState（static定数・計算プロパティ・ファクトリメソッドあり）
- `lib/src/features/menu/household/presentation/viewmodels/vaccine_visibility_settings_state.dart`
  - VaccineVisibilitySettingsState / VaccineDisplayInfo
  - 注: `clearError`パラメータ付きcopyWithを`clearError()`メソッドに変更

**残タスク:** なし（Phase 1完了）

### Phase 2: シンプルなDomain Entities（優先度：中）✅ 完了

**対象**: ビジネスロジックが少ないEntity/Value Object

**完了したファイル（2025-12-24）:**

#### Entities（9ファイル）
- ✅ `lib/src/features/calendar/domain/entities/calendar_event.dart`
  - 計算プロパティあり: startDateOnly, endDateOnly, occursOn()
  - 手動equals/hashCode/copyWith削除（82行→28行）

- ✅ `lib/src/features/calendar/domain/entities/calendar_settings.dart`
  - 手動equals/hashCode/copyWith/toString削除（33行→12行）

- ✅ `lib/src/features/vaccines/domain/entities/dose_record.dart`
  - 条件付きcopyWith（clearReservationGroupフラグ）→ clearReservationGroup()メソッドに変更
  - ビジネスロジックメソッド: markAsScheduled(), markAsScheduledWithGroup(), markAsCompleted()を保持
  - 手動equals/hashCode/copyWith/toString削除（105行→58行）

- ✅ `lib/src/features/vaccines/domain/entities/reservation_group.dart`
  - ReservationGroupMember + VaccinationReservationGroup の2クラス
  - 手動copyWith削除（56行→27行）

- ✅ `lib/src/features/vaccines/domain/entities/vaccine_reservation_request.dart`
  - clearReservationGroupフラグ → clearReservationGroup()メソッドに変更
  - 手動equals/hashCode/copyWith/toString削除（72行→24行）

- ✅ `lib/src/features/force_update/domain/entities/update_requirement.dart`
  - シンプルな構造（17行→14行）

- ✅ `lib/src/features/menu/household/domain/entities/household_member.dart`
  - isAdmin getterを保持（18行→17行）

- ✅ `lib/src/features/menu/children/domain/entities/child_summary.dart`
  - カスタムtoJson/fromJsonを保持（フォールバック処理あり）
  - isSameAs()メソッドは不要（freezed自動生成の==に置換）
  - 手動copyWith/equals/hashCode削除（72行→40行）

- ✅ `lib/src/features/ads/domain/entities/ad_config.dart`
  - factory AdConfig.test/production → static メソッドに変更
  - （29行→27行）

#### Value Objects（4ファイル）
- ✅ `lib/src/features/force_update/domain/value_objects/app_version.dart`
  - Comparable<AppVersion>インターフェース実装を保持
  - 比較演算子（<, >, <=, >=）を保持
  - factory AppVersion.parse()を保持
  - 手動equals/hashCode削除（80行→68行）

- ✅ `lib/src/features/vaccines/domain/value_objects/vaccination_period.dart`
  - グローバル定数 standardVaccinationPeriods を保持
  - （36行→33行）

- ✅ `lib/src/features/vaccines/domain/value_objects/vaccination_recommendation.dart`
  - @Default使用（23行→19行）

- ✅ `lib/src/features/vaccines/domain/value_objects/influenza_season.dart`
  - InfluenzaSeasonDefinition + InfluenzaSeasonSchedule の2クラス
  - getter, seasonLabel()メソッドを保持
  - （42行→40行）

### Phase 3: Infrastructure層の一部（優先度：低）

**対象**: シンプルなDTO

**完了したファイル（2025-12-22）:**
- ✅ `lib/src/features/mom_record/infrastructure/models/mom_diary_dto.dart`
  - カスタムfromFirestore()ファクトリを保持
  - toFirestoreMap()でFieldValue.delete()を使用

**例（今後）**:
- ReservationGroupMemberDto (lib/src/features/vaccines/infrastructure/models/reservation_group.dart)
  - シンプルな構造、json_serializableと併用可能

**対象外（Firestore複雑処理）**:
- MomRecordDto (lib/src/features/mom_record/infrastructure/models/mom_record_dto.dart)
  - 後方互換性フォールバック多数
  - 複雑なネストされた構造
  - FieldValue.delete()による条件付き削除

### Phase 4: 対象外（手動維持）

**理由: 特殊パターン**

- Sentinel値パターン（BreastCondition）
  - `Object _sentinel`を使ったnullクリア
  - freezedの標準機能では未対応

- Constructor assert検証（MomDailyRecord）
  - `assert(_isDateOnly(date), '...')`
  - freezedでは`@Assert()`を使うが複雑

- 自動生成ID（Record in child_record）
  - Constructor内で`_generateId()`実行
  - freezedでは難しい

- 複雑なDomain Entities
  - VaccinationRecord (258行)
    - 複数のcopyWith亜種: copyWithDose(), copyWithoutDose()
    - 複雑なドメインロジック
    - 将来的な移行候補だが、Phase 2以降で慎重に検討

## 実装手順（1ファイルごと）

### 1. ファイルの準備

```dart
// Before
import 'package:flutter/foundation.dart';

@immutable
class MyState {
  const MyState({required this.field});
  final String field;

  MyState copyWith({String? field}) {
    return MyState(field: field ?? this.field);
  }
}

// After
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_state.freezed.dart';

@freezed
sealed class MyState with _$MyState {
  const factory MyState({
    required String field,
  }) = _MyState;
}
```

### 2. build_runner実行

```bash
cd flutter
fvm dart run build_runner build --delete-conflicting-outputs
```

### 3. 検証

```bash
# コンパイルエラー確認
fvm dart analyze lib/path/to/file.dart

# 全体のビルド確認
fvm flutter test --no-pub
```

## freezedの主な機能と使い方

### 基本的なデータクラス

```dart
@freezed
sealed class User with _$User {
  const factory User({
    required String id,
    required String name,
    int? age,
    @Default(false) bool isActive,
  }) = _User;
}

// 使用例
final user = User(id: '1', name: 'John');
final updated = user.copyWith(age: 30);
```

### Union型（直和型）

```dart
@freezed
sealed class Result with _$Result {
  const factory Result.success(String data) = _Success;
  const factory Result.error(String message) = _Error;
  const factory Result.loading() = _Loading;
}

// パターンマッチング
result.when(
  success: (data) => Text(data),
  error: (msg) => Text('Error: $msg'),
  loading: () => CircularProgressIndicator(),
);
```

### JSON対応（Infrastructure層）

```dart
@freezed
sealed class PersonDto with _$PersonDto {
  const factory PersonDto({
    required String name,
    int? age,
  }) = _PersonDto;

  factory PersonDto.fromJson(Map<String, dynamic> json) =>
      _$PersonDtoFromJson(json);
}
```

### カスタムメソッド付き

```dart
@freezed
sealed class Rectangle with _$Rectangle {
  const Rectangle._();  // ← private constructor必須

  const factory Rectangle({
    required double width,
    required double height,
  }) = _Rectangle;

  // カスタムメソッド
  double get area => width * height;
  bool get isSquare => width == height;
}
```

## コード削減効果の試算

### Before（手動実装）

**VaccineReservationState例** - 約150行
- フィールド定義: 13個
- copyWith実装: 30行
- equals実装: 20行（_listEqualsヘルパー含む）
- hashCode実装: 3行
- toString実装: 10行

### After（freezed）

**VaccineReservationState例** - 約50行
- フィールド定義のみ
- その他自動生成

**削減率: 約67%**

## 検証項目

各Phase完了時:
- [ ] build_runner実行成功
- [ ] flutter analyze通過（エラー0件）
- [ ] 該当featureのテスト通過
- [ ] アプリ起動・動作確認

## リスクと対策

### リスク1: ビルド時間増加
- **現状**: riverpod_generatorのみ（11ファイル）
- **freezed導入後**: 60-70ファイルで生成が必要
- **対策**: watch modeで開発（`fvm dart run build_runner watch`）

### リスク2: 既存テストの破綻
- **対策**: 1ファイルずつ移行、都度テスト実行
- **ロールバック**: git checkout で即座に戻せる

### リスク3: チーム学習コスト
- **対策**: このドキュメント + 実装例の共有
- **学習リソース**: [freezed公式ドキュメント](https://pub.dev/packages/freezed)

## 参考リソース

- [freezed | Dart package](https://pub.dev/packages/freezed)
- [freezed changelog](https://pub.dev/packages/freezed/changelog)
- [freezed GitHub](https://github.com/rrousselGit/freezed)
- [Dart 3 migration guide](https://dart.dev/resources/dart-3-migration)

## 進捗管理

| Phase | 対象 | 進捗 | 完了日 |
|-------|------|------|--------|
| Phase 1 | Presentation層State | ✅ 15/15 | 2025-12-22 |
| Phase 2 | Domain Entities/Value Objects | ✅ 13/13 | 2025-12-24 |
| Phase 3 | Infrastructure層DTO | 🔄 1/10+ | - |
| Phase 4 | 対象外（手動維持） | - | - |

**凡例**: ✅ 完了 | 🔄 進行中 | ⏳ 未着手

## 更新履歴

- 2025-12-24: Phase 2完了（Domain Entities/Value Objectsをfreezed化、計13ファイル）
  - Entities: CalendarEvent, CalendarSettings, DoseRecord, ReservationGroup, VaccineReservationRequest, UpdateRequirement, HouseholdMember, ChildSummary, AdConfig
  - Value Objects: AppVersion, VaccinationPeriod, VaccinationRecommendation, InfluenzaSeasonSchedule
  - 主な変更点:
    - clearReservationGroupフラグ → clearReservationGroup()メソッドに変更（DoseRecord, VaccineReservationRequest）
    - factory → staticメソッドに変更（AdConfig）
    - isSameAs() → ==演算子に置換（ChildSummary）
    - Comparable<AppVersion>インターフェース実装を保持
- 2025-12-22: Phase 1完了（追加2ファイル: WidgetSettingsState, VaccineVisibilitySettingsState）
  - 計15ファイルのState/Paramsをfreezed化
- 2025-12-22: Phase 1完了（Presentation層State/Paramsをfreezed化、計13ファイル + Params）
  - ワクチン系: VaccineReservationState/Params, VaccineDetailState/Params, ConcurrentVaccinesState/Params
  - カレンダー系: CalendarState, CalendarSettingsState, Add/EditCalendarEventState
  - ママ記録系: MomRecordPageState, MomDiaryPageState
  - 子ども記録系: RecordPageState, GrowthChartState, EditableRecordSheetState/Args, ManageOtherTagsState
  - build_runnerで生成コードを更新
- 2025-12-22: 初版作成、Phase 1開始
  - freezed 3.2.3導入成功
  - sealed class必須の知見を確認
  - RecordPageState, MomDiaryDto移行完了
