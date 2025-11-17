import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/firebase/household_service.dart';
import '../../application/usecases/accept_invitation.dart';
import '../../application/usecases/create_invitation.dart';
import '../../application/usecases/get_pending_invitations.dart';
import '../../domain/entities/invitation.dart';

final createInvitationUseCaseProvider = Provider<CreateInvitation>((ref) {
  final functions = ref.watch(firebaseFunctionsProvider);
  return CreateInvitation(functions);
});

final acceptInvitationUseCaseProvider = Provider<AcceptInvitation>((ref) {
  final functions = ref.watch(firebaseFunctionsProvider);
  return AcceptInvitation(functions);
});

final getPendingInvitationsUseCaseProvider =
    Provider<GetPendingInvitations>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return GetPendingInvitations(firestore);
});

final pendingInvitationsProvider =
    StreamProvider.family<List<Invitation>, String>((ref, householdId) {
  final useCase = ref.watch(getPendingInvitationsUseCaseProvider);
  return useCase(householdId);
});
