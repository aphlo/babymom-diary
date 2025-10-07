import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/calendar_event.dart';

class CalendarEventFirestoreDataSource {
  CalendarEventFirestoreDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<List<CalendarEvent>> watchEvents({
    required String householdId,
    required DateTime start,
    required DateTime end,
  }) {
    final startUtc = start.toUtc();
    final endUtc = end.toUtc();

    final query = _firestore
        .collectionGroup('events')
        .where('householdId', isEqualTo: householdId)
        .where('startAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startUtc))
        .where('startAt', isLessThan: Timestamp.fromDate(endUtc))
        .orderBy('startAt');

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map(_toCalendarEvent).toList();
    });
  }

  Future<void> createEvent({
    required String householdId,
    required String childId,
    required String title,
    required String memo,
    required bool allDay,
    required DateTime start,
    required DateTime end,
    required String iconKey,
    String? childName,
    String? childColorHex,
  }) async {
    final nowUtc = DateTime.now().toUtc();
    final startUtc = start.toUtc();
    final endUtc = end.toUtc();

    final dayKeyLocal = DateFormat('yyyy-MM-dd').format(start.toLocal());
    final monthKeyLocal = DateFormat('yyyy-MM').format(start.toLocal());

    final doc = _firestore
        .collection('households')
        .doc(householdId)
        .collection('children')
        .doc(childId)
        .collection('events')
        .doc();

    final trimmedMemo = memo.trim();
    final trimmedChildName = childName?.trim();
    final colorHexNormalized = childColorHex?.trim();

    final payload = <String, Object?>{
      'title': title,
      'note': trimmedMemo.isEmpty ? null : trimmedMemo,
      'isAllDayEvent': allDay,
      'startAt': Timestamp.fromDate(startUtc),
      'endAt': Timestamp.fromDate(endUtc),
      'dayKeyLocal': dayKeyLocal,
      'monthKeyLocal': monthKeyLocal,
      'childId': childId,
      'householdId': householdId,
      'iconKey': iconKey,
      'createdAt': Timestamp.fromDate(nowUtc),
      'updatedAt': Timestamp.fromDate(nowUtc),
      'childName': trimmedChildName?.isEmpty == true ? null : trimmedChildName,
      'childColorHex':
          colorHexNormalized?.isEmpty == true ? null : colorHexNormalized,
    };

    payload.removeWhere((_, value) => value == null);

    await doc.set(payload);
  }

  CalendarEvent _toCalendarEvent(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    final startTs = data['startAt'] as Timestamp;
    final endTsRaw = data['endAt'];
    final endTs = endTsRaw is Timestamp ? endTsRaw : startTs;

    return CalendarEvent(
      id: doc.id,
      title: data['title'] as String? ?? '',
      memo: (data['note'] as String?)?.trim() ?? '',
      allDay: data['isAllDayEvent'] as bool? ?? false,
      start: startTs.toDate().toLocal(),
      end: endTs.toDate().toLocal(),
      iconPath: data['iconKey'] as String? ?? '',
      childId: data['childId'] as String? ?? '',
      householdId: data['householdId'] as String?,
      childName: data['childName'] as String?,
      childColorHex: data['childColorHex'] as String?,
    );
  }
}
