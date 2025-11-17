import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/invitation.dart';

class GetPendingInvitations {
  GetPendingInvitations(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<List<Invitation>> call(String householdId) {
    return _firestore
        .collection('households')
        .doc(householdId)
        .collection('invitations')
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            final data = doc.data();
            final expiresAt = (data['expiresAt'] as Timestamp).toDate();
            final now = DateTime.now();

            // Determine actual status (check expiration)
            final status = now.isAfter(expiresAt)
                ? InvitationStatus.expired
                : InvitationStatus.pending;

            return Invitation(
              id: doc.id,
              code: data['code'] as String,
              createdBy: data['createdBy'] as String,
              createdAt: (data['createdAt'] as Timestamp).toDate(),
              expiresAt: expiresAt,
              status: status,
              acceptedBy: data['acceptedBy'] as String?,
              acceptedAt: data['acceptedAt'] != null
                  ? (data['acceptedAt'] as Timestamp).toDate()
                  : null,
            );
          })
          .where((inv) => inv.isPending)
          .toList();
    });
  }
}
