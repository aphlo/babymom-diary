# ADR-002: iPad レイアウト最適化

## ステータス

承認済み (2026-01-18)

## コンテキスト

iPadでアプリを使用した際に以下の問題が発生している：

1. **バナー広告が表示されない**: `AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize()` がiPadの大画面幅で `null` を返すため、広告が表示されない
2. **授乳表の行が余る**: 行の高さが固定値（32px）のため、iPadの大画面では下部に余白ができる

### 課題

1. Anchored Adaptive Bannerは画面幅728dp以上で適切なサイズを計算できない場合がある
2. 授乳表の固定行高さはスマホ向けに最適化されており、大画面では視覚的に不自然
3. 既存のスマホユーザーへの影響を最小限にする必要がある

## 決定

### 1. バナー広告: フォールバックサイズの追加

Anchored Adaptive Bannerを維持しつつ、iPadなど大画面でnullが返される場合にフォールバックサイズを使用する。

**変更前:**
```dart
final adSize = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
  width.truncate(),
);
if (adSize == null) return; // iPadで広告が表示されない
```

**変更後:**
```dart
final adaptiveSize = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
  width.truncate(),
);

final AdSize adSize;
if (adaptiveSize == null) {
  // iPadなど大画面でnullが返される場合のフォールバック
  if (width >= 728) {
    adSize = AdSize.leaderboard; // 728x90
  } else if (width >= 468) {
    adSize = AdSize.fullBanner; // 468x60
  } else {
    adSize = AdSize.banner; // 320x50
  }
} else {
  adSize = adaptiveSize;
}
```

**理由:**
- スマホでは従来通りAnchored Adaptive Bannerを使用（変更なし）
- iPadでnullが返される場合のみフォールバックサイズを使用
- 幅に応じて適切なサイズを選択（728x90, 468x60, 320x50）

### 2. 授乳表: 行の高さを動的に計算

固定高さから、画面サイズに応じた動的高さに変更する。

**計算式:**
```dart
final availableHeight = 利用可能な高さ - ヘッダー高さ(44) - 合計行高さ(32);
final dynamicRowHeight = max(32.0, availableHeight / 24);
```

**理由:**
- 最小高さ32pxを保証することでスマホでの表示を維持
- iPadでは `availableHeight / 24 > 32` となり、行が拡張されて余白が埋まる
- タップ領域も大きくなりiPadでの操作性が向上

### スマホへの影響分析

| 機能 | スマホでの影響 | 理由 |
|------|--------------|------|
| バナー広告 | なし | スマホではAnchored Adaptive Bannerが従来通り動作、フォールバックは使用されない |
| 授乳表 | なし | `max(32.0, x)` により32px未満にならない |

**具体的な計算例:**

| デバイス | 利用可能高さ | 計算結果 | 適用される高さ |
|---------|------------|---------|--------------|
| iPhone SE | ~500px | (500-76)/24 = 17.7 | 32px (min) |
| iPhone 15 | ~600px | (600-76)/24 = 21.8 | 32px (min) |
| iPad | ~900px | (900-76)/24 = 34.3 | 34.3px |
| iPad Pro | ~1000px | (1000-76)/24 = 38.5 | 38.5px |

## 代替案

### 代替案1: Inline Adaptive Bannerの使用

`AdSize.getInlineAdaptiveBannerAdSize()` を使用する方式。

**却下理由:**
- `getInlineAdaptiveBannerAdSize`は初期状態で高さ0を返す
- 広告ロード後に実際の高さが決まる仕様のため、固定配置では表示されない
- スクロール可能なコンテンツ内での使用を想定した設計

### 代替案2: 画面幅を制限してAnchored Adaptive Bannerを継続

iPadでも `min(screenWidth, 728)` で幅を制限して従来のAPIを使用する方式。

**却下理由:**
- 広告の幅がiPadの画面幅に対して小さくなる
- ユーザー体験が不自然

### 代替案3: iPadでのみ広告を非表示

デバイス判定でiPadの場合は広告を表示しない方式。

**却下理由:**
- 広告収益の機会損失
- iPadユーザーへの差別的な体験

### 代替案4: 授乳表を30分刻み（48行）にする

大画面では時間をより細かく表示する方式。

**却下理由:**
- 仕様変更が大きい
- 既存データとの整合性が複雑

### 代替案5: 余白を活かして統計情報を表示

下部の余白に日毎のサマリーや統計を表示する方式。

**却下理由:**
- 設計・実装コストが大きい
- 本質的な解決ではない

## 実装詳細

### 変更ファイル

| ファイル | 変更内容 |
|---------|---------|
| `lib/src/features/ads/application/services/banner_ad_manager.dart` | Inline Adaptive Bannerへ変更 |
| `lib/src/features/child_record/presentation/widgets/record_table.dart` | 行の高さを動的計算に変更 |

### テスト観点

1. **バナー広告**
   - スマホで広告が従来通り表示されること
   - iPadで広告が表示されること（従来は非表示だった）

2. **授乳表**
   - スマホで行の高さが32pxのままであること
   - iPadで行の高さが拡張され余白がなくなること
   - スクロール動作が正常であること

## 結果

- iPadでバナー広告が表示されるようになる
- iPadで授乳表の余白がなくなり、視覚的に自然な表示になる
- スマホユーザーへの影響なし
- タップ領域の拡大によりiPadでの操作性が向上
