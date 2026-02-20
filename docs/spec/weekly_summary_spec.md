# 週間サマリーレポート機能 設計書

## 1. 概要

### 1.1 目的

日曜始まりの週単位で授乳表記録をカテゴリ別に集計し、折れ線グラフ・サマリー統計・日別値で視覚的にトレンドを確認できるようにする。週を切り替えて過去データも振り返り可能。

### 1.2 機能概要

- ベビーの記録画面（`RecordTablePage`）の子供バー右端の週間サマリーボタンをタップ
- フルスクリーンモーダルが表示される
- 日曜〜土曜の1週間を単位とし、カテゴリ別タブで集計データを表示
- カテゴリタブ: 折れ線グラフ + サマリーカード + 日別値
- 体温タブ: 折れ線グラフ（最新値） + 記録日数・平均体温 + 日別値
- 週ナビゲーションで前後の週に切り替え可能（今週より先には進めない）

### 1.3 対象画面

| 画面 | 変更内容 |
|------|----------|
| ベビーの記録画面（RecordTablePage） | ボタンの遷移先をフルスクリーンモーダルに変更 |
| 週間サマリーページ（WeeklySummaryPage） | 新規作成 |

---

## 2. 画面仕様

### 2.1 サマリーボタン配置

ベビーの記録画面のAppBar上部、子供名表示エリア（`AppBarChildInfo`）の右端にチャートアイコンを配置する（従来と同じ）。

### 2.2 フルスクリーンモーダル

`MaterialPageRoute(fullscreenDialog: true)` で表示。

```
┌─────────────────────────────────────────────┐
│  週間サマリー                           [✕]  │  ← AppBar
│  [＜]   2/9(日) 〜 2/15(土)   [＞]           │  ← 週ナビゲーション
├─────────────────────────────────────────────┤
│ [授乳] [ミルク] [搾母乳] [尿] [便] [体温]     │  ← スクロール可能タブ（中央寄せ）
╞═════════════════════════════════════════════╡
│                                             │
│  ── 通常カテゴリタブ選択時 ──                  │
│                                 [回数] [量]  │  ← ミルク・搾母乳のみ表示
│  ┌─────────────────────────────────────┐   │
│  │         折れ線グラフ (fl_chart)        │   │
│  │  8|       ●                         │   │
│  │  6|   ●       ●                     │   │
│  │  4| ●   ●       ●   ●              │   │
│  │  2|                   ●             │   │
│  │  0|___|___|___|___|___|___|___|     │   │
│  │   2/9 2/10 2/11 2/12 2/13 2/14 2/15│   │
│  └─────────────────────────────────────┘   │
│                                             │
│  ┌──────────────┬──────────────────────┐   │
│  │  合計  32回   │   日平均  4.6回/日    │   │
│  └──────────────┴──────────────────────┘   │
│                                             │
│  日  月  火  水  木  金  土                   │
│  4   5   8   6   3   4   2                  │  ← 日別値
│                                             │
├─────────────────────────────────────────────┤
│  ── 体温タブ選択時 ──                         │
│                                             │
│  ┌─────────────────────────────────────┐   │
│  │     折れ線グラフ（データ無し日はスキップ）   │   │
│  │ 38|                                 │   │
│  │ 37|   ●   ●       ●   ●           │   │
│  │ 36| ●           ●       ●         │   │
│  │ 35|                                 │   │
│  └─────────────────────────────────────┘   │
│  ※ 同日に複数の記録がある場合、最新の記録を     │
│    表示しています                             │
│                                             │
│  ┌──────────────┬──────────────────────┐   │
│  │ 記録日数 6/7日│  平均体温  36.5℃     │   │
│  └──────────────┴──────────────────────┘   │
│                                             │
│  日   月   火   水   木   金   土             │
│ 36.2 36.5 36.8  -  36.3 36.5 36.4          │  ← 日別値（体温）
│                                             │
└─────────────────────────────────────────────┘
```

### 2.3 週ナビゲーション

| 項目 | 仕様 |
|------|------|
| 前週ボタン | `Icons.chevron_left` - 常に有効 |
| 次週ボタン | `Icons.chevron_right` - 今週を含む週より先は無効（グレー表示） |
| 日付範囲表示 | `M/d(曜日)〜M/d(曜日)` 形式 |
| 週の定義 | 日曜始まり（日曜〜土曜） |

### 2.4 タブ構成

表示カテゴリは `feedingTableSettingsStreamProvider` に連動するが、「その他」と「離乳食」は常に非表示。

| タブ | 内容 |
|------|------|
| 授乳 | 折れ線グラフ + サマリーカード + 日別値 |
| ミルク | 同上（回数/量の切り替えトグルあり） |
| 搾母乳 | 同上（回数/量の切り替えトグルあり） |
| 尿 | 折れ線グラフ + サマリーカード + 日別値 |
| 便 | 同上 |
| 体温 | 折れ線グラフ（最新値） + 記録日数・平均体温 + 日別値 |

タブは `isScrollable: true`、`tabAlignment: TabAlignment.center` で中央寄せのスクロール可能タブ。各タブの幅は `SizedBox(width: 32)` で統一し、テキストが収まらない場合は `FittedBox(fit: BoxFit.scaleDown)` で縮小表示。

### 2.5 通常カテゴリタブの内容

1. **折れ線グラフ**（高さ200px）: fl_chartのLineChartで7日分のトレンドを表示
   - X軸: 0〜6（日〜土）、各日の日付ラベル（`M/d`）
   - Y軸: カテゴリに応じて回数 or ml
   - データポイントにドット表示 + 曲線でつなぐ
   - 下に塗りつぶし（`belowBarData`）でエリアチャート風
   - タッチでツールチップ表示
2. **回数/量切り替えトグル**（ミルク・搾母乳のみ）: `SegmentedButton` で回数/量を切り替え
3. **サマリーカード**: 横2列
   - 合計、日平均
4. **日別値**: 日〜土の各日の値を横並びで表示

### 2.6 体温タブの内容

1. **折れ線グラフ**（高さ200px）: 体温データのある日のみポイント表示
   - Y軸: 35〜39℃ を基本範囲、データに応じて自動調整
   - 下の塗りつぶしなし
   - データなしの日はグラフ上でスキップ（線がつながらない）
2. **注意文言**: 「※ 同日に複数の記録がある場合、最新の記録を表示しています」
3. **サマリーカード**: 横2列
   - 記録日数（n日 / 7日）、平均体温
4. **日別値**: 各日の最新体温を表示（データなしは「-」）

### 2.7 カテゴリ別チャート色

| カテゴリ | 色 | コード |
|----------|------|--------|
| 授乳 | ピンク | `AppColors.primary` (#E87086) |
| ミルク | ブルー | `AppColors.secondary` (#2196F3) |
| 搾母乳 | パープル | `Color(0xFF9C27B0)` |
| 尿 | オレンジ | `Color(0xFFFF9800)` |
| 便 | ブラウン | `Color(0xFF795548)` |
| 体温 | レッド | `Color(0xFFEF5350)` |

### 2.8 ローディング・エラー状態

| 状態 | 表示 |
|------|------|
| ローディング中 | `CircularProgressIndicator`（中央） |
| エラー | 「データの取得に失敗しました: {エラー内容}」（中央） |
| 子供未登録時 | SnackBar「記録を行うには、メニューから子どもを登録してください。」 |

### 2.9 ダークモード対応

- タブコンテンツの背景色をbottom navと同色にならないよう `Color(0xFF232127)` に設定
- カード類は `context.cardBackground` で自動対応

---

## 3. データ構造

### 3.1 クエリパラメータ

```dart
@immutable
class WeeklySummaryQuery {
  const WeeklySummaryQuery({
    required this.householdId,
    required this.childId,
    required this.weekStart,  // 週の開始日（日曜日）
  });
}
```

### 3.2 集計値モデル

```dart
@immutable
class CategoryDayValue {
  const CategoryDayValue({
    required this.count,             // 回数
    required this.totalAmount,       // 合計量（ml等）
    this.latestTemperature,          // 最新体温（体温カテゴリ用）
  });
  static const zero = CategoryDayValue(count: 0, totalAmount: 0);
}
```

### 3.3 日別サマリー

```dart
@immutable
class DaySummary {
  const DaySummary({
    required this.date,
    required this.values,  // Map<FeedingTableCategory, CategoryDayValue>
  });
}
```

### 3.4 週間サマリーデータ

```dart
@immutable
class WeeklySummaryData {
  const WeeklySummaryData({required this.days});
  final List<DaySummary> days;  // 7日分、日曜始まり

  /// 日曜始まりの週の開始日を計算
  static DateTime sundayStartOfWeek(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    final offset = normalized.weekday % 7; // 日=0, 月=1, …, 土=6
    return normalized.subtract(Duration(days: offset));
  }
}
```

### 3.5 ViewModel状態（freezed）

```dart
@freezed
sealed class WeeklySummaryState with _$WeeklySummaryState {
  const factory WeeklySummaryState({
    required DateTime weekStart,
  }) = _WeeklySummaryState;

  DateTime get weekEnd => weekStart.add(const Duration(days: 6));
  bool get canGoToNextWeek { ... }
  String get dateRangeLabel { ... }
}
```

---

## 4. データ取得・集計

### 4.1 データ取得フロー

```
openWeeklySummaryPage()
  ├── childContextProvider → householdId, childId
  ├── recordViewModelProvider → selectedDate → weekStart計算
  │
  └── WeeklySummaryPage
        ├── weeklySummaryViewModelProvider(initialDate) → 週切り替え管理
        └── weeklySummaryProvider(query)
              ├── RecordFirestoreDataSource.getForDay() × 7日
              ├── BabyFoodFirestoreDataSource.getForDay() × 7日
              └── Future.wait() で14リクエストを並列実行
```

### 4.2 集計ロジック

| カテゴリ | Record条件 | 値の算出 |
|----------|-----------|---------|
| nursing | `type == breastRight` + `type == breastLeft` | 件数の合算 |
| formula | `type == formula` | `amount` の合計（回数/量切り替え対応） |
| pump | `type == pump` | `amount` の合計（回数/量切り替え対応） |
| pee | `type == pee` | 件数 |
| poop | `type == poop` | 件数 |
| temperature | `type == temperature` | 最新の `amount` を `latestTemperature` に格納 |

---

## 5. アーキテクチャ

### 5.1 ファイル構成

```
flutter/lib/src/features/child_record/presentation/
├── models/
│   └── weekly_summary_model.dart              # データモデル（Query, CategoryDayValue, DaySummary, WeeklySummaryData）
├── providers/
│   ├── weekly_summary_provider.dart           # FutureProvider（データ取得・集計）
│   └── weekly_summary_provider.g.dart
├── viewmodels/weekly_summary/
│   ├── weekly_summary_state.dart              # freezed状態クラス
│   ├── weekly_summary_state.freezed.dart
│   ├── weekly_summary_view_model.dart         # 週切り替えViewModel
│   └── weekly_summary_view_model.g.dart
├── widgets/
│   ├── weekly_summary_chart.dart              # カテゴリ別折れ線グラフ + ChartDisplayMode + ヘルパー関数
│   ├── weekly_summary_category_tab.dart       # カテゴリ詳細タブ（通常 + 体温） + 回数/量切り替えトグル
│   └── weekly_summary_components.dart         # 共通UIパーツ（SummaryRow, ChartCard, CardContainer, DailyValues）
└── pages/
    ├── weekly_summary_page.dart               # フルスクリーンモーダルページ + 週ナビゲーション
    └── record_table_page.dart                 # ボタン（既存ファイル修正）
```

### 5.2 ファイル責務

| ファイル | 責務 |
|----------|------|
| `weekly_summary_page.dart` | ページ全体のレイアウト（Scaffold, AppBar, TabBar, 週ナビゲーション）、`openWeeklySummaryPage` ナビゲーションヘルパー |
| `weekly_summary_category_tab.dart` | カテゴリごとのタブコンテンツ。通常カテゴリと体温で表示を分岐。回数/量の切り替え状態を管理 |
| `weekly_summary_components.dart` | タブ内で使われる共通UIコンポーネント群（カード、サマリー行、日別値表示） |
| `weekly_summary_chart.dart` | fl_chartを使った折れ線グラフ、`ChartDisplayMode` enum、`categoryHasAmount` / `categoryColor` ヘルパー |

### 5.3 依存関係

```
record_table_page.dart
  └── weekly_summary_page.dart
        ├── weekly_summary_view_model.dart → 週切り替え状態管理
        ├── weekly_summary_provider.dart → データ取得
        │     ├── RecordFirestoreDataSource
        │     ├── BabyFoodFirestoreDataSource
        │     └── weekly_summary_model.dart
        ├── weekly_summary_category_tab.dart → タブコンテンツ
        │     ├── weekly_summary_chart.dart → fl_chart LineChart
        │     └── weekly_summary_components.dart → 共通UIパーツ
        ├── feedingTableSettingsStreamProvider
        ├── childContextProvider
        └── recordViewModelProvider
```

---

## 6. ユースケース

### 6.1 週間サマリーを確認する

1. ベビーの記録画面を開く
2. 子供バー右端のチャートアイコンをタップ
3. フルスクリーンモーダルが開く（選択中の日付を含む週が表示される）
4. カテゴリ別タブで折れ線グラフ・サマリー統計を確認
5. ミルク・搾母乳タブでは回数/量の切り替えが可能

### 6.2 別の週のサマリーを確認する

1. 週ナビゲーションの `[<]` ボタンで前の週に切り替え
2. `[>]` ボタンで次の週に切り替え（今週より先は不可）
3. データが自動的に再取得される

### 6.3 子供未登録時の動作

1. 子供が未登録の状態でチャートアイコンをタップ
2. SnackBar「記録を行うには、メニューから子どもを登録してください。」が表示される
3. モーダルは表示されない

---

## 7. 制約事項

### 7.1 パフォーマンス

- 7日分のデータ取得に14回のFirestoreリクエストが必要（通常レコード7回 + 離乳食レコード7回）
- `Future.wait()` による並列実行で遅延を最小化
- `@riverpod` FutureProviderによるキャッシュで同一クエリの再取得を防止

### 7.2 データの鮮度

- FutureProvider（ストリームではない）のため、表示時点のスナップショット
- 週を切り替えると新しいクエリで再取得される

### 7.3 タブの表示対象外

- `FeedingTableCategory.other`（その他）: 集計に適さないため非表示
- `FeedingTableCategory.babyFood`（離乳食）: 非表示

---

## 8. 変更履歴

| 日付 | バージョン | 変更内容 |
|------|-----------|---------|
| 2026-02-19 | 1.0 | 初版作成（ボトムシート版） |
| 2026-02-19 | 2.0 | フルスクリーンモーダル + タブ + 折れ線グラフにリデザイン |
| 2026-02-20 | 3.0 | 実装に合わせて更新: 一覧タブ削除、体温タブ追加、離乳食タブ非表示、回数/量切り替え追加、ダークモード対応、ファイル分割（page / category_tab / components） |
