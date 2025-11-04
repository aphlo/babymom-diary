import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:babymom_diary/src/features/vaccines/infrastructure/firestore/helpers/vaccination_record_collection_ref.dart';

typedef TransactionHandler<T> = Future<T> Function(
  Transaction transaction,
  VaccinationRecordCollectionRef refs,
);

/// Centralizes Firestore transaction orchestration and retry handling.
class VaccinationTransactionExecutor {
  VaccinationTransactionExecutor(this._firestore);

  final FirebaseFirestore _firestore;

  Future<T> runForChild<T>({
    required String householdId,
    required String childId,
    required TransactionHandler<T> handler,
  }) {
    final refs = VaccinationRecordCollectionRef(
      firestore: _firestore,
      householdId: householdId,
      childId: childId,
    );

    return _firestore.runTransaction((transaction) {
      return handler(transaction, refs);
    });
  }
}
