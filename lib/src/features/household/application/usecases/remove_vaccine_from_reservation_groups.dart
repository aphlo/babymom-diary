import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../vaccines/domain/repositories/vaccination_record_repository.dart';

/// ワクチンをOFFにした時、全てのreservation_groupsから該当ワクチンを削除するユースケース
class RemoveVaccineFromReservationGroups {
  RemoveVaccineFromReservationGroups({
    required FirebaseFirestore firestore,
    required VaccinationRecordRepository vaccinationRecordRepository,
  })  : _firestore = firestore,
        _vaccinationRecordRepository = vaccinationRecordRepository;

  final FirebaseFirestore _firestore;
  final VaccinationRecordRepository _vaccinationRecordRepository;

  /// 指定されたワクチンを全てのreservation_groupsから削除
  ///
  /// household内の全ての子供のreservation_groupsをチェックし、
  /// 指定されたvaccineIdが含まれている場合は削除します。
  Future<void> call({
    required String householdId,
    required String vaccineId,
  }) async {
    try {
      // household内の全ての子供を取得
      final childrenSnapshot = await _firestore
          .collection('households')
          .doc(householdId)
          .collection('children')
          .get();

      // 各子供のreservation_groupsをチェック
      for (final childDoc in childrenSnapshot.docs) {
        final childId = childDoc.id;

        // この子供のreservation_groupsを取得
        final reservationGroupsSnapshot = await _firestore
            .collection('households')
            .doc(householdId)
            .collection('children')
            .doc(childId)
            .collection('reservation_groups')
            .where('status', isEqualTo: 'scheduled') // 予約済みのグループのみ
            .get();

        // 各グループをチェック
        for (final groupDoc in reservationGroupsSnapshot.docs) {
          final groupData = groupDoc.data();
          final groupId = groupDoc.id;
          final members = groupData['members'] as List<dynamic>?;

          if (members == null || members.isEmpty) {
            continue;
          }

          // このグループに該当するvaccineIdが含まれているかチェック
          for (final member in members) {
            if (member is Map<String, dynamic>) {
              final memberVaccineId = member['vaccineId'] as String?;
              final memberDoseId = member['doseId'] as String?;

              if (memberVaccineId == vaccineId && memberDoseId != null) {
                // 該当するワクチンが見つかった場合、グループから削除
                try {
                  await _vaccinationRecordRepository
                      .deleteReservationGroupMember(
                    householdId: householdId,
                    childId: childId,
                    reservationGroupId: groupId,
                    vaccineId: vaccineId,
                    doseId: memberDoseId,
                  );
                } catch (e) {
                  // 削除に失敗した場合もログに記録して続行
                  // （他のグループの削除を継続するため）
                  // ignore: avoid_print
                  print(
                      'Failed to delete vaccine $vaccineId (dose: $memberDoseId) from reservation group $groupId: $e');
                }
                // 同じワクチンが複数回含まれることはないので、次のグループへ
                break;
              }
            }
          }
        }
      }
    } catch (e) {
      throw Exception(
          'Failed to remove vaccine $vaccineId from reservation groups in household $householdId: $e');
    }
  }
}
