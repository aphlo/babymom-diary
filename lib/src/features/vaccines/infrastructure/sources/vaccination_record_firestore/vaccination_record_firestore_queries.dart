import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/vaccination_record.dart';
import '../../../domain/entities/vaccination_schedule.dart';
import '../../models/vaccination_record.dart';
import 'vaccination_record_firestore_context.dart';

class VaccinationRecordFirestoreQueries {
  const VaccinationRecordFirestoreQueries(this._ctx);

  final VaccinationRecordFirestoreContext _ctx;

  Stream<List<VaccinationRecord>> watchVaccinationRecords({
    required String householdId,
    required String childId,
  }) {
    final refs = _ctx.refs(householdId: householdId, childId: childId);
    return refs.vaccinationRecords.snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (doc) => VaccinationRecordDto.fromFirestore(
              doc.data(),
              docId: doc.id,
            ).toDomain(),
          )
          .toList();
    }).handleError((_) => <VaccinationRecord>[]);
  }

  Stream<VaccinationRecord?> watchVaccinationRecord({
    required String householdId,
    required String childId,
    required String vaccineId,
  }) {
    final refs = _ctx.refs(householdId: householdId, childId: childId);
    final docRef = refs.recordDoc(vaccineId);

    return docRef.snapshots().map((snapshot) {
      if (!snapshot.exists) return null;
      final data = snapshot.data();
      if (data == null) return null;
      return VaccinationRecordDto.fromFirestore(
        data,
        docId: snapshot.id,
      ).toDomain();
    }).handleError((_) => null);
  }

  Future<VaccinationRecord?> getVaccinationRecord({
    required String householdId,
    required String childId,
    required String vaccineId,
  }) async {
    final docRef = _ctx
        .refs(householdId: householdId, childId: childId)
        .recordDoc(vaccineId);
    final snapshot = await docRef.get();
    if (!snapshot.exists) return null;
    final data = snapshot.data();
    if (data == null) return null;
    return VaccinationRecordDto.fromFirestore(data, docId: snapshot.id)
        .toDomain();
  }

  Future<List<VaccinationSchedule>> getVaccinationSchedules({
    required String householdId,
    required String childId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final startUtc = startDate.toUtc();
    final endUtc = endDate.toUtc();
    final refs = _ctx.refs(householdId: householdId, childId: childId);
    final startTimestamp = Timestamp.fromDate(startUtc);
    final endTimestamp = Timestamp.fromDate(endUtc);

    final querySnapshot = await refs.schedules
        .where('scheduledDate', isGreaterThanOrEqualTo: startTimestamp)
        .where('scheduledDate', isLessThan: endTimestamp)
        .orderBy('scheduledDate')
        .get();

    if (querySnapshot.docs.isEmpty) {
      return _ctx.getLegacySchedules(householdId, childId, startUtc, endUtc);
    }

    return querySnapshot.docs
        .map((doc) => _ctx.mapScheduleDocument(doc, childId))
        .whereType<VaccinationSchedule>()
        .toList();
  }

  Future<List<VaccinationSchedule>> getVaccinationSchedulesForDate({
    required String householdId,
    required String childId,
    required DateTime date,
  }) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return getVaccinationSchedules(
      householdId: householdId,
      childId: childId,
      startDate: startOfDay,
      endDate: endOfDay,
    );
  }
}
