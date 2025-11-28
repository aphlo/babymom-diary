import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/calendar_event.dart';

class CalendarEventFirestoreDataSource {
  CalendarEventFirestoreDataSource(this._firestore);

  final FirebaseFirestore _firestore;
  final _uuid = const Uuid();

  /// 月間イベントを一度だけ取得（リアルタイム更新なし）
  Future<List<CalendarEvent>> getEvents({
    required String householdId,
    required DateTime start,
    required DateTime end,
  }) async {
    final startDate = DateTime(start.year, start.month, start.day);
    final endDate = DateTime(end.year, end.month, end.day);

    final dateKeys = <String>[];
    var currentDate = startDate;
    while (!currentDate.isAfter(endDate)) {
      dateKeys.add(DateFormat('yyyy-MM-dd').format(currentDate));
      currentDate = currentDate.add(const Duration(days: 1));
    }

    if (dateKeys.isEmpty) {
      return <CalendarEvent>[];
    }

    final allEvents = <CalendarEvent>[];

    // バッチで取得（Firestoreの制限を考慮して10件ずつ）
    const batchSize = 10;
    for (var i = 0; i < dateKeys.length; i += batchSize) {
      final batchKeys = dateKeys.skip(i).take(batchSize).toList();
      final futures = batchKeys.map((dateKey) {
        return _firestore
            .collection('households')
            .doc(householdId)
            .collection('events')
            .doc(dateKey)
            .get();
      });

      final snapshots = await Future.wait(futures);
      for (final doc in snapshots) {
        allEvents.addAll(_extractEventsFromDoc(doc));
      }
    }

    // 重複を除去してソート
    final uniqueEvents = <String, CalendarEvent>{};
    for (final event in allEvents) {
      uniqueEvents[event.id] = event;
    }
    return uniqueEvents.values.toList()
      ..sort((a, b) => a.start.compareTo(b.start));
  }

  /// 特定の日付のイベントをリアルタイムで監視
  Stream<List<CalendarEvent>> watchEventsForDate({
    required String householdId,
    required DateTime date,
  }) {
    final dateKey = DateFormat('yyyy-MM-dd').format(date);
    return _firestore
        .collection('households')
        .doc(householdId)
        .collection('events')
        .doc(dateKey)
        .snapshots()
        .map((doc) => _extractEventsFromDoc(doc));
  }

  Future<void> createEvent({
    required String householdId,
    required String title,
    required String memo,
    required bool allDay,
    required DateTime start,
    required DateTime end,
    required String iconKey,
  }) async {
    try {
      final nowUtc = DateTime.now().toUtc();
      final startUtc = start.toUtc();
      final endUtc = end.toUtc();
      final eventId = _uuid.v4();

      final dateKey = DateFormat('yyyy-MM-dd').format(start.toLocal());

      final docRef = _firestore
          .collection('households')
          .doc(householdId)
          .collection('events')
          .doc(dateKey);

      final trimmedMemo = memo.trim();

      final eventData = <String, Object?>{
        'title': title,
        'memo': trimmedMemo.isEmpty ? null : trimmedMemo,
        'allDay': allDay,
        'startAt': Timestamp.fromDate(startUtc),
        'endAt': Timestamp.fromDate(endUtc),
        'iconKey': iconKey,
        'createdAt': Timestamp.fromDate(nowUtc),
        'updatedAt': Timestamp.fromDate(nowUtc),
      };

      eventData.removeWhere((_, value) => value == null);

      // リトライ機能付きでトランザクションを実行
      await _executeWithRetry(() async {
        await _firestore.runTransaction((transaction) async {
          final doc = await transaction.get(docRef);

          if (doc.exists) {
            // 既存のeventsマップに追加
            final currentData = doc.data() as Map<String, dynamic>;
            final events =
                Map<String, dynamic>.from(currentData['events'] ?? {});
            events[eventId] = eventData;

            transaction.update(docRef, {
              'events': events,
              'updatedAt': Timestamp.fromDate(nowUtc),
            });
          } else {
            // 新しいドキュメントを作成
            transaction.set(docRef, {
              'events': {eventId: eventData},
              'createdAt': Timestamp.fromDate(nowUtc),
              'updatedAt': Timestamp.fromDate(nowUtc),
            });
          }
        });
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateEvent({
    required String eventId,
    required String householdId,
    required String title,
    required String memo,
    required bool allDay,
    required DateTime start,
    required DateTime end,
    required String iconKey,
  }) async {
    try {
      final nowUtc = DateTime.now().toUtc();
      final startUtc = start.toUtc();
      final endUtc = end.toUtc();

      final dateKey = DateFormat('yyyy-MM-dd').format(start.toLocal());

      final docRef = _firestore
          .collection('households')
          .doc(householdId)
          .collection('events')
          .doc(dateKey);

      final trimmedMemo = memo.trim();

      final eventData = <String, Object?>{
        'title': title,
        'memo': trimmedMemo.isEmpty ? null : trimmedMemo,
        'allDay': allDay,
        'startAt': Timestamp.fromDate(startUtc),
        'endAt': Timestamp.fromDate(endUtc),
        'iconKey': iconKey,
        'updatedAt': Timestamp.fromDate(nowUtc),
      };

      eventData.removeWhere((_, value) => value == null);

      await _executeWithRetry(() async {
        await _firestore.runTransaction((transaction) async {
          final doc = await transaction.get(docRef);

          if (doc.exists) {
            final currentData = doc.data() as Map<String, dynamic>;
            final events =
                Map<String, dynamic>.from(currentData['events'] ?? {});

            if (events.containsKey(eventId)) {
              events[eventId] = eventData;
              transaction.update(docRef, {
                'events': events,
                'updatedAt': Timestamp.fromDate(nowUtc),
              });
            } else {
              throw Exception('Event not found: $eventId');
            }
          } else {
            throw Exception('Document not found for date: $dateKey');
          }
        });
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteEvent({
    required String eventId,
    required String householdId,
    required DateTime eventDate,
  }) async {
    try {
      final nowUtc = DateTime.now().toUtc();

      // イベントの開始日付から直接ドキュメントキーを生成
      final dateKey = DateFormat('yyyy-MM-dd').format(eventDate.toLocal());

      final docRef = _firestore
          .collection('households')
          .doc(householdId)
          .collection('events')
          .doc(dateKey);

      // トランザクションで削除実行
      await _executeWithRetry(() async {
        await _firestore.runTransaction((transaction) async {
          final doc = await transaction.get(docRef);

          if (!doc.exists) {
            throw Exception('Document not found for date: $dateKey');
          }

          final currentData = doc.data() as Map<String, dynamic>;
          final events = Map<String, dynamic>.from(currentData['events'] ?? {});

          if (!events.containsKey(eventId)) {
            throw Exception('Event not found: $eventId');
          }

          events.remove(eventId);

          if (events.isEmpty) {
            // イベントがなくなったらドキュメント自体を削除
            transaction.delete(docRef);
          } else {
            // 他のイベントが残っている場合は更新
            transaction.update(docRef, {
              'events': events,
              'updatedAt': Timestamp.fromDate(nowUtc),
            });
          }
        });
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<T> _executeWithRetry<T>(Future<T> Function() operation,
      {int maxRetries = 3}) async {
    int attempts = 0;
    while (attempts < maxRetries) {
      try {
        return await operation();
      } catch (error) {
        attempts++;
        if (attempts >= maxRetries) {
          rethrow;
        }
        // 指数バックオフで待機
        await Future.delayed(Duration(milliseconds: 100 * (1 << attempts)));
      }
    }
    throw Exception('Max retries exceeded');
  }

  List<CalendarEvent> _extractEventsFromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    if (!doc.exists) return [];

    final data = doc.data();
    if (data == null) return [];

    final eventsMap = data['events'] as Map<String, dynamic>? ?? {};

    return eventsMap.entries.map((entry) {
      final eventId = entry.key;
      final eventData = entry.value as Map<String, dynamic>;

      final startTs = eventData['startAt'] as Timestamp;
      final endTsRaw = eventData['endAt'];
      final endTs = endTsRaw is Timestamp ? endTsRaw : startTs;

      return CalendarEvent(
        id: eventId,
        title: eventData['title'] as String? ?? '',
        memo: (eventData['memo'] as String?)?.trim() ?? '',
        allDay: eventData['allDay'] as bool? ?? false,
        start: startTs.toDate().toLocal(),
        end: endTs.toDate().toLocal(),
        iconPath: eventData['iconKey'] as String? ?? '',
        householdId: doc.reference.parent.parent?.id,
      );
    }).toList();
  }
}
