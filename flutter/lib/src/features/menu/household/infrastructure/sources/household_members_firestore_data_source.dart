import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/household_member.dart';

class HouseholdMembersFirestoreDataSource {
  HouseholdMembersFirestoreDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<List<HouseholdMember>> watchMembers(String householdId) {
    return _firestore
        .collection('households')
        .doc(householdId)
        .collection('members')
        .orderBy('joinedAt', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return HouseholdMember(
          uid: data['uid'] as String,
          displayName: data['displayName'] as String? ?? '名前未設定',
          role: data['role'] as String? ?? 'member',
          joinedAt:
              (data['joinedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        );
      }).toList();
    });
  }
}
