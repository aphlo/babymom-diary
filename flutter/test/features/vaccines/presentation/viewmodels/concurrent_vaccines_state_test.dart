import 'package:flutter_test/flutter_test.dart';

import 'package:babymom_diary/src/features/vaccines/presentation/viewmodels/concurrent_vaccines_state.dart';

void main() {
  group('ConcurrentVaccinesState', () {
    test('初期状態が正しい', () {
      const state = ConcurrentVaccinesState();

      expect(state.isLoading, false);
      expect(state.error, isNull);
      expect(state.members, isEmpty);
    });

    group('copyWith', () {
      test('isLoading を更新できる', () {
        const state = ConcurrentVaccinesState();
        final newState = state.copyWith(isLoading: true);
        expect(newState.isLoading, true);
      });

      test('error を更新できる', () {
        const state = ConcurrentVaccinesState();
        final newState = state.copyWith(error: 'エラーメッセージ');
        expect(newState.error, 'エラーメッセージ');
      });

      test('members を更新できる', () {
        const state = ConcurrentVaccinesState();
        const member = ConcurrentVaccineMember(
          vaccineId: 'hib',
          vaccineName: 'ヒブ',
          doseId: 'dose-1',
          doseNumber: 1,
        );
        final newState = state.copyWith(members: [member]);
        expect(newState.members.length, 1);
        expect(newState.members[0].vaccineId, 'hib');
      });

      test('複数のmembersを設定できる', () {
        const state = ConcurrentVaccinesState();
        const members = [
          ConcurrentVaccineMember(
            vaccineId: 'hib',
            vaccineName: 'ヒブ',
            doseId: 'dose-1',
            doseNumber: 1,
          ),
          ConcurrentVaccineMember(
            vaccineId: 'pneumococcal',
            vaccineName: '肺炎球菌',
            doseId: 'dose-2',
            doseNumber: 1,
          ),
        ];
        final newState = state.copyWith(members: members);
        expect(newState.members.length, 2);
        expect(newState.members[0].vaccineId, 'hib');
        expect(newState.members[1].vaccineId, 'pneumococcal');
      });
    });
  });

  group('ConcurrentVaccineMember', () {
    test('全てのフィールドを正しく保持する', () {
      const member = ConcurrentVaccineMember(
        vaccineId: 'hib',
        vaccineName: 'ヒブ',
        doseId: 'dose-123',
        doseNumber: 2,
      );

      expect(member.vaccineId, 'hib');
      expect(member.vaccineName, 'ヒブ');
      expect(member.doseId, 'dose-123');
      expect(member.doseNumber, 2);
    });

    test('doseNumberが正しく設定される', () {
      const member = ConcurrentVaccineMember(
        vaccineId: 'pneumococcal',
        vaccineName: '肺炎球菌',
        doseId: 'dose-456',
        doseNumber: 3,
      );

      expect(member.doseNumber, 3);
    });
  });

  group('ConcurrentVaccinesParams', () {
    test('パラメータを正しく保持する', () {
      const params = ConcurrentVaccinesParams(
        householdId: 'household-1',
        childId: 'child-1',
        reservationGroupId: 'group-123',
        currentVaccineId: 'hib',
        currentDoseId: 'dose-1',
      );

      expect(params.householdId, 'household-1');
      expect(params.childId, 'child-1');
      expect(params.reservationGroupId, 'group-123');
      expect(params.currentVaccineId, 'hib');
      expect(params.currentDoseId, 'dose-1');
    });

    test('同じパラメータは等しい', () {
      const params1 = ConcurrentVaccinesParams(
        householdId: 'household-1',
        childId: 'child-1',
        reservationGroupId: 'group-123',
        currentVaccineId: 'hib',
        currentDoseId: 'dose-1',
      );
      const params2 = ConcurrentVaccinesParams(
        householdId: 'household-1',
        childId: 'child-1',
        reservationGroupId: 'group-123',
        currentVaccineId: 'hib',
        currentDoseId: 'dose-1',
      );

      expect(params1, equals(params2));
      expect(params1.hashCode, equals(params2.hashCode));
    });

    test('異なるhouseholdIdは等しくない', () {
      const params1 = ConcurrentVaccinesParams(
        householdId: 'household-1',
        childId: 'child-1',
        reservationGroupId: 'group-123',
        currentVaccineId: 'hib',
        currentDoseId: 'dose-1',
      );
      const params2 = ConcurrentVaccinesParams(
        householdId: 'household-2',
        childId: 'child-1',
        reservationGroupId: 'group-123',
        currentVaccineId: 'hib',
        currentDoseId: 'dose-1',
      );

      expect(params1, isNot(equals(params2)));
    });

    test('異なるchildIdは等しくない', () {
      const params1 = ConcurrentVaccinesParams(
        householdId: 'household-1',
        childId: 'child-1',
        reservationGroupId: 'group-123',
        currentVaccineId: 'hib',
        currentDoseId: 'dose-1',
      );
      const params2 = ConcurrentVaccinesParams(
        householdId: 'household-1',
        childId: 'child-2',
        reservationGroupId: 'group-123',
        currentVaccineId: 'hib',
        currentDoseId: 'dose-1',
      );

      expect(params1, isNot(equals(params2)));
    });

    test('異なるreservationGroupIdは等しくない', () {
      const params1 = ConcurrentVaccinesParams(
        householdId: 'household-1',
        childId: 'child-1',
        reservationGroupId: 'group-123',
        currentVaccineId: 'hib',
        currentDoseId: 'dose-1',
      );
      const params2 = ConcurrentVaccinesParams(
        householdId: 'household-1',
        childId: 'child-1',
        reservationGroupId: 'group-456',
        currentVaccineId: 'hib',
        currentDoseId: 'dose-1',
      );

      expect(params1, isNot(equals(params2)));
    });

    test('異なるcurrentVaccineIdは等しくない', () {
      const params1 = ConcurrentVaccinesParams(
        householdId: 'household-1',
        childId: 'child-1',
        reservationGroupId: 'group-123',
        currentVaccineId: 'hib',
        currentDoseId: 'dose-1',
      );
      const params2 = ConcurrentVaccinesParams(
        householdId: 'household-1',
        childId: 'child-1',
        reservationGroupId: 'group-123',
        currentVaccineId: 'pneumococcal',
        currentDoseId: 'dose-1',
      );

      expect(params1, isNot(equals(params2)));
    });

    test('異なるcurrentDoseIdは等しくない', () {
      const params1 = ConcurrentVaccinesParams(
        householdId: 'household-1',
        childId: 'child-1',
        reservationGroupId: 'group-123',
        currentVaccineId: 'hib',
        currentDoseId: 'dose-1',
      );
      const params2 = ConcurrentVaccinesParams(
        householdId: 'household-1',
        childId: 'child-1',
        reservationGroupId: 'group-123',
        currentVaccineId: 'hib',
        currentDoseId: 'dose-2',
      );

      expect(params1, isNot(equals(params2)));
    });
  });
}
