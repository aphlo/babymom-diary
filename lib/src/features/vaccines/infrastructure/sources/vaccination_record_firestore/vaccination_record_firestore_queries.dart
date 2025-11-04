import '../../../domain/entities/vaccination_record.dart';
import '../../models/vaccination_record.dart';
import 'vaccination_record_firestore_context.dart';

class VaccinationRecordFirestoreQueries {
  VaccinationRecordFirestoreQueries(this._ctx);

  final VaccinationRecordFirestoreContext _ctx;

  Stream<List<VaccinationRecord>> watchVaccinationRecords({
    required String householdId,
    required String childId,
  }) {
    return _ctx
        .refs(householdId: householdId, childId: childId)
        .vaccinationRecords
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                VaccinationRecordDto.fromFirestore(doc.data(), docId: doc.id))
            .map((dto) => dto.toDomain())
            .toList());
  }

  Stream<VaccinationRecord?> watchVaccinationRecord({
    required String householdId,
    required String childId,
    required String vaccineId,
  }) {
    return _ctx
        .refs(householdId: householdId, childId: childId)
        .recordDoc(vaccineId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) return null;
      final data = snapshot.data();
      if (data == null) return null;
      return VaccinationRecordDto.fromFirestore(data, docId: snapshot.id)
          .toDomain();
    });
  }

  Future<VaccinationRecord?> getVaccinationRecord({
    required String householdId,
    required String childId,
    required String vaccineId,
  }) async {
    final snapshot = await _ctx
        .refs(householdId: householdId, childId: childId)
        .recordDoc(vaccineId)
        .get();

    if (!snapshot.exists) return null;
    final data = snapshot.data();
    if (data == null) return null;

    return VaccinationRecordDto.fromFirestore(data, docId: snapshot.id)
        .toDomain();
  }
}
