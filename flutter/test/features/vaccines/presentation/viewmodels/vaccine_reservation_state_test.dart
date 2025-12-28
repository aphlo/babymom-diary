import 'package:flutter_test/flutter_test.dart';

import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccination_record.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_category.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_record_type.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_requirement.dart';
import 'package:babymom_diary/src/features/vaccines/presentation/models/vaccine_info.dart';
import 'package:babymom_diary/src/features/vaccines/presentation/viewmodels/vaccine_reservation_state.dart';

void main() {
  group('VaccineReservationState', () {
    late VaccineReservationState state;
    late VaccineInfo testVaccine;

    setUp(() {
      testVaccine = const VaccineInfo(
        id: 'hib',
        name: 'ヒブ',
        category: VaccineCategory.inactivated,
        requirement: VaccineRequirement.mandatory,
      );
      state = const VaccineReservationState();
    });

    test('初期状態が正しい', () {
      expect(state.isLoading, false);
      expect(state.error, isNull);
      expect(state.isDuplicateError, false);
      expect(state.primaryVaccine, isNull);
      expect(state.primaryDoseNumber, isNull);
      expect(state.scheduledDate, isNull);
      expect(state.availableVaccines, isEmpty);
      expect(state.selectedAdditionalVaccines, isEmpty);
      expect(state.isAccordionExpanded, false);
      expect(state.isSubmitting, false);
      expect(state.recordType, VaccineRecordType.scheduled);
    });

    group('canSubmit', () {
      test('必須項目が全てnullの場合はfalse', () {
        expect(state.canSubmit, false);
      });

      test('primaryVaccineのみ設定の場合はfalse', () {
        final s = state.copyWith(primaryVaccine: testVaccine);
        expect(s.canSubmit, false);
      });

      test('primaryVaccineとprimaryDoseNumberのみ設定の場合はfalse', () {
        final s = state.copyWith(
          primaryVaccine: testVaccine,
          primaryDoseNumber: 1,
        );
        expect(s.canSubmit, false);
      });

      test('全ての必須項目が設定されている場合はtrue', () {
        final s = state.copyWith(
          primaryVaccine: testVaccine,
          primaryDoseNumber: 1,
          scheduledDate: DateTime(2024, 3, 15),
        );
        expect(s.canSubmit, true);
      });

      test('isSubmitting中はfalse', () {
        final s = state.copyWith(
          primaryVaccine: testVaccine,
          primaryDoseNumber: 1,
          scheduledDate: DateTime(2024, 3, 15),
          isSubmitting: true,
        );
        expect(s.canSubmit, false);
      });
    });

    group('hasConcurrentVaccines', () {
      test('同時接種ワクチンが選択されていない場合はfalse', () {
        expect(state.hasConcurrentVaccines, false);
      });

      test('同時接種ワクチンが選択されている場合はtrue', () {
        final now = DateTime(2024, 3, 15);
        final record = VaccinationRecord(
          vaccineId: 'pneumococcal',
          vaccineName: '肺炎球菌',
          category: VaccineCategory.inactivated,
          requirement: VaccineRequirement.mandatory,
          doses: const [],
          createdAt: now,
          updatedAt: now,
        );

        final s = state.copyWith(selectedAdditionalVaccines: [record]);
        expect(s.hasConcurrentVaccines, true);
      });
    });

    group('generateReservationRequests', () {
      test('必須項目が不足している場合は空リストを返す', () {
        final requests = state.generateReservationRequests('child-1');
        expect(requests, isEmpty);
      });

      test('primaryVaccineがnullの場合は空リストを返す', () {
        final s = state.copyWith(
          primaryDoseNumber: 1,
          scheduledDate: DateTime(2024, 3, 15),
        );
        final requests = s.generateReservationRequests('child-1');
        expect(requests, isEmpty);
      });

      test('primaryDoseNumberがnullの場合は空リストを返す', () {
        final s = state.copyWith(
          primaryVaccine: testVaccine,
          scheduledDate: DateTime(2024, 3, 15),
        );
        final requests = s.generateReservationRequests('child-1');
        expect(requests, isEmpty);
      });

      test('scheduledDateがnullの場合は空リストを返す', () {
        final s = state.copyWith(
          primaryVaccine: testVaccine,
          primaryDoseNumber: 1,
        );
        final requests = s.generateReservationRequests('child-1');
        expect(requests, isEmpty);
      });

      test('メインのワクチンのみの予約リクエストを生成', () {
        final s = state.copyWith(
          primaryVaccine: testVaccine,
          primaryDoseNumber: 1,
          scheduledDate: DateTime(2024, 3, 15),
        );

        final requests = s.generateReservationRequests('child-1');
        expect(requests.length, 1);
        expect(requests[0].childId, 'child-1');
        expect(requests[0].vaccineId, 'hib');
        expect(requests[0].scheduledDate, DateTime(2024, 3, 15));
        expect(requests[0].recordType, VaccineRecordType.scheduled);
      });

      test('recordTypeがcompletedの場合は予約リクエストに反映される', () {
        final s = state.copyWith(
          primaryVaccine: testVaccine,
          primaryDoseNumber: 1,
          scheduledDate: DateTime(2024, 3, 15),
          recordType: VaccineRecordType.completed,
        );

        final requests = s.generateReservationRequests('child-1');
        expect(requests[0].recordType, VaccineRecordType.completed);
      });

      test('同時接種ワクチンも含めた予約リクエストを生成', () {
        final now = DateTime(2024, 3, 15);
        final additionalRecord = VaccinationRecord(
          vaccineId: 'pneumococcal',
          vaccineName: '肺炎球菌',
          category: VaccineCategory.inactivated,
          requirement: VaccineRequirement.mandatory,
          doses: const [],
          createdAt: now,
          updatedAt: now,
        );

        final s = state.copyWith(
          primaryVaccine: testVaccine,
          primaryDoseNumber: 1,
          scheduledDate: now,
          selectedAdditionalVaccines: [additionalRecord],
        );

        final requests = s.generateReservationRequests('child-1');
        expect(requests.length, 2);
        expect(requests[0].vaccineId, 'hib');
        expect(requests[1].vaccineId, 'pneumococcal');
      });
    });

    group('copyWith', () {
      test('isLoading を更新できる', () {
        final s = state.copyWith(isLoading: true);
        expect(s.isLoading, true);
      });

      test('error を更新できる', () {
        final s = state.copyWith(error: 'エラーメッセージ');
        expect(s.error, 'エラーメッセージ');
      });

      test('isDuplicateError を更新できる', () {
        final s = state.copyWith(isDuplicateError: true);
        expect(s.isDuplicateError, true);
      });

      test('primaryVaccine を更新できる', () {
        final s = state.copyWith(primaryVaccine: testVaccine);
        expect(s.primaryVaccine, testVaccine);
      });

      test('primaryDoseNumber を更新できる', () {
        final s = state.copyWith(primaryDoseNumber: 2);
        expect(s.primaryDoseNumber, 2);
      });

      test('scheduledDate を更新できる', () {
        final date = DateTime(2024, 4, 1);
        final s = state.copyWith(scheduledDate: date);
        expect(s.scheduledDate, date);
      });

      test('isAccordionExpanded を更新できる', () {
        final s = state.copyWith(isAccordionExpanded: true);
        expect(s.isAccordionExpanded, true);
      });

      test('isSubmitting を更新できる', () {
        final s = state.copyWith(isSubmitting: true);
        expect(s.isSubmitting, true);
      });

      test('recordType を更新できる', () {
        final s = state.copyWith(recordType: VaccineRecordType.completed);
        expect(s.recordType, VaccineRecordType.completed);
      });

      test('copyWithは指定していないerrorを保持する', () {
        final s1 = state.copyWith(error: 'エラー');
        final s2 = s1.copyWith(isLoading: true);
        expect(s2.error, 'エラー');
      });

      test('copyWithは指定していないisDuplicateErrorを保持する', () {
        final s1 = state.copyWith(isDuplicateError: true);
        final s2 = s1.copyWith(isLoading: true);
        expect(s2.isDuplicateError, true);
      });
    });

    group('clearError', () {
      test('errorとisDuplicateErrorがクリアされる', () {
        final s = state.copyWith(
          error: 'エラーメッセージ',
          isDuplicateError: true,
        );

        final cleared = s.clearError();
        expect(cleared.error, isNull);
        expect(cleared.isDuplicateError, false);
      });
    });

    group('equality', () {
      test('同じ状態のインスタンスは等しい', () {
        const s1 = VaccineReservationState();
        const s2 = VaccineReservationState();
        expect(s1, equals(s2));
        expect(s1.hashCode, equals(s2.hashCode));
      });

      test('異なる状態のインスタンスは等しくない', () {
        const s1 = VaccineReservationState();
        final s2 = s1.copyWith(isLoading: true);
        expect(s1, isNot(equals(s2)));
      });
    });

    test('toString は状態を文字列で返す', () {
      final str = state.toString();
      expect(str, contains('VaccineReservationState'));
      expect(str, contains('isLoading: false'));
    });
  });

  group('VaccineReservationParams', () {
    test('パラメータを正しく保持する', () {
      const vaccine = VaccineInfo(
        id: 'hib',
        name: 'ヒブ',
        category: VaccineCategory.inactivated,
        requirement: VaccineRequirement.mandatory,
      );
      const params = VaccineReservationParams(
        vaccine: vaccine,
        doseNumber: 1,
      );

      expect(params.vaccine.id, 'hib');
      expect(params.doseNumber, 1);
    });

    test('同じパラメータは等しい', () {
      const vaccine = VaccineInfo(
        id: 'hib',
        name: 'ヒブ',
        category: VaccineCategory.inactivated,
        requirement: VaccineRequirement.mandatory,
      );
      const params1 = VaccineReservationParams(vaccine: vaccine, doseNumber: 1);
      const params2 = VaccineReservationParams(vaccine: vaccine, doseNumber: 1);

      expect(params1, equals(params2));
      expect(params1.hashCode, equals(params2.hashCode));
    });

    test('異なるdoseNumberは等しくない', () {
      const vaccine = VaccineInfo(
        id: 'hib',
        name: 'ヒブ',
        category: VaccineCategory.inactivated,
        requirement: VaccineRequirement.mandatory,
      );
      const params1 = VaccineReservationParams(vaccine: vaccine, doseNumber: 1);
      const params2 = VaccineReservationParams(vaccine: vaccine, doseNumber: 2);

      expect(params1, isNot(equals(params2)));
    });
  });
}
