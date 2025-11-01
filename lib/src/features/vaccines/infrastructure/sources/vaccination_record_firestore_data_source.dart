import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/vaccination_record.dart';
import '../../domain/entities/dose_record.dart';
import '../../domain/entities/vaccine_reservation_request.dart';
import '../../domain/entities/vaccination_schedule.dart';
import '../../domain/value_objects/vaccine_category.dart';
import '../../domain/value_objects/vaccine_requirement.dart';

class VaccinationRecordFirestoreDataSource {
  VaccinationRecordFirestoreDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  /// 指定した子供のワクチン接種記録を監視
  Stream<List<VaccinationRecord>> watchVaccinationRecords({
    required String householdId,
    required String childId,
  }) {
    return _firestore
        .collection('households')
        .doc(householdId)
        .collection('children')
        .doc(childId)
        .collection('vaccination_records')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => _mapDocumentToVaccinationRecord(doc))
          .where((record) => record != null)
          .cast<VaccinationRecord>()
          .toList();
    }).handleError((error) {
      // エラーが発生した場合は空のリストを返す
      return <VaccinationRecord>[];
    });
  }

  /// 指定した子供の特定のワクチン接種記録を取得
  Future<VaccinationRecord?> getVaccinationRecord({
    required String householdId,
    required String childId,
    required String vaccineId,
  }) async {
    try {
      final doc = await _firestore
          .collection('households')
          .doc(householdId)
          .collection('children')
          .doc(childId)
          .collection('vaccination_records')
          .doc(vaccineId)
          .get();

      if (!doc.exists) return null;
      return _mapDocumentSnapshotToVaccinationRecord(doc);
    } catch (error) {
      rethrow;
    }
  }

  /// ワクチン接種の予約を作成
  Future<void> createVaccineReservation({
    required String householdId,
    required VaccineReservationRequest request,
  }) async {
    try {
      final nowUtc = DateTime.now().toUtc();
      final scheduledDateUtc = request.scheduledDate.toUtc();

      final docRef = _firestore
          .collection('households')
          .doc(householdId)
          .collection('children')
          .doc(request.childId)
          .collection('vaccination_records')
          .doc(request.vaccineId);

      await _executeWithRetry(() async {
        await _firestore.runTransaction((transaction) async {
          final doc = await transaction.get(docRef);

          if (doc.exists) {
            // 既存の記録に新しい接種を追加
            final currentData = doc.data() as Map<String, dynamic>;
            final doses = Map<String, dynamic>.from(currentData['doses'] ?? {});

            doses[request.doseNumber.toString()] = {
              'status': 'scheduled',
              'scheduledDate': Timestamp.fromDate(scheduledDateUtc),
            };

            transaction.update(docRef, {
              'doses': doses,
              'updatedAt': Timestamp.fromDate(nowUtc),
            });
          } else {
            // 新しい接種記録を作成
            // TODO: ワクチン情報をマスタデータから取得
            final vaccineInfo = _getVaccineInfo(request.vaccineId);

            transaction.set(docRef, {
              'vaccineId': request.vaccineId,
              'vaccineName': vaccineInfo['name'],
              'category': vaccineInfo['category'],
              'requirement': vaccineInfo['requirement'],
              'doses': {
                request.doseNumber.toString(): {
                  'status': 'scheduled',
                  'scheduledDate': Timestamp.fromDate(scheduledDateUtc),
                }
              },
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

  /// 複数のワクチン接種の予約を同時に作成（同時接種用）
  Future<void> createMultipleVaccineReservations({
    required String householdId,
    required List<VaccineReservationRequest> requests,
  }) async {
    if (requests.isEmpty) return;

    try {
      final nowUtc = DateTime.now().toUtc();

      await _executeWithRetry(() async {
        await _firestore.runTransaction((transaction) async {
          // 各ワクチンの予約を処理
          for (final request in requests) {
            final scheduledDateUtc = request.scheduledDate.toUtc();

            final docRef = _firestore
                .collection('households')
                .doc(householdId)
                .collection('children')
                .doc(request.childId)
                .collection('vaccination_records')
                .doc(request.vaccineId);

            final doc = await transaction.get(docRef);

            if (doc.exists) {
              // 既存の記録に新しい接種を追加
              final currentData = doc.data() as Map<String, dynamic>;
              final doses =
                  Map<String, dynamic>.from(currentData['doses'] ?? {});

              doses[request.doseNumber.toString()] = {
                'status': 'scheduled',
                'scheduledDate': Timestamp.fromDate(scheduledDateUtc),
              };

              transaction.update(docRef, {
                'doses': doses,
                'updatedAt': Timestamp.fromDate(nowUtc),
              });
            } else {
              // 新しい接種記録を作成
              final vaccineInfo = _getVaccineInfo(request.vaccineId);

              transaction.set(docRef, {
                'vaccineId': request.vaccineId,
                'vaccineName': vaccineInfo['name'],
                'category': vaccineInfo['category'],
                'requirement': vaccineInfo['requirement'],
                'doses': {
                  request.doseNumber.toString(): {
                    'status': 'scheduled',
                    'scheduledDate': Timestamp.fromDate(scheduledDateUtc),
                  }
                },
                'createdAt': Timestamp.fromDate(nowUtc),
                'updatedAt': Timestamp.fromDate(nowUtc),
              });
            }
          }
        });
      });
    } catch (error) {
      rethrow;
    }
  }

  /// ワクチン接種の予約を更新
  Future<void> updateVaccineReservation({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
    required DateTime scheduledDate,
  }) async {
    try {
      final nowUtc = DateTime.now().toUtc();
      final scheduledDateUtc = scheduledDate.toUtc();

      final docRef = _firestore
          .collection('households')
          .doc(householdId)
          .collection('children')
          .doc(childId)
          .collection('vaccination_records')
          .doc(vaccineId);

      await _executeWithRetry(() async {
        await _firestore.runTransaction((transaction) async {
          final doc = await transaction.get(docRef);

          if (!doc.exists) {
            throw Exception('Vaccination record not found: $vaccineId');
          }

          final currentData = doc.data() as Map<String, dynamic>;
          final doses = Map<String, dynamic>.from(currentData['doses'] ?? {});

          if (!doses.containsKey(doseNumber.toString())) {
            throw Exception('Dose record not found: $doseNumber');
          }

          doses[doseNumber.toString()] = {
            'status': 'scheduled',
            'scheduledDate': Timestamp.fromDate(scheduledDateUtc),
          };

          transaction.update(docRef, {
            'doses': doses,
            'updatedAt': Timestamp.fromDate(nowUtc),
          });
        });
      });
    } catch (error) {
      rethrow;
    }
  }

  /// ワクチン接種を完了状態に更新
  Future<void> completeVaccination({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
    required DateTime completedDate,
  }) async {
    try {
      final nowUtc = DateTime.now().toUtc();
      final completedDateUtc = completedDate.toUtc();

      final docRef = _firestore
          .collection('households')
          .doc(householdId)
          .collection('children')
          .doc(childId)
          .collection('vaccination_records')
          .doc(vaccineId);

      await _executeWithRetry(() async {
        await _firestore.runTransaction((transaction) async {
          final doc = await transaction.get(docRef);

          if (!doc.exists) {
            throw Exception('Vaccination record not found: $vaccineId');
          }

          final currentData = doc.data() as Map<String, dynamic>;
          final doses = Map<String, dynamic>.from(currentData['doses'] ?? {});

          if (!doses.containsKey(doseNumber.toString())) {
            throw Exception('Dose record not found: $doseNumber');
          }

          doses[doseNumber.toString()] = {
            'status': 'completed',
            'completedDate': Timestamp.fromDate(completedDateUtc),
          };

          transaction.update(docRef, {
            'doses': doses,
            'updatedAt': Timestamp.fromDate(nowUtc),
          });
        });
      });
    } catch (error) {
      rethrow;
    }
  }

  /// ワクチン接種をスキップ状態に更新
  Future<void> skipVaccination({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
  }) async {
    try {
      final nowUtc = DateTime.now().toUtc();

      final docRef = _firestore
          .collection('households')
          .doc(householdId)
          .collection('children')
          .doc(childId)
          .collection('vaccination_records')
          .doc(vaccineId);

      await _executeWithRetry(() async {
        await _firestore.runTransaction((transaction) async {
          final doc = await transaction.get(docRef);

          if (!doc.exists) {
            throw Exception('Vaccination record not found: $vaccineId');
          }

          final currentData = doc.data() as Map<String, dynamic>;
          final doses = Map<String, dynamic>.from(currentData['doses'] ?? {});

          if (!doses.containsKey(doseNumber.toString())) {
            throw Exception('Dose record not found: $doseNumber');
          }

          doses[doseNumber.toString()] = {
            'status': 'skipped',
          };

          transaction.update(docRef, {
            'doses': doses,
            'updatedAt': Timestamp.fromDate(nowUtc),
          });
        });
      });
    } catch (error) {
      rethrow;
    }
  }

  /// ワクチン接種の予約を削除
  Future<void> deleteVaccineReservation({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
  }) async {
    try {
      final nowUtc = DateTime.now().toUtc();

      final docRef = _firestore
          .collection('households')
          .doc(householdId)
          .collection('children')
          .doc(childId)
          .collection('vaccination_records')
          .doc(vaccineId);

      await _executeWithRetry(() async {
        await _firestore.runTransaction((transaction) async {
          final doc = await transaction.get(docRef);

          if (!doc.exists) {
            throw Exception('Vaccination record not found: $vaccineId');
          }

          final currentData = doc.data() as Map<String, dynamic>;
          final doses = Map<String, dynamic>.from(currentData['doses'] ?? {});

          if (!doses.containsKey(doseNumber.toString())) {
            throw Exception('Dose record not found: $doseNumber');
          }

          doses.remove(doseNumber.toString());

          if (doses.isEmpty) {
            // 全ての接種記録が削除された場合はドキュメント自体を削除
            transaction.delete(docRef);
          } else {
            transaction.update(docRef, {
              'doses': doses,
              'updatedAt': Timestamp.fromDate(nowUtc),
            });
          }
        });
      });
    } catch (error) {
      rethrow;
    }
  }

  /// 指定した期間のワクチン接種予定を取得（カレンダー表示用）
  Future<List<VaccinationSchedule>> getVaccinationSchedules({
    required String householdId,
    required String childId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final startUtc = startDate.toUtc();
      final endUtc = endDate.toUtc();

      final snapshot = await _firestore
          .collection('households')
          .doc(householdId)
          .collection('children')
          .doc(childId)
          .collection('vaccination_records')
          .get();

      final schedules = <VaccinationSchedule>[];

      for (final doc in snapshot.docs) {
        final record = _mapDocumentToVaccinationRecord(doc);
        if (record == null) continue;

        // 各接種記録から予定されている接種を抽出
        for (final entry in record.doses.entries) {
          final doseNumber = entry.key;
          final doseRecord = entry.value;

          if (doseRecord.status == DoseStatus.scheduled &&
              doseRecord.scheduledDate != null) {
            final scheduledDate = doseRecord.scheduledDate!;

            // 指定期間内の予定のみを含める
            if (scheduledDate
                    .isAfter(startUtc.subtract(const Duration(days: 1))) &&
                scheduledDate.isBefore(endUtc.add(const Duration(days: 1)))) {
              schedules.add(VaccinationSchedule(
                childId: childId,
                vaccineId: record.vaccineId,
                vaccineName: record.vaccineName,
                doseNumber: doseNumber,
                scheduledDate: scheduledDate,
                category: record.category,
                requirement: record.requirement,
              ));
            }
          }
        }
      }

      return schedules
        ..sort((a, b) => a.scheduledDate.compareTo(b.scheduledDate));
    } catch (error) {
      rethrow;
    }
  }

  /// 指定した日付のワクチン接種予定を取得
  /// DocumentSnapshotを VaccinationRecord に変換
  VaccinationRecord? _mapDocumentSnapshotToVaccinationRecord(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    try {
      final data = doc.data();
      if (data == null) return null;
      return _mapDataToVaccinationRecord(data, doc.id);
    } catch (error) {
      return null;
    }
  }

  /// データマップを VaccinationRecord に変換
  VaccinationRecord? _mapDataToVaccinationRecord(
    Map<String, dynamic> data,
    String docId,
  ) {
    final dosesData = data['doses'] as Map<String, dynamic>? ?? {};
    final doses = <int, DoseRecord>{};

    for (final entry in dosesData.entries) {
      final doseNumber = int.tryParse(entry.key);
      if (doseNumber == null) continue;

      final doseData = entry.value as Map<String, dynamic>;
      final statusString = doseData['status'] as String?;
      final status = _parseDoseStatus(statusString);
      if (status == null) continue;

      final scheduledTimestamp = doseData['scheduledDate'] as Timestamp?;
      final completedTimestamp = doseData['completedDate'] as Timestamp?;

      doses[doseNumber] = DoseRecord(
        doseNumber: doseNumber,
        status: status,
        scheduledDate: scheduledTimestamp?.toDate(),
        completedDate: completedTimestamp?.toDate(),
      );
    }

    final categoryString = data['category'] as String?;
    final requirementString = data['requirement'] as String?;

    final category = _parseVaccineCategory(categoryString);
    final requirement = _parseVaccineRequirement(requirementString);

    if (category == null || requirement == null) return null;

    final createdTimestamp = data['createdAt'] as Timestamp?;
    final updatedTimestamp = data['updatedAt'] as Timestamp?;

    return VaccinationRecord(
      vaccineId: data['vaccineId'] as String? ?? docId,
      vaccineName: data['vaccineName'] as String? ?? '',
      category: category,
      requirement: requirement,
      doses: doses,
      createdAt: createdTimestamp?.toDate() ?? DateTime.now(),
      updatedAt: updatedTimestamp?.toDate() ?? DateTime.now(),
    );
  }

  Future<List<VaccinationSchedule>> getVaccinationSchedulesForDate({
    required String householdId,
    required String childId,
    required DateTime date,
  }) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return getVaccinationSchedules(
      householdId: householdId,
      childId: childId,
      startDate: startOfDay,
      endDate: endOfDay,
    );
  }

  /// Firestoreドキュメントを VaccinationRecord に変換
  VaccinationRecord? _mapDocumentToVaccinationRecord(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    try {
      final data = doc.data();
      return _mapDataToVaccinationRecord(data, doc.id);
    } catch (error) {
      return null;
    }
  }

  /// 文字列を DoseStatus に変換
  DoseStatus? _parseDoseStatus(String? statusString) {
    switch (statusString) {
      case 'scheduled':
        return DoseStatus.scheduled;
      case 'completed':
        return DoseStatus.completed;
      case 'skipped':
        return DoseStatus.skipped;
      default:
        return null;
    }
  }

  /// 文字列を VaccineCategory に変換
  VaccineCategory? _parseVaccineCategory(String? categoryString) {
    switch (categoryString) {
      case 'live':
        return VaccineCategory.live;
      case 'inactivated':
        return VaccineCategory.inactivated;
      default:
        return null;
    }
  }

  /// 文字列を VaccineRequirement に変換
  VaccineRequirement? _parseVaccineRequirement(String? requirementString) {
    switch (requirementString) {
      case 'mandatory':
        return VaccineRequirement.mandatory;
      case 'optional':
        return VaccineRequirement.optional;
      default:
        return null;
    }
  }

  /// ワクチン情報を取得（仮実装）
  Map<String, String> _getVaccineInfo(String vaccineId) {
    // TODO: ワクチンマスタデータから取得するように実装
    final vaccineInfoMap = {
      'hib': {
        'name': 'Hib（ヒブ）',
        'category': 'inactivated',
        'requirement': 'mandatory',
      },
      'pneumococcal': {
        'name': '小児用肺炎球菌',
        'category': 'inactivated',
        'requirement': 'mandatory',
      },
      'dpt_ipv': {
        'name': '四種混合（DPT-IPV）',
        'category': 'inactivated',
        'requirement': 'mandatory',
      },
      'bcg': {
        'name': 'BCG',
        'category': 'live',
        'requirement': 'mandatory',
      },
      'mr1': {
        'name': 'MR（麻疹・風疹）1期',
        'category': 'live',
        'requirement': 'mandatory',
      },
      'mr2': {
        'name': 'MR（麻疹・風疹）2期',
        'category': 'live',
        'requirement': 'mandatory',
      },
      'hepatitis_b': {
        'name': 'B型肝炎',
        'category': 'inactivated',
        'requirement': 'mandatory',
      },
      'rotavirus': {
        'name': 'ロタウイルス',
        'category': 'live',
        'requirement': 'optional',
      },
      'japanese_encephalitis_1': {
        'name': '日本脳炎1期',
        'category': 'inactivated',
        'requirement': 'mandatory',
      },
      'japanese_encephalitis_2': {
        'name': '日本脳炎2期',
        'category': 'inactivated',
        'requirement': 'mandatory',
      },
    };

    return vaccineInfoMap[vaccineId] ??
        {
          'name': vaccineId,
          'category': 'inactivated',
          'requirement': 'optional',
        };
  }

  /// リトライ機能付きでFirestore操作を実行
  Future<void> _executeWithRetry(Future<void> Function() operation) async {
    const maxRetries = 3;
    var retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        await operation();
        return;
      } catch (error) {
        retryCount++;
        if (retryCount >= maxRetries) {
          rethrow;
        }
        // 指数バックオフで待機
        await Future.delayed(Duration(milliseconds: 100 * (1 << retryCount)));
      }
    }
  }
}
