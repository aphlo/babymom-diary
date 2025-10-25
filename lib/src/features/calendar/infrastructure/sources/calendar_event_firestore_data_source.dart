import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/calendar_event.dart';

class CalendarEventFirestoreDataSource {
  CalendarEventFirestoreDataSource(this._firestore);

  final FirebaseFirestore _firestore;
  final _uuid = const Uuid();

  Stream<List<CalendarEvent>> watchEvents({
    required String householdId,
    required DateTime start,
    required DateTime end,
  }) {
    // 日付範囲内のドキュメントを取得
    final startDate = DateTime(start.year, start.month, start.day);
    final endDate = DateTime(end.year, end.month, end.day);

    final dateKeys = <String>[];
    var currentDate = startDate;
    while (!currentDate.isAfter(endDate)) {
      dateKeys.add(DateFormat('yyyy-MM-dd').format(currentDate));
      currentDate = currentDate.add(const Duration(days: 1));
    }

    if (dateKeys.isEmpty) {
      return Stream.value(<CalendarEvent>[]);
    }

    // 各日付のドキュメントを監視
    final streams = dateKeys.map((dateKey) {
      return _firestore
          .collection('households')
          .doc(householdId)
          .collection('events')
          .doc(dateKey)
          .snapshots()
          .map((doc) => _extractEventsFromDoc(doc))
          .handleError((error) {
        // エラーが発生した場合は空のリストを返す
        return <CalendarEvent>[];
      });
    }).toList();

    // 単一ストリームの場合はそのまま返す
    if (streams.length == 1) {
      return streams.first;
    }

    // 複数のストリームを効率的に結合
    return Rx.combineLatestList(streams).map((eventLists) {
      final allEvents = eventLists.expand((events) => events).toList();
      // 重複を除去（同じIDのイベントが複数の日付にまたがる場合）
      final uniqueEvents = <String, CalendarEvent>{};
      for (final event in allEvents) {
        uniqueEvents[event.id] = event;
      }
      return uniqueEvents.values.toList()
        ..sort((a, b) => a.start.compareTo(b.start));
    }).distinct((prev, next) {
      if (prev.length != next.length) return false;
      final prevIds = prev.map((e) => e.id).toSet();
      final nextIds = next.map((e) => e.id).toSet();
      return prevIds.difference(nextIds).isEmpty &&
          nextIds.difference(prevIds).isEmpty;
    });
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
