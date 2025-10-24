# Riverpod 実装方針

## 実装プラン
- 既存のプロバイダ構成を棚卸しし、`calendar_event_controller` や各ページ/ビューモデルのプロバイダ、そのスコープ・オーバーライド・依存関係・ライフサイクルを把握して、生成後のプロバイダが現在の挙動を再現できるようにする。
- `pubspec.yaml` に `riverpod_annotation` と `riverpod_generator`、および `build_runner` を追加してコード生成の前提条件を整えつつ、実行時には従来どおり `flutter_riverpod` を利用できるようにする。
- 手書きの `Provider` 定義をトップレベル関数やクラスへリファクタリングし、`@riverpod` アノテーションを付与してイミュータブルなビューモデル/状態オブジェクトを返すようにする。DDD の方針に従ってユースケース内でドメインロジックを完結させ、アノテーション付き関数で `BuildContext` へ依存しない。
- `AddCalendarEventPage`、`CalendarEventTile`、各ピッカーなどの利用側を更新し、生成されたプロバイダゲッター（`ref.watch(calendarEventControllerProvider)` など）を介して状態を取得する。Widget 層はビューモデル用のマッパーを使い、プレゼンテーション層の責務に留める。
- ドメイン層では `CalendarEvent` などのロジックをエンティティやユースケースに保持し、アノテーションはプレゼンテーション/アプリケーション層に限定して生成プロバイダがインフラ非依存であることを担保する。
- `dart run build_runner build --delete-conflicting-outputs` を実行してコード生成し、生成された `.g.dart` ファイルをコミット対象に含めつつ、手動編集しない運用を徹底する。

## 次のアクション
1. コード生成用依存関係を追加し、`build_runner` を実行できる状態にする。
2. 代表的なコントローラを 1 件 `@riverpod` 化してパターンを検証し、残りのプロバイダへ段階的に適用する。
