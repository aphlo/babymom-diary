import 'package:cloud_firestore/cloud_firestore.dart';

/// Helper to build strongly typed references for vaccination data rooted at a child.
class VaccinationRecordCollectionRef {
  VaccinationRecordCollectionRef({
    required FirebaseFirestore firestore,
    required this.householdId,
    required this.childId,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;
  final String householdId;
  final String childId;

  DocumentReference<Map<String, dynamic>> get _childDoc => _firestore
      .collection('households')
      .doc(householdId)
      .collection('children')
      .doc(childId);

  CollectionReference<Map<String, dynamic>> get vaccinationRecords =>
      _childDoc.collection('vaccination_records');

  DocumentReference<Map<String, dynamic>> recordDoc(String vaccineId) =>
      vaccinationRecords.doc(vaccineId);

  CollectionReference<Map<String, dynamic>> get reservationGroups =>
      _childDoc.collection('reservation_groups');

  DocumentReference<Map<String, dynamic>> reservationGroupDoc(String groupId) =>
      reservationGroups.doc(groupId);

  CollectionReference<Map<String, dynamic>> get schedules =>
      _childDoc.collection('vaccination_schedules');

  DocumentReference<Map<String, dynamic>> scheduleDoc({
    required String vaccineId,
    required int doseNumber,
  }) {
    return schedules.doc('${vaccineId}_$doseNumber');
  }

  VaccinationRecordCollectionRef copyWith({
    String? householdId,
    String? childId,
  }) {
    return VaccinationRecordCollectionRef(
      firestore: _firestore,
      householdId: householdId ?? this.householdId,
      childId: childId ?? this.childId,
    );
  }
}
