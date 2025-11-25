import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/firebase/household_service.dart';
import '../../application/usecases/accept_invitation.dart';
import '../../domain/entities/household_member.dart';
import '../../infrastructure/sources/household_members_firestore_data_source.dart';

final acceptInvitationUseCaseProvider = Provider<AcceptInvitation>((ref) {
  final functions = ref.watch(firebaseFunctionsProvider);
  return AcceptInvitation(functions);
});

final householdMembersDataSourceProvider =
    Provider<HouseholdMembersFirestoreDataSource>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return HouseholdMembersFirestoreDataSource(firestore);
});

final householdMembersProvider =
    StreamProvider.family<List<HouseholdMember>, String>((ref, householdId) {
  final dataSource = ref.watch(householdMembersDataSourceProvider);
  return dataSource.watchMembers(householdId);
});
