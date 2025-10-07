## カレンダー機能設計書

### カレンダーのデータ構造
```
/households/{householdId}/children/{childId}/events/{eventId}
  - isAllDayEvent   : boolean     // 終日か否か
  - startAt         : Timestamp   // 予定開始（UTC推奨）
  - endAt           : Timestamp?  // 予定終了（任意）
  - dayKeyLocal     : "YYYY-MM-DD"  // 端末TZ（例: Asia/Tokyo）での“日”キー
  - monthKeyLocal   : "YYYY-MM"     // 月キー（一覧用のフィルタ・集計で有効）
  - childId         : string
  - householdId     : string       // collection group検索用に冗長保持
  - iconKey         : "feeding.breast" | "feeding.bottle" | ... // assets/iconsのファイル名
　- title           : string
  - note            : string?
  - createdAt       : Timestamp
  - updatedAt       : Timestamp
```

### ChatGPTからの実装案
了解です！「複数の子どもを1つのカレンダーで表示」×「月またぎをサクサク」にするための**月跨ぎキャッシュ戦略**を、Firestoreの推奨スキーマ前提で具体化します。Riverpod例で書きますが、Blocでも置き換えやすい構成です。

# 目的

* 月移動しても**再フェッチを最小化**。
* 「カレンダーの6×7グリッド」に合わせて**前後月の端日も含めて**一括取得。
* **スナップショット購読でリアルタイム更新**、画面外は購読停止してコスト最適化。
* オフラインでも**滑らかにスクロール**（永続キャッシュ＋楽観更新）。

---

# 可視範囲の定義（実用ライン）

1ヶ月表示でも、実際のグリッドは**最大6週×7日=42日**。
そのため「見えている月 M」の**可視範囲**は：

* `visibleStart = firstDayOfMonth(M) - (weekdayIndexOf(firstDay) days)`
* `visibleEnd   = nextMonth(M).firstDay + (6*7 - 1) days`
  （※週起点はアプリ設定に合わせる。例：月曜始まり）

> これにより**前月末/翌月頭**のセル分まで**1クエリでカバー**できます。

---

# 取得ウィンドウとプリフェッチ

* **メイン購読**：現在表示中の月 M の「可視範囲」を `startAt ∈ [visibleStartUTC, visibleEndUTC)` で `collectionGroup('events')` から購読。
* **プリフェッチ**：隣接月 `M-1, M+1` についても**1回だけ**フェッチ（購読はしない）し、**キャッシュにウォーム**。
* **スクロールで月が切り替わったら**：

  * 旧Mの購読を解除
  * 新Mの購読を開始（既にプリフェッチ済なら即描画、裏で差分同期）
  * さらにその隣接月を新たにプリフェッチ

---

# キャッシュ構造（メモリ）

```dart
/// キーは "yyyy-MM"（端末ローカルTZ）
typedef MonthKey = String;

class MonthCache {
  final DateTime visibleStartUtc;
  final DateTime visibleEndUtc;
  final Map<DateTime /*yyyy-mm-dd 00:00 local*/, List<Event>> byDayLocal;
  final DateTime lastTouched;
  final StreamSubscription<QuerySnapshot<Event>>? liveSub; // 表示中のみ非null
  MonthCache({
    required this.visibleStartUtc,
    required this.visibleEndUtc,
    required this.byDayLocal,
    required this.lastTouched,
    this.liveSub,
  });

  MonthCache copyWith({ ... });
}

class CalendarCacheState {
  final Map<MonthKey, MonthCache> months; // LRUで間引き
  // 例: 最大保持 7ヶ月（前後3ヶ月＋当月）
}
```

* `byDayLocal`は**日付キー（ローカル 00:00固定）**に正規化すると、UI側で**そのまま描画**できて楽です。
* 端末TZ（例：Asia/Tokyo）で**日単位に丸めて**グループ化。保存はUTC、キーはローカル。

---

# Firestoreクエリ（購読/単発）

```dart
Query<Event> buildMonthQuery({
  required String familyId,
  required DateTime visibleStartUtc,
  required DateTime visibleEndUtc,
  List<String>? childIds, // 0〜10
}) {
  var q = FirebaseFirestore.instance
      .collectionGroup('events')
      .where('familyId', isEqualTo: familyId)
      .where('startAt', isGreaterThanOrEqualTo: Timestamp.fromDate(visibleStartUtc))
      .where('startAt', isLessThan: Timestamp.fromDate(visibleEndUtc))
      .orderBy('startAt'); // 範囲を使うので orderBy 必須

  if (childIds != null && childIds.isNotEmpty) {
    q = q.where('childId', whereIn: childIds.take(10).toList());
  }
  return q.withConverter(
    fromFirestore: (snap, _) => Event.fromJson(snap.data()!..['id']=snap.id),
    toFirestore: (e, _) => e.toJson(),
  );
}
```

* **表示中の月は `snapshots()` で購読**、隣接月は `get()` で単発。
* `whereIn`>10 になり得る場合は**子どもを分割**して複数クエリ→マージ。

---

# Riverpod実装イメージ（要点抜粋）

```dart
final calendarRepoProvider = Provider<CalendarRepository>((ref) {
  return CalendarRepository(ref.read);
});

class CalendarRepository {
  CalendarRepository(this._read);
  final Reader _read;

  final _cache = <MonthKey, MonthCache>{};
  static const _maxMonths = 7;

  // 表示月の購読開始
  Future<void> ensureLiveMonth({
    required String familyId,
    required DateTime monthLocal, // 例: 2025-10-01T00:00 local
    required List<String> childIds,
  }) async {
    final key = DateFormat('yyyy-MM').format(monthLocal);
    final range = _visibleRangeForMonth(monthLocal); // returns (startLocal, endLocal)
    final startUtc = range.start.toUtc();
    final endUtc   = range.end.toUtc();

    // 既存購読が同等レンジなら再利用
    final existing = _cache[key];
    if (existing != null &&
        existing.visibleStartUtc == startUtc &&
        existing.visibleEndUtc == endUtc &&
        existing.liveSub != null) {
      _touch(key);
      return;
    }

    // 古い購読を解除して再構築
    await existing?.liveSub?.cancel();

    final q = buildMonthQuery(
      familyId: familyId,
      visibleStartUtc: startUtc,
      visibleEndUtc: endUtc,
      childIds: childIds,
    );

    final sub = q.snapshots().listen((snap) {
      _applySnapshotToCache(
        key: key,
        startUtc: startUtc,
        endUtc: endUtc,
        docs: snap.docs.map((d)=>d.data()).toList(),
      );
    });

    _cache[key] = MonthCache(
      visibleStartUtc: startUtc,
      visibleEndUtc: endUtc,
      byDayLocal: existing?.byDayLocal ?? {},
      lastTouched: DateTime.now(),
      liveSub: sub,
    );

    _evictIfNeeded();
    // 隣接月をプリフェッチ
    _prefetchNeighbors(familyId, monthLocal, childIds);
  }

  // 隣接月プリフェッチ（単発取得、購読なし）
  Future<void> _prefetchNeighbors(String familyId, DateTime monthLocal, List<String> childIds) async {
    for (final neighbor in [monthLocal.add(const Duration(days: -1)), monthLocal.add(const Duration(days: 35))]) {
      final key = DateFormat('yyyy-MM').format(DateTime(neighbor.year, neighbor.month));
      if (_cache.containsKey(key)) continue;

      final range = _visibleRangeForMonth(DateTime(neighbor.year, neighbor.month));
      final q = buildMonthQuery(
        familyId: familyId,
        visibleStartUtc: range.start.toUtc(),
        visibleEndUtc: range.end.toUtc(),
        childIds: childIds,
      );
      final snap = await q.get();

      _applySnapshotToCache(
        key: key,
        startUtc: range.start.toUtc(),
        endUtc: range.end.toUtc(),
        docs: snap.docs.map((d)=>d.data()).toList(),
      );
      _evictIfNeeded();
    }
  }

  void _applySnapshotToCache({
    required MonthKey key,
    required DateTime startUtc,
    required DateTime endUtc,
    required List<Event> docs,
  }) {
    final grouped = <DateTime, List<Event>>{};
    for (final e in docs) {
      // startAt を 端末ローカルに変換 → 00:00 に正規化
      final local = e.startAt.toDate().toLocal();
      final dayLocal = DateTime(local.year, local.month, local.day);
      (grouped[dayLocal] ??= []).add(e);
    }
    _cache[key] = MonthCache(
      visibleStartUtc: startUtc,
      visibleEndUtc: endUtc,
      byDayLocal: grouped,
      lastTouched: DateTime.now(),
      liveSub: _cache[key]?.liveSub, // 購読は維持
    );
  }

  Map<DateTime, List<Event>>? getMonthDayMap(DateTime monthLocal) {
    final key = DateFormat('yyyy-MM').format(monthLocal);
    _touch(key);
    return _cache[key]?.byDayLocal;
  }

  Future<void> disposeMonth(DateTime monthLocal) async {
    final key = DateFormat('yyyy-MM').format(monthLocal);
    await _cache[key]?.liveSub?.cancel();
    _cache.remove(key);
  }

  void _touch(MonthKey key) {
    final c = _cache[key];
    if (c != null) {
      _cache[key] = c.copyWith(lastTouched: DateTime.now());
    }
  }

  void _evictIfNeeded() {
    if (_cache.length <= _maxMonths) return;
    // liveSubを持たない月から優先的にLRU削除
    final entries = _cache.entries.toList()
      ..sort((a, b) {
        final liveBias = ((a.value.liveSub==null)?0:1) - ((b.value.liveSub==null)?0:1);
        if (liveBias != 0) return liveBias; // 非購読→先に消す
        return a.value.lastTouched.compareTo(b.value.lastTouched);
      });
    final victim = entries.first.key;
    _cache[victim]?.liveSub?.cancel();
    _cache.remove(victim);
  }

  ({DateTime start, DateTime end}) _visibleRangeForMonth(DateTime monthLocal) {
    final first = DateTime(monthLocal.year, monthLocal.month, 1);
    final weekday = (first.weekday + 6) % 7; // 月曜=0 の例
    final start = first.subtract(Duration(days: weekday));
    final end = start.add(const Duration(days: 42)); // 半開区間
    return (start: start, end: end);
  }
}
```

> UI側は `repo.ensureLiveMonth(...)` を**ページ遷移/スクロール時**に呼び、`repo.getMonthDayMap(monthLocal)` を `ValueListenable/Riverpod`で購読して再描画するだけ。

---

# オフライン & Firestore側設定

* **永続キャッシュ**：起動時に一度だけ

  ```dart
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED, // または 100MB など
  );
  ```
* **スナップショットファースト描画**：購読開始時、ローカルキャッシュが即座に返る（`metadata.isFromCache == true`）。UIは**スケルトン→即描画→サーバ差分で更新**の流れに。
* **楽観更新**：イベント作成/更新時、`repo` の `byDayLocal` に反映→UI即時更新。サーバ確定後にスナップショットで整合。

---

# 書き込みとキャッシュ整合

* 追加/更新/削除時、**該当日のローカルマップを直接更新**（楽観）。
* `startAt`が別日に跨る更新（時間修正など）は

  1. 旧日キーから除去
  2. 新日キーへ追加
* 成功/失敗をトーストで通知。失敗時はキャッシュをロールバック（履歴を簡易保持すると安全）。

---

# インデックス確認（おさらい）

* `familyId + startAt`（COLLECTION_GROUP, ASC/ASC）：月可視範囲の範囲検索に必須
* 子絞り込みがある場合は**エラーメッセージに従って**追加（`childId`組み合わせ）。
* 日別詳細画面などでは `familyId + dayKeyLocal (+ childId)` の等価検索も高速。

---

# 追加最適化（必要に応じて）

* **日別サマリ（optional）**：`/families/{id}/dailyStats/{yyyy-mm-dd}` をCloud Functionsで非リアルタイム集計し、月表示は**サマリのみ購読**→セルの「アイコン/件数」を即描画、タップで詳細を**events**に切り替え。読み取りコストを大きく削減できます。
* **プリフェッチ幅**：高速端末・Wi-Fi時は `M-2, M+2` まで拡張（ネットワーク状況で切替）。
* **LRUのしきい値**：ユーザーの月移動頻度に応じて `7→5` or `9`に調整。
* **whereIn回避**：子ども数が多い家庭向けに、`/families/{id}/children/{childId}/events` を**子別に並列取得**してマージする実装をフォールバックとして用意。

---

# UI接続（超要約）

* カレンダー画面マウント時：`repo.ensureLiveMonth(familyId, currentMonth, selectedChildIds)`
* ページング/スワイプで月が変わるたびに同メソッドを呼ぶだけ。
* セル描画は `repo.getMonthDayMap(viewMonth)?[dayLocal] ?? []` でイベント一覧を取得し、前回いただいた**左上日付＋Wrapアイコン**に流し込めます。

---

必要なら、このリポジトリ層を**freezedモデル/withConverter**込みで雛形化、`AsyncNotifier`で**端末TZ注入**・**メタデータ（isFromCache）対応**・**エラーハンドリング**まで含めた実装テンプレを出します。どのフレーム（Riverpod/Bloc）で出しましょう？
