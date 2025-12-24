import 'package:flutter_test/flutter_test.dart';

import 'package:babymom_diary/src/features/vaccines/domain/entities/dose_record.dart';
import 'package:babymom_diary/src/features/vaccines/presentation/viewmodels/vaccine_detail_state.dart';

void main() {
  group('VaccineDetailState', () {
    test('初期状態が正しい', () {
      const state = VaccineDetailState();

      expect(state.isLoading, false);
      expect(state.error, isNull);
      expect(state.doseStatuses, isEmpty);
      expect(state.doseNumbers, isEmpty);
      expect(state.activeDoseNumber, isNull);
      expect(state.pendingDoseNumber, isNull);
      expect(state.recommendation, isNull);
    });

    group('copyWith', () {
      test('isLoading を更新できる', () {
        const state = VaccineDetailState();
        final newState = state.copyWith(isLoading: true);
        expect(newState.isLoading, true);
      });

      test('error を更新できる', () {
        const state = VaccineDetailState();
        final newState = state.copyWith(error: 'エラーメッセージ');
        expect(newState.error, 'エラーメッセージ');
      });

      test('doseStatuses を更新できる', () {
        const state = VaccineDetailState();
        final statuses = {
          1: const DoseStatusInfo(doseNumber: 1, status: DoseStatus.completed),
        };
        final newState = state.copyWith(doseStatuses: statuses);
        expect(newState.doseStatuses[1]?.status, DoseStatus.completed);
      });

      test('doseNumbers を更新できる', () {
        const state = VaccineDetailState();
        final newState = state.copyWith(doseNumbers: [1, 2, 3, 4]);
        expect(newState.doseNumbers, [1, 2, 3, 4]);
      });

      test('activeDoseNumber を更新できる', () {
        const state = VaccineDetailState();
        final newState = state.copyWith(activeDoseNumber: 2);
        expect(newState.activeDoseNumber, 2);
      });

      test('pendingDoseNumber を更新できる', () {
        const state = VaccineDetailState();
        final newState = state.copyWith(pendingDoseNumber: 3);
        expect(newState.pendingDoseNumber, 3);
      });

      test('recommendation を更新できる', () {
        const state = VaccineDetailState();
        const recommendation = DoseRecommendationInfo(
          doseNumber: 1,
          message: '接種時期のめやす\n2024年3月15日以降',
        );
        final newState = state.copyWith(recommendation: recommendation);
        expect(newState.recommendation?.doseNumber, 1);
        expect(newState.recommendation?.message, contains('2024年3月15日'));
      });
    });
  });

  group('DoseStatusInfo', () {
    test('doseNumberのみで作成できる', () {
      const info = DoseStatusInfo(doseNumber: 1);
      expect(info.doseNumber, 1);
      expect(info.status, isNull);
      expect(info.scheduledDate, isNull);
      expect(info.reservationGroupId, isNull);
    });

    test('全てのフィールドを指定できる', () {
      final date = DateTime(2024, 3, 15);
      final info = DoseStatusInfo(
        doseNumber: 2,
        status: DoseStatus.scheduled,
        scheduledDate: date,
        reservationGroupId: 'group-123',
      );
      expect(info.doseNumber, 2);
      expect(info.status, DoseStatus.scheduled);
      expect(info.scheduledDate, date);
      expect(info.reservationGroupId, 'group-123');
    });

    test('status が completed の場合', () {
      const info = DoseStatusInfo(
        doseNumber: 1,
        status: DoseStatus.completed,
      );
      expect(info.status, DoseStatus.completed);
    });

    test('status が scheduled の場合', () {
      const info = DoseStatusInfo(
        doseNumber: 1,
        status: DoseStatus.scheduled,
      );
      expect(info.status, DoseStatus.scheduled);
    });
  });

  group('DoseRecommendationInfo', () {
    test('必須フィールドのみで作成できる', () {
      const recommendation = DoseRecommendationInfo(
        doseNumber: 1,
        message: '接種時期のめやす\n2024年3月15日以降',
      );
      expect(recommendation.doseNumber, 1);
      expect(recommendation.message, contains('接種時期'));
      expect(recommendation.startDate, isNull);
      expect(recommendation.endDate, isNull);
    });

    test('全てのフィールドを指定できる', () {
      final startDate = DateTime(2024, 3, 15);
      final endDate = DateTime(2024, 4, 15);
      final recommendation = DoseRecommendationInfo(
        doseNumber: 2,
        message: '接種時期のめやす\n2024年3月15日〜2024年4月15日',
        startDate: startDate,
        endDate: endDate,
      );
      expect(recommendation.doseNumber, 2);
      expect(recommendation.startDate, startDate);
      expect(recommendation.endDate, endDate);
    });
  });

  group('VaccineDetailParams', () {
    test('パラメータを正しく保持する', () {
      final childBirthday = DateTime(2024, 1, 1);
      final params = VaccineDetailParams(
        vaccineId: 'hib',
        doseNumbers: const [1, 2, 3, 4],
        householdId: 'household-1',
        childId: 'child-1',
        childBirthday: childBirthday,
      );

      expect(params.vaccineId, 'hib');
      expect(params.doseNumbers, [1, 2, 3, 4]);
      expect(params.householdId, 'household-1');
      expect(params.childId, 'child-1');
      expect(params.childBirthday, childBirthday);
    });

    test('childBirthdayがnullでも作成できる', () {
      const params = VaccineDetailParams(
        vaccineId: 'hib',
        doseNumbers: [1, 2, 3, 4],
        householdId: 'household-1',
        childId: 'child-1',
        childBirthday: null,
      );

      expect(params.childBirthday, isNull);
    });

    test('同じパラメータは等しい', () {
      final childBirthday = DateTime(2024, 1, 1);
      final params1 = VaccineDetailParams(
        vaccineId: 'hib',
        doseNumbers: const [1, 2, 3, 4],
        householdId: 'household-1',
        childId: 'child-1',
        childBirthday: childBirthday,
      );
      final params2 = VaccineDetailParams(
        vaccineId: 'hib',
        doseNumbers: const [1, 2, 3, 4],
        householdId: 'household-1',
        childId: 'child-1',
        childBirthday: childBirthday,
      );

      expect(params1, equals(params2));
      expect(params1.hashCode, equals(params2.hashCode));
    });

    test('異なるvaccineIdは等しくない', () {
      const params1 = VaccineDetailParams(
        vaccineId: 'hib',
        doseNumbers: [1, 2, 3, 4],
        householdId: 'household-1',
        childId: 'child-1',
        childBirthday: null,
      );
      const params2 = VaccineDetailParams(
        vaccineId: 'pneumococcal',
        doseNumbers: [1, 2, 3, 4],
        householdId: 'household-1',
        childId: 'child-1',
        childBirthday: null,
      );

      expect(params1, isNot(equals(params2)));
    });

    test('異なるdoseNumbersは等しくない', () {
      const params1 = VaccineDetailParams(
        vaccineId: 'hib',
        doseNumbers: [1, 2, 3, 4],
        householdId: 'household-1',
        childId: 'child-1',
        childBirthday: null,
      );
      const params2 = VaccineDetailParams(
        vaccineId: 'hib',
        doseNumbers: [1, 2, 3],
        householdId: 'household-1',
        childId: 'child-1',
        childBirthday: null,
      );

      expect(params1, isNot(equals(params2)));
    });

    test('異なるhouseholdIdは等しくない', () {
      const params1 = VaccineDetailParams(
        vaccineId: 'hib',
        doseNumbers: [1, 2, 3, 4],
        householdId: 'household-1',
        childId: 'child-1',
        childBirthday: null,
      );
      const params2 = VaccineDetailParams(
        vaccineId: 'hib',
        doseNumbers: [1, 2, 3, 4],
        householdId: 'household-2',
        childId: 'child-1',
        childBirthday: null,
      );

      expect(params1, isNot(equals(params2)));
    });

    test('異なるchildIdは等しくない', () {
      const params1 = VaccineDetailParams(
        vaccineId: 'hib',
        doseNumbers: [1, 2, 3, 4],
        householdId: 'household-1',
        childId: 'child-1',
        childBirthday: null,
      );
      const params2 = VaccineDetailParams(
        vaccineId: 'hib',
        doseNumbers: [1, 2, 3, 4],
        householdId: 'household-1',
        childId: 'child-2',
        childBirthday: null,
      );

      expect(params1, isNot(equals(params2)));
    });

    test('異なるchildBirthdayは等しくない', () {
      final params1 = VaccineDetailParams(
        vaccineId: 'hib',
        doseNumbers: const [1, 2, 3, 4],
        householdId: 'household-1',
        childId: 'child-1',
        childBirthday: DateTime(2024, 1, 1),
      );
      final params2 = VaccineDetailParams(
        vaccineId: 'hib',
        doseNumbers: const [1, 2, 3, 4],
        householdId: 'household-1',
        childId: 'child-1',
        childBirthday: DateTime(2024, 2, 1),
      );

      expect(params1, isNot(equals(params2)));
    });
  });
}
