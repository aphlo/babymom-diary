import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:babymom_diary/src/core/utils/date_formatter.dart';

import '../../../review_prompt/presentation/viewmodels/review_prompt_view_model.dart';
import '../../application/usecases/get_vaccine_by_id.dart';
import '../../application/usecases/watch_vaccination_record.dart';
import '../../domain/entities/dose_record.dart';
import '../../domain/entities/vaccination_record.dart';
import '../../domain/entities/vaccine.dart';
import '../../domain/repositories/vaccination_record_repository.dart';
import '../../domain/services/vaccination_schedule_policy.dart';
import '../../domain/errors/vaccination_persistence_exception.dart';
import '../../domain/value_objects/vaccination_recommendation.dart';
import '../../application/vaccine_catalog_providers.dart';
import 'vaccine_detail_state.dart';

export 'vaccine_detail_state.dart';

part 'vaccine_detail_view_model.g.dart';

@riverpod
class VaccineDetailViewModel extends _$VaccineDetailViewModel {
  StreamSubscription<VaccinationRecord?>? _subscription;
  Vaccine? _vaccine;
  DateTime? _childBirthday;
  List<int> _doseNumbers = const <int>[];
  String? _householdId;
  String? _childId;
  String? _vaccineId;

  WatchVaccinationRecord get _watchVaccinationRecord =>
      ref.read(watchVaccinationRecordProvider);
  GetVaccineById get _getVaccineById => ref.read(getVaccineByIdProvider);
  VaccinationSchedulePolicy get _vaccinationSchedulePolicy =>
      ref.read(vaccinationSchedulePolicyProvider);
  VaccinationRecordRepository get _vaccinationRecordRepository =>
      ref.read(vaccinationRecordRepositoryProvider);

  @override
  VaccineDetailState build(VaccineDetailParams params) {
    ref.onDispose(() {
      _subscription?.cancel();
    });

    _householdId = params.householdId;
    _childId = params.childId;
    _vaccineId = params.vaccineId;
    _childBirthday = params.childBirthday;
    _doseNumbers = List<int>.from(params.doseNumbers)..sort();

    // 初期化処理をスケジュール
    Future.microtask(() => _prepareDataAndListen(params));

    return VaccineDetailState(
      isLoading: true,
      doseStatuses: _buildInitialStatuses(_doseNumbers),
      doseNumbers: List<int>.unmodifiable(_doseNumbers),
      activeDoseNumber: _doseNumbers.isNotEmpty ? _doseNumbers.first : null,
      pendingDoseNumber: _findFirstPendingDose(
        _doseNumbers,
        _buildInitialStatuses(_doseNumbers),
      ),
    );
  }

  Future<void> _prepareDataAndListen(VaccineDetailParams params) async {
    try {
      _vaccine = await _getVaccineById(params.vaccineId);
      if (_vaccine != null) {
        final List<int> derivedDoseNumbers = _deriveDoseNumbers(_vaccine!);
        if (derivedDoseNumbers.isNotEmpty) {
          _doseNumbers = derivedDoseNumbers;
          state = state.copyWith(
            doseNumbers: List<int>.unmodifiable(_doseNumbers),
            doseStatuses: _buildInitialStatuses(_doseNumbers),
            activeDoseNumber:
                _doseNumbers.isNotEmpty ? _doseNumbers.first : null,
            pendingDoseNumber:
                _doseNumbers.isNotEmpty ? _doseNumbers.first : null,
            recommendation: null,
          );
        }
      }
    } catch (_) {
      state = state.copyWith(
        error: 'ワクチン情報の取得に失敗しました',
        isLoading: false,
      );
      return;
    }

    _subscription?.cancel();
    _subscription = _watchVaccinationRecord(
      householdId: params.householdId,
      childId: params.childId,
      vaccineId: params.vaccineId,
    ).listen(
      _handleRecordUpdate,
      onError: (Object error, StackTrace stackTrace) {
        state = state.copyWith(
          isLoading: false,
          error: '接種状況の取得に失敗しました',
        );
      },
    );
  }

  void _handleRecordUpdate(VaccinationRecord? record) {
    if (_doseNumbers.isEmpty) {
      state = state.copyWith(isLoading: false);
      return;
    }

    final Map<int, DoseStatusInfo> statuses =
        _buildDoseStatuses(_doseNumbers, record);
    final int? pendingDose = _findFirstPendingDose(_doseNumbers, statuses);
    final int? activeDose = _resolveActiveDoseNumber(statuses);

    final DoseRecommendationInfo? recommendation =
        _buildRecommendationInfo(pendingDose, record);

    state = state.copyWith(
      isLoading: false,
      doseStatuses: statuses,
      doseNumbers: List<int>.unmodifiable(_doseNumbers),
      activeDoseNumber: activeDose,
      pendingDoseNumber: pendingDose,
      recommendation: recommendation,
      error: null,
    );
  }

  DoseRecommendationInfo? _buildRecommendationInfo(
    int? pendingDose,
    VaccinationRecord? record,
  ) {
    if (pendingDose == null || _vaccine == null) {
      return null;
    }

    final VaccinationRecommendation? recommendation =
        _vaccinationSchedulePolicy.recommend(
      vaccine: _vaccine!,
      doseNumber: pendingDose,
      record: record,
      childBirthday: _childBirthday,
    );

    if (recommendation == null) {
      return null;
    }

    final String? message = _formatRecommendationMessage(recommendation);
    if (message == null) {
      return null;
    }

    return DoseRecommendationInfo(
      doseNumber: recommendation.doseNumber,
      message: message,
      startDate: recommendation.startDate,
      endDate: recommendation.endDate,
    );
  }

  String? _formatRecommendationMessage(
    VaccinationRecommendation recommendation,
  ) {
    if (recommendation.startDate != null) {
      final String startText =
          DateFormatter.yyyyMMddE(recommendation.startDate!);
      final DateTime? end = recommendation.endDate;
      final String header = '接種時期のめやす';
      if (end == null) {
        return '$header\n$startText以降';
      }
      final String endText = DateFormatter.yyyyMMddE(end);
      if (recommendation.startDate!.isAtSameMomentAs(end)) {
        return '$header\n$startText';
      }
      return '$header\n$startText〜\n$endText';
    }

    if (recommendation.labels.isNotEmpty) {
      return _fallbackRecommendationText(recommendation.labels);
    }

    return null;
  }

  String _fallbackRecommendationText(List<String> labels) {
    if (labels.isEmpty) {
      return '接種時期の情報がありません';
    }
    if (labels.length == 1) {
      return '接種時期のめやす\n${labels.first}ごろ';
    }
    return '接種時期のめやす\n${labels.first} 〜 ${labels.last}ごろ';
  }

  Map<int, DoseStatusInfo> _buildInitialStatuses(List<int> doseNumbers) {
    final statuses = <int, DoseStatusInfo>{};
    for (final dose in doseNumbers) {
      statuses[dose] = DoseStatusInfo(doseNumber: dose);
    }
    return statuses;
  }

  Map<int, DoseStatusInfo> _buildDoseStatuses(
    List<int> doseNumbers,
    VaccinationRecord? record,
  ) {
    final statuses = <int, DoseStatusInfo>{};
    for (final dose in doseNumbers) {
      final doseRecord = record?.getDoseByNumber(dose);
      statuses[dose] = DoseStatusInfo(
        doseNumber: dose,
        status: doseRecord?.status,
        scheduledDate: doseRecord?.scheduledDate,
        reservationGroupId: doseRecord?.reservationGroupId,
      );
    }
    return statuses;
  }

  int? _findFirstPendingDose(
    List<int> doseNumbers,
    Map<int, DoseStatusInfo> statuses,
  ) {
    for (final int dose in doseNumbers) {
      final DoseStatusInfo? info = statuses[dose];
      if (info == null || info.status == null) {
        return dose;
      }
    }
    return null;
  }

  int? _resolveActiveDoseNumber(Map<int, DoseStatusInfo> statuses) {
    if (statuses.isEmpty) return null;

    final sortedDoseNumbers = statuses.keys.toList()..sort();

    final scheduled = sortedDoseNumbers.where((dose) {
      final info = statuses[dose];
      return info?.status == DoseStatus.scheduled;
    });
    if (scheduled.isNotEmpty) {
      return scheduled.first;
    }

    final pending = sortedDoseNumbers.where((dose) {
      final info = statuses[dose];
      return info?.status == null;
    });
    if (pending.isNotEmpty) {
      return pending.first;
    }

    return sortedDoseNumbers.last;
  }

  List<int> _deriveDoseNumbers(Vaccine vaccine) {
    if (vaccine.id == 'influenza_injection') {
      // インフルエンザ注射は固定で14回分
      return List<int>.generate(14, (index) => index + 1);
    }
    if (vaccine.id == 'influenza_nasal') {
      // インフルエンザ経鼻は固定で5回分
      return List<int>.generate(5, (index) => index + 1);
    }
    final Set<int> result = <int>{};
    for (final VaccineScheduleSlot slot in vaccine.schedule) {
      result.addAll(slot.doseNumbers);
    }
    final List<int> sorted = result.toList()..sort();
    return sorted;
  }

  /// 接種を完了状態に更新
  Future<void> markDoseAsCompleted({
    required int doseNumber,
    bool applyToGroup = true,
  }) async {
    if (_householdId == null || _childId == null || _vaccineId == null) {
      state = state.copyWith(error: '必要な情報が不足しています');
      return;
    }

    final doseStatus = state.doseStatuses[doseNumber];
    final resolvedCompletedDate = doseStatus?.scheduledDate;
    if (resolvedCompletedDate == null) {
      state = state.copyWith(
        error: '接種日が設定されていません',
      );
      return;
    }

    try {
      state = state.copyWith(
        isLoading: true,
        error: null,
      );

      final groupId = state.doseStatuses[doseNumber]?.reservationGroupId;

      if (groupId != null && applyToGroup) {
        await _vaccinationRecordRepository.completeReservationGroup(
          householdId: _householdId!,
          childId: _childId!,
          reservationGroupId: groupId,
        );
      } else if (groupId != null && !applyToGroup) {
        final record = await _vaccinationRecordRepository.getVaccinationRecord(
          householdId: _householdId!,
          childId: _childId!,
          vaccineId: _vaccineId!,
        );
        final doseId = record?.getDoseByNumber(doseNumber)?.doseId;
        if (doseId == null) {
          state = state.copyWith(
            isLoading: false,
            error: '接種記録が見つかりません',
          );
          return;
        }
        await _vaccinationRecordRepository.completeReservationGroupMember(
          householdId: _householdId!,
          childId: _childId!,
          reservationGroupId: groupId,
          vaccineId: _vaccineId!,
          doseId: doseId,
        );
      } else {
        final record = await _vaccinationRecordRepository.getVaccinationRecord(
          householdId: _householdId!,
          childId: _childId!,
          vaccineId: _vaccineId!,
        );
        final doseId = record?.getDoseByNumber(doseNumber)?.doseId;
        if (doseId == null) {
          state = state.copyWith(
            isLoading: false,
            error: '接種記録が見つかりません',
          );
          return;
        }
        await _vaccinationRecordRepository.completeVaccination(
          householdId: _householdId!,
          childId: _childId!,
          vaccineId: _vaccineId!,
          doseId: doseId,
        );
      }

      // レビュープロンプトのカウント増加
      await ref
          .read(reviewPromptViewModelProvider.notifier)
          .incrementRecordCountOnly();
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: '接種完了の更新に失敗しました: $error',
      );
      rethrow;
    }
  }

  /// ワクチン接種の予約を削除
  Future<void> deleteVaccineReservation({
    required int doseNumber,
    bool applyToGroup = true,
    String? reservationGroupId,
  }) async {
    if (_householdId == null || _childId == null || _vaccineId == null) {
      state = state.copyWith(error: '必要な情報が不足しています');
      return;
    }

    try {
      state = state.copyWith(
        isLoading: true,
        error: null,
      );

      String? groupId = reservationGroupId ??
          state.doseStatuses[doseNumber]?.reservationGroupId;

      if (applyToGroup && groupId == null) {
        final record = await _vaccinationRecordRepository.getVaccinationRecord(
          householdId: _householdId!,
          childId: _childId!,
          vaccineId: _vaccineId!,
        );
        groupId = record?.getDoseByNumber(doseNumber)?.reservationGroupId;
      }

      if (groupId != null && applyToGroup) {
        await _vaccinationRecordRepository.deleteReservationGroup(
          householdId: _householdId!,
          childId: _childId!,
          reservationGroupId: groupId,
        );
      } else if (groupId != null && !applyToGroup) {
        final record = await _vaccinationRecordRepository.getVaccinationRecord(
          householdId: _householdId!,
          childId: _childId!,
          vaccineId: _vaccineId!,
        );
        final doseId = record?.getDoseByNumber(doseNumber)?.doseId;
        if (doseId == null) {
          state = state.copyWith(
            isLoading: false,
            error: '接種記録が見つかりません',
          );
          return;
        }
        await _vaccinationRecordRepository.deleteReservationGroupMember(
          householdId: _householdId!,
          childId: _childId!,
          reservationGroupId: groupId,
          vaccineId: _vaccineId!,
          doseId: doseId,
        );
      } else {
        final record = await _vaccinationRecordRepository.getVaccinationRecord(
          householdId: _householdId!,
          childId: _childId!,
          vaccineId: _vaccineId!,
        );
        final doseId = record?.getDoseByNumber(doseNumber)?.doseId;
        if (doseId == null) {
          state = state.copyWith(
            isLoading: false,
            error: '接種記録が見つかりません',
          );
          return;
        }
        await _vaccinationRecordRepository.deleteVaccineReservation(
          householdId: _householdId!,
          childId: _childId!,
          vaccineId: _vaccineId!,
          doseId: doseId,
        );
      }
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: '予約削除に失敗しました: $error',
      );
      rethrow;
    }
  }

  /// ワクチン接種の予約を更新
  Future<void> updateVaccineReservation({
    required int doseNumber,
    required DateTime scheduledDate,
    bool applyToGroup = true,
    String? reservationGroupId,
  }) async {
    if (_householdId == null || _childId == null || _vaccineId == null) {
      state = state.copyWith(error: '必要な情報が不足しています');
      return;
    }

    try {
      state = state.copyWith(
        isLoading: true,
        error: null,
      );

      final groupId = reservationGroupId ??
          state.doseStatuses[doseNumber]?.reservationGroupId;

      if (groupId != null && applyToGroup) {
        await _vaccinationRecordRepository.updateReservationGroupSchedule(
          householdId: _householdId!,
          childId: _childId!,
          reservationGroupId: groupId,
          scheduledDate: scheduledDate,
        );
      } else {
        final record = await _vaccinationRecordRepository.getVaccinationRecord(
          householdId: _householdId!,
          childId: _childId!,
          vaccineId: _vaccineId!,
        );
        final doseId = record?.getDoseByNumber(doseNumber)?.doseId;
        if (doseId == null) {
          state = state.copyWith(
            isLoading: false,
            error: '接種記録が見つかりません',
          );
          return;
        }
        await _vaccinationRecordRepository.updateVaccineReservation(
          householdId: _householdId!,
          childId: _childId!,
          vaccineId: _vaccineId!,
          doseId: doseId,
          scheduledDate: scheduledDate,
        );
      }

      // レビュープロンプトのカウント増加
      await ref
          .read(reviewPromptViewModelProvider.notifier)
          .incrementRecordCountOnly();
    } on DuplicateScheduleDateException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      rethrow;
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: '予約更新に失敗しました: $error',
      );
      rethrow;
    }
  }

  /// 接種済みを予約済みに戻す
  Future<void> markDoseAsScheduled({
    required int doseNumber,
    required DateTime scheduledDate,
    bool applyToGroup = true,
    String? reservationGroupId,
  }) async {
    if (_householdId == null || _childId == null || _vaccineId == null) {
      state = state.copyWith(error: '必要な情報が不足しています');
      return;
    }

    try {
      state = state.copyWith(
        isLoading: true,
        error: null,
      );

      String? groupId = reservationGroupId ??
          state.doseStatuses[doseNumber]?.reservationGroupId;

      if (applyToGroup && groupId == null) {
        final record = await _vaccinationRecordRepository.getVaccinationRecord(
          householdId: _householdId!,
          childId: _childId!,
          vaccineId: _vaccineId!,
        );
        groupId = record?.getDoseByNumber(doseNumber)?.reservationGroupId;
      }

      if (groupId != null && applyToGroup) {
        await _vaccinationRecordRepository.markReservationGroupAsScheduled(
          householdId: _householdId!,
          childId: _childId!,
          reservationGroupId: groupId,
          scheduledDate: scheduledDate,
        );
      } else {
        final record = await _vaccinationRecordRepository.getVaccinationRecord(
          householdId: _householdId!,
          childId: _childId!,
          vaccineId: _vaccineId!,
        );
        final doseId = record?.getDoseByNumber(doseNumber)?.doseId;
        if (doseId == null) {
          state = state.copyWith(
            isLoading: false,
            error: '接種記録が見つかりません',
          );
          return;
        }
        await _vaccinationRecordRepository.markDoseAsScheduled(
          householdId: _householdId!,
          childId: _childId!,
          vaccineId: _vaccineId!,
          doseId: doseId,
          scheduledDate: scheduledDate,
        );
      }
    } on DuplicateScheduleDateException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      rethrow;
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: '予約済みへの変更に失敗しました: $error',
      );
      rethrow;
    }
  }
}
