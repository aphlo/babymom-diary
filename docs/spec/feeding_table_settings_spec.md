# 授乳表設定機能 設計書

## 1. 概要

授乳表（FeedingTable）で表示する列をユーザーがカスタマイズできる設定機能を追加する。

### 1.1 目的

- ユーザーが使用しない記録タイプの列を非表示にし、授乳表をシンプルにする
- 列の表示順序をユーザーの好みに合わせてカスタマイズできる
- ホームウィジェットのクイックアクションと連動し、非表示の記録タイプは非活性にする

### 1.2 対象画面

| 画面 | 変更内容 |
|------|----------|
| メニュー画面 | 「授乳表の設定」メニュー項目を追加 |
| 授乳表設定画面 | 新規作成 |
| 授乳表（FeedingTableTab） | 設定に応じて動的に列を表示 |
| ホームウィジェット | 非表示RecordTypeのクイックアクションを非活性化 |

---

## 2. 機能要件

### 2.1 授乳表設定画面

#### 2.1.1 表示項目

以下の記録カテゴリの表示/非表示と順序を設定できる：

| カテゴリ | RecordType | デフォルト表示 | 順序 |
|----------|------------|----------------|------|
| 授乳 | breastRight, breastLeft | ON | 1 |
| ミルク | formula | ON | 2 |
| 搾母乳 | pump | ON | 3 |
| 離乳食 | babyFood | ON | 4 |
| 尿 | pee | ON | 5 |
| 便 | poop | ON | 6 |
| 体温 | temperature | ON | 7 |
| その他 | other | ON | 8 |

#### 2.1.2 操作

- **表示/非表示切り替え**: 各カテゴリのトグルスイッチで切り替え
- **順序変更**: ドラッグ&ドロップで順序を変更
- **最低1つ**: 少なくとも1つのカテゴリは表示状態を維持する

#### 2.1.3 制約

- 「時間」列は常に先頭に固定（設定対象外）
- 設定は端末ローカル（SharedPreferences）に保存される（世帯共有ではない）

### 2.2 授乳表の動的列表示

- 設定で非表示にしたカテゴリの列を授乳表から除外
- 設定した順序で列を表示
- 合計行も設定に応じて動的に変更

### 2.3 ホームウィジェット連動

- 授乳表設定で非表示にしたRecordTypeがクイックアクションに設定されている場合：
  - iOS: ボタンをグレーアウトし、タップ不可にする
  - Android: 同様にグレーアウトし、タップ不可にする
- ウィジェット設定画面でも非表示のRecordTypeは選択不可にする

---

## 3. データ構造

### 3.1 Domain Entity

```dart
// flutter/lib/src/features/feeding_table_settings/domain/entities/feeding_table_settings.dart

@freezed
class FeedingTableSettings with _$FeedingTableSettings {
  const factory FeedingTableSettings({
    /// 表示するカテゴリの順序付きリスト
    /// リストに含まれるカテゴリのみ表示される
    @Default([
      FeedingTableCategory.nursing,
      FeedingTableCategory.formula,
      FeedingTableCategory.pump,
      FeedingTableCategory.babyFood,
      FeedingTableCategory.pee,
      FeedingTableCategory.poop,
      FeedingTableCategory.temperature,
      FeedingTableCategory.other,
    ])
    List<FeedingTableCategory> visibleCategories,
  }) = _FeedingTableSettings;

  factory FeedingTableSettings.fromJson(Map<String, dynamic> json) =>
      _$FeedingTableSettingsFromJson(json);
}

/// 授乳表のカテゴリ（列）
enum FeedingTableCategory {
  nursing,     // 授乳（breastRight + breastLeft）
  formula,     // ミルク
  pump,        // 搾母乳
  babyFood,    // 離乳食
  pee,         // 尿
  poop,        // 便
  temperature, // 体温
  other,       // その他
}

extension FeedingTableCategoryX on FeedingTableCategory {
  String get label {
    switch (this) {
      case FeedingTableCategory.nursing:
        return '授乳';
      case FeedingTableCategory.formula:
        return 'ミルク';
      case FeedingTableCategory.pump:
        return '搾母乳';
      case FeedingTableCategory.babyFood:
        return '離乳食';
      case FeedingTableCategory.pee:
        return '尿';
      case FeedingTableCategory.poop:
        return '便';
      case FeedingTableCategory.temperature:
        return '体温';
      case FeedingTableCategory.other:
        return 'その他';
    }
  }

  /// このカテゴリに対応するRecordType一覧
  List<RecordType> get recordTypes {
    switch (this) {
      case FeedingTableCategory.nursing:
        return [RecordType.breastRight, RecordType.breastLeft];
      case FeedingTableCategory.formula:
        return [RecordType.formula];
      case FeedingTableCategory.pump:
        return [RecordType.pump];
      case FeedingTableCategory.babyFood:
        return [RecordType.babyFood];
      case FeedingTableCategory.pee:
        return [RecordType.pee];
      case FeedingTableCategory.poop:
        return [RecordType.poop];
      case FeedingTableCategory.temperature:
        return [RecordType.temperature];
      case FeedingTableCategory.other:
        return [RecordType.other];
    }
  }

  /// RecordTypeからカテゴリを取得
  static FeedingTableCategory? fromRecordType(RecordType type) {
    switch (type) {
      case RecordType.breastRight:
      case RecordType.breastLeft:
        return FeedingTableCategory.nursing;
      case RecordType.formula:
        return FeedingTableCategory.formula;
      case RecordType.pump:
        return FeedingTableCategory.pump;
      case RecordType.babyFood:
        return FeedingTableCategory.babyFood;
      case RecordType.pee:
        return FeedingTableCategory.pee;
      case RecordType.poop:
        return FeedingTableCategory.poop;
      case RecordType.temperature:
        return FeedingTableCategory.temperature;
      case RecordType.other:
        return FeedingTableCategory.other;
    }
  }
}
```

### 3.2 ローカルストレージ（SharedPreferences）

```
Key: "feeding_table_visible_categories"
Value: ["nursing", "formula", "pump", "babyFood", "pee", "poop", "temperature", "other"]
```

※ JSON配列として保存。VaccineSettingsRepositoryImplと同様のパターン。

---

## 4. アーキテクチャ

### 4.1 ディレクトリ構造

```
flutter/lib/src/features/
├── feeding_table_settings/
│   ├── domain/
│   │   ├── entities/
│   │   │   └── feeding_table_settings.dart
│   │   │   └── feeding_table_settings.freezed.dart
│   │   └── repositories/
│   │       └── feeding_table_settings_repository.dart
│   ├── infrastructure/
│   │   └── repositories/
│   │       └── feeding_table_settings_repository_impl.dart
│   │       └── feeding_table_settings_repository_impl.g.dart
│   ├── application/
│   │   └── providers/
│   │       └── feeding_table_settings_providers.dart
│   │       └── feeding_table_settings_providers.g.dart
│   └── presentation/
│       ├── pages/
│       │   └── feeding_table_settings_page.dart
│       ├── viewmodels/
│       │   └── feeding_table_settings_view_model.dart
│       │   └── feeding_table_settings_view_model.g.dart
│       │   └── feeding_table_settings_state.dart
│       │   └── feeding_table_settings_state.freezed.dart
│       └── widgets/
│           └── category_toggle_list.dart
│
├── menu/
│   └── feeding_table_settings/  # メニューからの画面遷移用（既存パターンに合わせる場合）
│       └── ...
```

### 4.2 データフロー

```
┌─────────────────────────────────────────────────────────────────────┐
│                        Presentation Layer                           │
│  ┌────────────────────┐    ┌─────────────────────────────────────┐ │
│  │ FeedingTableSettings│    │ FeedingTableTab                     │ │
│  │ Page               │    │ (授乳表)                             │ │
│  └─────────┬──────────┘    └─────────────────┬───────────────────┘ │
│            │                                  │                     │
│            ▼                                  ▼                     │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │              FeedingTableSettingsViewModel                   │   │
│  │              (StateNotifier)                                 │   │
│  └─────────────────────────────┬───────────────────────────────┘   │
└────────────────────────────────┼───────────────────────────────────┘
                                 │
┌────────────────────────────────┼───────────────────────────────────┐
│                        Application Layer                            │
│                                ▼                                    │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │         feedingTableSettingsStreamProvider                   │   │
│  │         (Stream<FeedingTableSettings>)                       │   │
│  └─────────────────────────────┬───────────────────────────────┘   │
└────────────────────────────────┼───────────────────────────────────┘
                                 │
┌────────────────────────────────┼───────────────────────────────────┐
│                      Infrastructure Layer                           │
│                                ▼                                    │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │         FeedingTableSettingsRepositoryImpl                   │   │
│  │         (SharedPreferences)                                  │   │
│  └─────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘
```

### 4.3 ホームウィジェット連動

```
┌─────────────────────────────────────────────────────────────────────┐
│                     Widget Data Sync Flow                           │
│                                                                     │
│  FeedingTableSettings ──┐                                           │
│                         ├──► WidgetDataRepository ──► SharedPrefs   │
│  WidgetSettings ────────┘         │                      │          │
│                                   │                      ▼          │
│                                   │              ┌──────────────┐   │
│                                   │              │ App Groups   │   │
│                                   │              │ (iOS)        │   │
│                                   │              └──────┬───────┘   │
│                                   │                     │           │
│                                   ▼                     ▼           │
│                          ┌──────────────────────────────────────┐   │
│                          │         Native Widget                │   │
│                          │   (Disabled Quick Actions)           │   │
│                          └──────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 5. UI設計

### 5.1 授乳表設定画面

```
┌─────────────────────────────────────┐
│ ←  授乳表の設定                      │
├─────────────────────────────────────┤
│                                     │
│  表示する項目を選択してください       │
│  ドラッグして順序を変更できます       │
│  ※ 最低1つの項目を表示する必要があります │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ ☰  授乳           [ON/OFF] │   │
│  ├─────────────────────────────┤   │
│  │ ☰  ミルク          [ON/OFF] │   │
│  ├─────────────────────────────┤   │
│  │ ☰  搾母乳          [ON/OFF] │   │
│  ├─────────────────────────────┤   │
│  │ ☰  離乳食          [ON/OFF] │   │
│  ├─────────────────────────────┤   │
│  │ ☰  尿             [ON/OFF] │   │
│  ├─────────────────────────────┤   │
│  │ ☰  便             [ON/OFF] │   │
│  ├─────────────────────────────┤   │
│  │ ☰  体温            [ON/OFF] │   │
│  ├─────────────────────────────┤   │
│  │ ☰  その他          [ON/OFF] │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │         バナー広告           │   │
│  └─────────────────────────────┘   │
└─────────────────────────────────────┘
```

### 5.2 メニュー画面への追加

```dart
// 「離乳食の食材管理」の下に追加
ListTile(
  leading: const Icon(Icons.table_chart_outlined),
  title: const Text('授乳表の設定'),
  subtitle: const Text('表示する列のカスタマイズ'),
  onTap: () => context.push('/feeding-table/settings'),
  trailing: const Icon(Icons.chevron_right),
),
```

### 5.3 授乳表の動的列表示

現在のRecordTableを以下のように変更：

```dart
// Before: ハードコードされた列
static const List<String> _headers = [
  '時間', '授乳', 'ミルク', '搾母乳', '離乳食', '尿', '便', '体温', 'その他',
];

// After: 設定から動的に生成
List<String> get _headers {
  return [
    '時間',
    ...settings.visibleCategories.map((c) => c.label),
  ];
}
```

---

## 6. 実装計画

### Phase 1: 基盤実装

1. **Domain層**
   - `FeedingTableSettings` entity作成
   - `FeedingTableCategory` enum作成
   - `FeedingTableSettingsRepository` interface作成

2. **Infrastructure層**
   - `FeedingTableSettingsRepositoryImpl` 実装（SharedPreferences）

3. **Application層**
   - `feedingTableSettingsStreamProvider` 作成

### Phase 2: 設定画面実装

4. **Presentation層**
   - `FeedingTableSettingsPage` 作成
   - `FeedingTableSettingsViewModel` 作成
   - ドラッグ&ドロップ対応のリストUI実装

5. **Router追加**
   - `/feeding-table/settings` ルート追加

6. **メニュー画面**
   - メニュー項目追加

### Phase 3: 授乳表の動的化

7. **RecordTable修正**
   - 設定をwatchして動的に列を生成
   - ヘッダー、セル、合計行を動的に変更

### Phase 4: テスト・仕上げ

8. **テスト追加**
    - Repository単体テスト
    - ViewModel単体テスト

9. **バナー広告追加**
    - `BannerAdSlot.feedingTableSettings` 追加
    - 設定画面にバナー配置

---

## 7. 関連ファイル

### 変更対象ファイル

| ファイル | 変更内容 |
|----------|----------|
| `record_table.dart` | 動的列表示対応 |
| `feeding_table_tab.dart` | 設定プロバイダーのwatch追加 |
| `menu_page.dart` | メニュー項目追加 |
| `app_router.dart` | ルート追加 |
| `banner_ad_manager.dart` | 新規スロット追加 |

### 新規作成ファイル

- `flutter/lib/src/features/feeding_table_settings/` 配下全て

---

## 8. 補足

### 8.1 既存パターンとの整合性

- `widget_settings` の実装パターンを参考にする
- `vaccine_settings` のSharedPreferences保存パターンを参考にする
- `CategorySelectorSection` ウィジェットを再利用可能であれば活用

### 8.2 マイグレーション

- 既存ユーザーは設定がない状態から開始
- デフォルト値で全カテゴリ表示（既存動作と同じ）
- 破壊的変更なし

### 8.3 パフォーマンス考慮

- 設定はSharedPreferencesに保存（ネットワーク通信不要）
- 起動時に即座に読み込み可能
- ウィジェット更新は設定変更時のみ
