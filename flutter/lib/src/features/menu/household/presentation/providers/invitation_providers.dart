import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/firebase/household_service.dart';
import '../../application/usecases/accept_invitation.dart';
import '../../application/usecases/remove_member.dart';
import '../../domain/entities/household_member.dart';
import '../../infrastructure/sources/household_members_firestore_data_source.dart';

part 'invitation_providers.g.dart';

@riverpod
AcceptInvitation acceptInvitationUseCase(Ref ref) {
  final functions = ref.watch(firebaseFunctionsProvider);
  return AcceptInvitation(functions);
}

@riverpod
RemoveMember removeMemberUseCase(Ref ref) {
  final functions = ref.watch(firebaseFunctionsProvider);
  return RemoveMember(functions);
}

@riverpod
HouseholdMembersFirestoreDataSource householdMembersDataSource(Ref ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return HouseholdMembersFirestoreDataSource(firestore);
}

@riverpod
Stream<List<HouseholdMember>> householdMembers(Ref ref, String householdId) {
  final dataSource = ref.watch(householdMembersDataSourceProvider);
  return dataSource.watchMembers(householdId);
}
