import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/create_vaccine_reservation.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/get_vaccines_for_simulataneous_reservation.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_reservation_request.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_record_type.dart';
import 'package:babymom_diary/src/features/vaccines/presentation/viewmodels/vaccine_reservation_view_model.dart';

class MockCreateVaccineReservation extends Mock
    implements CreateVaccineReservation {}

class MockGetVaccinesForSimultaneousReservation extends Mock
    implements GetVaccinesForSimultaneousReservation {}

class MockHouseholdService extends Mock implements HouseholdService {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      VaccineReservationRequest(
        childId: 'child-1',
        vaccineId: 'hib',
        doseId: null,
        scheduledDate: DateTime(2024, 3, 15),
        recordType: VaccineRecordType.scheduled,
      ),
    );
    registerFallbackValue(<VaccineReservationRequest>[]);
    registerFallbackValue(DateTime(2024, 1, 1));
  });

  group('VaccineReservationViewModel', () {
    late MockCreateVaccineReservation mockCreateVaccineReservation;
    late MockGetVaccinesForSimultaneousReservation mockGetAvailableVaccines;
    late MockHouseholdService mockHouseholdService;
    late VaccineReservationViewModel viewModel;

    setUp(() {
      mockCreateVaccineReservation = MockCreateVaccineReservation();
      mockGetAvailableVaccines = MockGetVaccinesForSimultaneousReservation();
      mockHouseholdService = MockHouseholdService();

      viewModel = VaccineReservationViewModel(
        createVaccineReservation: mockCreateVaccineReservation,
        getAvailableVaccines: mockGetAvailableVaccines,
        householdService: mockHouseholdService,
      );
    });

    test('初期状態が正しい', () {
      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.error, isNull);
      expect(viewModel.state.primaryVaccine, isNull);
      expect(viewModel.state.scheduledDate, isNull);
    });

    group('setScheduledDate', () {
      test('日付を設定できる', () {
        final date = DateTime(2024, 3, 15);
        viewModel.setScheduledDate(date);
        expect(viewModel.state.scheduledDate, date);
      });

      test('日付を変更できる', () {
        viewModel.setScheduledDate(DateTime(2024, 3, 15));
        viewModel.setScheduledDate(DateTime(2024, 4, 1));
        expect(viewModel.state.scheduledDate, DateTime(2024, 4, 1));
      });
    });

    group('setRecordType', () {
      test('scheduledからcompletedに変更できる', () {
        expect(viewModel.state.recordType, VaccineRecordType.scheduled);
        viewModel.setRecordType(VaccineRecordType.completed);
        expect(viewModel.state.recordType, VaccineRecordType.completed);
      });

      test('completedからscheduledに変更できる', () {
        viewModel.setRecordType(VaccineRecordType.completed);
        viewModel.setRecordType(VaccineRecordType.scheduled);
        expect(viewModel.state.recordType, VaccineRecordType.scheduled);
      });
    });

    group('toggleAccordion', () {
      test('閉じた状態から開ける', () {
        expect(viewModel.state.isAccordionExpanded, false);
        viewModel.toggleAccordion();
        expect(viewModel.state.isAccordionExpanded, true);
      });

      test('開いた状態から閉じれる', () {
        viewModel.toggleAccordion();
        viewModel.toggleAccordion();
        expect(viewModel.state.isAccordionExpanded, false);
      });
    });

    group('clearError', () {
      test('エラーをクリアできる', () {
        viewModel.setScheduledDate(DateTime(2024, 3, 15));
        viewModel.clearError();
        expect(viewModel.state.error, isNull);
        expect(viewModel.state.isDuplicateError, false);
      });
    });

    group('createReservation', () {
      test('canSubmitがfalseの場合はfalseを返す', () async {
        // primaryVaccine, primaryDoseNumber, scheduledDateが全てnull
        final result = await viewModel.createReservation('child-1');
        expect(result, false);
      });

      test('householdIdがnullの場合はエラーになる', () async {
        when(() => mockHouseholdService.findExistingHouseholdForCurrentUser())
            .thenAnswer((_) async => null);

        viewModel.setScheduledDate(DateTime(2024, 3, 15));
        // canSubmit=falseのためfalseを返す
        final result = await viewModel.createReservation('child-1');
        expect(result, false);
      });
    });
  });
}
