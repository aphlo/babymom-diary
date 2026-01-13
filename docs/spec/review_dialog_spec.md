# レビュー促進ダイアログ 設計書

## 1. 概要

### 1.1 目的
ユーザーにアプリストア（App Store / Google Play）でのレビュー投稿を促し、アプリの評価向上と改善フィードバックの収集を行う。

### 1.2 機能概要
- 2段階のダイアログフロー（満足度確認 → レビュー誘導/お問い合わせ誘導）
- 記録操作回数とアプリ起動回数に基づいた表示条件
- 1日の表示回数制限とレビュー済みユーザーの除外

---

## 2. ダイアログフロー

### 2.1 第1段階：満足度確認ダイアログ

```
┌─────────────────────────────────────────────────┐
│                                                 │
│        miluに満足いただけていますか？            │
│                                                 │
│  ┌───────────────────┐  ┌───────────────────┐  │
│  │      満足 😊      │  │      不満 😢      │  │
│  └───────────────────┘  └───────────────────┘  │
│                                                 │
└─────────────────────────────────────────────────┘
```

#### ユーザー選択時の動作

| 選択 | 動作 |
|------|------|
| 満足 | 第2段階（レビュー誘導ダイアログ）を表示 |
| 不満 | 外部のお問い合わせページをブラウザで開く |
| ダイアログ外タップ/戻る | ダイアログを閉じる（次回表示条件まで表示しない） |

---

### 2.2 満足選択時：In-App Review表示

「満足」を選択した場合、`in_app_review` パッケージを使用してOS純正のIn-App Reviewダイアログを表示する。

```
┌─────────────────────────────────────────────────┐
│                                                 │
│                    [🐻]                         │  ← アプリアイコン（OS提供）
│                                                 │
│           "milu"を評価してください               │
│                                                 │
│           ★  ★  ★  ★  ★                       │  ← OS純正の星評価UI
│                                                 │
│  ───────────────────────────────────────────── │
│                                                 │
│      送信              今はしない                │
│                                                 │
└─────────────────────────────────────────────────┘
※ 上記はイメージ。実際のUIはOS（iOS/Android）が提供する純正ダイアログ
```

#### in_app_review パッケージの動作

| プラットフォーム | 動作 |
|-----------------|------|
| iOS | `SKStoreReviewController.requestReview()` を呼び出し、App Store純正のレビューダイアログを表示 |
| Android | Google Play In-App Review API を呼び出し、Play Store純正のレビューダイアログを表示 |

#### 注意事項

- **表示保証なし:** OS側の制限により、`requestReview()` を呼び出してもダイアログが表示されない場合がある（短期間に複数回呼び出した場合など）
- **コールバックなし:** ユーザーがレビューを送信したか、キャンセルしたかはアプリ側で検知できない
- **レビュー済みフラグ:** `requestReview()` を呼び出した時点でレビュー済みフラグをONにする（実際のレビュー送信有無に関わらず）

---

### 2.3 不満選択時：お問い合わせページ遷移

「不満」を選択した場合、外部ブラウザでお問い合わせページを開く。

**お問い合わせURL:** `https://babymom-diary.web.app/inquiry.html`

---

## 3. 表示条件

### 3.1 表示トリガー条件

以下のいずれかを満たした場合にダイアログを表示する：

| 条件 | 説明 |
|------|------|
| 条件A | 記録操作の累計が **3回目** に達した直後 |
| 条件B | アプリ起動回数が **3回以上** かつ、記録操作を **1回以上** 行った直後 |

#### 記録操作の対象

以下の操作を「記録操作」としてカウントする：

| 機能 | 対象操作 |
|------|---------|
| ベビーの記録（child_record） | 記録の追加・編集 |
| 予防接種（vaccines） | 予約の作成・接種完了記録・編集 |
| ママの記録（mom_record） | 記録の追加・編集 |
| 離乳食（baby_food） | 記録の追加・編集 |

**注意:** 削除操作はカウント対象外とする。

---

### 3.2 表示抑制条件

以下のいずれかに該当する場合、トリガー条件を満たしてもダイアログを表示しない：

| 条件 | 説明 |
|------|------|
| レビュー済み | ユーザーが過去に「レビューする」を選択した |
| 本日表示済み | 当日すでにダイアログを表示した（1日1回制限） |

---

### 3.3 条件判定フローチャート

```
記録操作が完了
    │
    ▼
┌─────────────────────────────┐
│ レビュー済みフラグがON？     │
└─────────────┬───────────────┘
              │
    ┌─────────┴─────────┐
    │Yes               │No
    ▼                  ▼
 終了          ┌─────────────────────────────┐
               │ 本日すでに表示済み？          │
               └─────────────┬───────────────┘
                             │
                   ┌─────────┴─────────┐
                   │Yes               │No
                   ▼                  ▼
                終了          ┌─────────────────────────────┐
                              │ 条件Aまたは条件Bを満たす？   │
                              └─────────────┬───────────────┘
                                            │
                                  ┌─────────┴─────────┐
                                  │Yes               │No
                                  ▼                  ▼
                           ダイアログ表示         終了
```

---

## 4. データ構造

### 4.1 ローカル永続化データ（SharedPreferences）

| キー | 型 | 説明 | デフォルト |
|------|-----|------|-----------|
| `review_record_count` | int | 記録操作の累計回数 | 0 |
| `review_app_launch_count` | int | アプリ起動回数 | 0 |
| `review_has_reviewed` | bool | レビュー済みフラグ | false |
| `review_last_shown_date` | String? | 最後にダイアログを表示した日付（ISO8601形式、日付のみ） | null |

**備考:** これらのデータは端末ローカルに保存し、Firestoreには保存しない（プライバシーとオフライン動作のため）。

---

### 4.2 ドメインエンティティ

```dart
/// レビュー促進の状態
@immutable
class ReviewPromptState {
  final int recordCount;
  final int appLaunchCount;
  final bool hasReviewed;
  final DateTime? lastShownDate;

  const ReviewPromptState({
    required this.recordCount,
    required this.appLaunchCount,
    required this.hasReviewed,
    this.lastShownDate,
  });

  /// ダイアログを表示すべきかどうか
  bool shouldShowDialog({required DateTime now}) {
    // レビュー済みなら表示しない
    if (hasReviewed) return false;

    // 本日すでに表示済みなら表示しない
    if (lastShownDate != null && _isSameDay(lastShownDate!, now)) {
      return false;
    }

    // 条件A: 記録回数が3回目に達した
    // 条件B: 起動3回以上 かつ 記録1回以上
    final conditionA = recordCount == 3;
    final conditionB = appLaunchCount >= 3 && recordCount >= 1;

    return conditionA || conditionB;
  }
}
```

---

## 5. アーキテクチャ

### 5.1 新規Feature構造

```
flutter/lib/src/features/review/
├── domain/
│   ├── entities/
│   │   └── review_prompt_state.dart      # 状態エンティティ
│   ├── repositories/
│   │   └── review_prompt_repository.dart # リポジトリインターフェース
│   └── services/
│       └── review_prompt_policy.dart     # 表示判定ロジック
├── application/
│   ├── usecases/
│   │   ├── check_review_prompt.dart      # 表示判定UseCase
│   │   ├── increment_record_count.dart   # 記録カウント増加UseCase
│   │   ├── increment_launch_count.dart   # 起動カウント増加UseCase
│   │   └── mark_as_reviewed.dart         # レビュー済みマークUseCase
│   └── providers/
│       └── review_providers.dart         # Riverpod Providers
├── infrastructure/
│   ├── repositories/
│   │   └── review_prompt_repository_impl.dart  # SharedPreferences実装
│   └── services/
│       └── in_app_review_service.dart    # in_app_reviewパッケージラッパー
└── presentation/
    ├── widgets/
    │   └── satisfaction_dialog.dart      # 満足度確認ダイアログ
    └── controllers/
        └── review_prompt_controller.dart # ダイアログ表示制御
```

---

### 5.2 既存コードへの統合ポイント

#### 5.2.1 記録操作時のカウント増加

各機能の記録追加/編集UseCaseで `IncrementRecordCount` を呼び出す。

```dart
// 例: AddChildRecordUseCase
class AddChildRecord {
  final ChildRecordRepository _repository;
  final IncrementRecordCount _incrementRecordCount;
  final CheckReviewPrompt _checkReviewPrompt;

  Future<void> call({...}) async {
    await _repository.addRecord(...);

    // レビュー促進カウントを増加
    await _incrementRecordCount.call();
  }
}
```

**統合対象UseCase:**
- `child_record`: `AddChildRecord`, `UpdateChildRecord`
- `vaccines`: `CreateVaccineReservation`, `UpdateVaccinationRecord`, `MarkDoseAsCompleted`
- `mom_record`: `AddMomRecord`, `UpdateMomRecord`
- `baby_food`: `AddBabyFoodRecord`, `UpdateBabyFoodRecord`

#### 5.2.2 アプリ起動時のカウント増加

`main_stg.dart` / `main_prod.dart` のアプリ初期化時に `IncrementLaunchCount` を呼び出す。

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ... 既存の初期化処理 ...

  // 起動回数をカウント
  final container = ProviderContainer();
  await container.read(incrementLaunchCountProvider).call();

  runApp(const MyApp());
}
```

#### 5.2.3 ダイアログ表示タイミング

記録操作完了後に `CheckReviewPrompt` を呼び出し、条件を満たす場合にダイアログを表示する。

```dart
// 記録追加後のコールバック内で
final shouldShow = await ref.read(checkReviewPromptProvider).call();
if (shouldShow) {
  await showSatisfactionDialog(context);
}
```

---

## 6. 使用パッケージ

| パッケージ | 用途 |
|-----------|------|
| [in_app_review](https://pub.dev/packages/in_app_review) | iOS/AndroidのOS純正In-App Reviewダイアログ表示 |
| [url_launcher](https://pub.dev/packages/url_launcher) | お問い合わせページへの遷移（既存使用） |
| [shared_preferences](https://pub.dev/packages/shared_preferences) | ローカルデータ永続化（既存使用） |

---

## 7. ユースケース

### 7.1 記録3回目でダイアログ表示

1. ユーザーがベビーの記録を追加（1回目）
2. ユーザーが予防接種の予約を作成（2回目）
3. ユーザーがママの記録を追加（3回目）
4. 3回目の記録完了直後、満足度確認ダイアログを表示
5. ユーザーが「満足」を選択
6. `in_app_review` でOS純正のIn-App Reviewダイアログを表示
7. ユーザーがレビューを送信（またはキャンセル）
8. レビュー済みフラグをON → 以降ダイアログは表示されない

### 7.2 起動3回以上 + 記録1回でダイアログ表示

1. ユーザーがアプリを起動（1回目）→ 記録せず終了
2. ユーザーがアプリを起動（2回目）→ 記録せず終了
3. ユーザーがアプリを起動（3回目）
4. ユーザーがベビーの記録を追加（1回目）
5. 記録完了直後、満足度確認ダイアログを表示

### 7.3 不満選択でお問い合わせページへ遷移

1. ダイアログ表示条件を満たし、満足度確認ダイアログを表示
2. ユーザーが「不満」を選択
3. 外部ブラウザでお問い合わせページを開く
4. 本日の表示済みフラグをON

### 7.4 1日2回目の記録でダイアログ非表示

1. ユーザーが記録を追加（条件を満たす）
2. 満足度確認ダイアログを表示
3. ユーザーが「あとで」を選択（または閉じる）
4. 本日の表示済み日付を記録
5. 同日中にユーザーが再度記録を追加
6. 本日すでに表示済みのためダイアログは表示されない

---

## 8. 条件A（3回目の記録）の詳細設計

### 8.1 「3回目」の判定タイミング

条件Aの「3回目に達した直後」は以下のように判定する：

```dart
/// 記録カウント増加前の値が2で、増加後に3になった場合のみtrue
bool isThirdRecord(int currentCount) {
  return currentCount == 2; // 増加前の値が2なら、増加後3回目
}
```

### 8.2 4回目以降の扱い

- 条件Aは「ちょうど3回目」のみ適用
- 4回目以降は条件Aではトリガーされない
- ただし条件Bは引き続き有効（3回以上起動 + 1回以上記録）

### 8.3 条件Bとの併用

- 条件Aと条件BはOR条件
- 起動3回未満でも、記録3回目ならダイアログ表示（条件A）
- 起動3回以上なら、記録1回目でもダイアログ表示（条件B）
- 両条件を満たす場合も1回のみ表示（表示済みフラグで制御）

---

## 9. エッジケース対応

### 9.1 アプリ再インストール時

- SharedPreferencesのデータがクリアされるため、カウントは0からリセット
- レビュー済みフラグもリセットされるため、再度ダイアログが表示される可能性あり
- これは許容する（再インストール後の再評価機会として）

### 9.2 日付変更時

- `review_last_shown_date` は日付のみで比較
- タイムゾーンはデバイスのローカルタイムゾーンを使用
- 日付が変わった時点で新たに1回表示可能

### 9.3 オフライン時

- SharedPreferencesはオフラインでも動作
- in_app_reviewはオフラインでは動作しない可能性があるが、パッケージ側でハンドリング

### 9.4 複数端末使用時

- データは端末ローカルに保存のため、端末ごとに独立
- 同一ユーザーが複数端末で使用する場合、各端末で個別にダイアログが表示される可能性あり
- これは許容する（Firestoreへの保存は過剰なため）

---

## 10. 設定値

### 10.1 閾値（将来変更可能性あり）

| 設定項目 | 値 | 説明 |
|---------|-----|------|
| 記録回数閾値 | 3 | 条件Aのトリガー記録回数 |
| 起動回数閾値 | 3 | 条件Bの起動回数条件 |
| 1日の表示上限 | 1 | 1日に表示できる最大回数 |

### 10.2 外部URL

| 項目 | URL |
|------|-----|
| お問い合わせページ | `https://babymom-diary.web.app/inquiry.html` |

---

## 11. テスト観点

### 11.1 ユニットテスト

| テスト対象 | テスト内容 |
|-----------|-----------|
| `ReviewPromptState.shouldShowDialog()` | 各条件の組み合わせでの表示判定 |
| `ReviewPromptPolicy` | 条件A/Bの判定ロジック |
| `IncrementRecordCount` | カウント増加と永続化 |

### 11.2 統合テスト

| テスト対象 | テスト内容 |
|-----------|-----------|
| ダイアログフロー | 満足→in_app_review呼び出し |
| ダイアログフロー | 不満→お問い合わせページ遷移 |
| 表示抑制 | レビュー済みユーザーへの非表示 |
| 表示抑制 | 同日2回目の非表示 |

---

## 12. 実装優先度

| 優先度 | 項目 |
|--------|------|
| P0 | 基盤実装（エンティティ、リポジトリ、UseCase） |
| P0 | 満足度確認ダイアログUI |
| P0 | レビュー誘導ダイアログUI |
| P0 | 記録操作フックの統合 |
| P1 | お問い合わせページ遷移 |
| P1 | アプリ起動カウント統合 |
| P2 | テスト実装 |

---

## 13. 変更履歴

| 日付 | バージョン | 変更内容 |
|------|-----------|---------|
| 2025-01-13 | 1.0 | 初版作成 |
| 2025-01-13 | 1.1 | 満足選択時の動作を `in_app_review` パッケージによるOS純正In-App Reviewダイアログ表示に変更。カスタムのレビュー誘導ダイアログは廃止。 |
