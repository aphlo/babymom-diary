import 'package:cloud_functions/cloud_functions.dart';

import '../../domain/errors/invitation_errors.dart';

class AcceptInvitation {
  AcceptInvitation(this._functions);

  final FirebaseFunctions _functions;

  Future<String> call({
    required String householdId,
    required String displayName,
  }) async {
    try {
      final callable = _functions.httpsCallable('accept-invitation');
      final result = await callable.call<Map<String, dynamic>>({
        'householdId': householdId.trim(),
        'displayName': displayName.trim(),
      });

      final data = result.data;
      if (data['householdId'] == null) {
        throw const InvitationAcceptException('Invalid response from server');
      }

      return data['householdId'] as String;
    } on FirebaseFunctionsException catch (e) {
      switch (e.code) {
        case 'not-found':
          throw const InvitationNotFoundException();
        case 'already-exists':
          throw const AlreadyMemberException();
        case 'failed-precondition':
          throw InvitationAcceptException(e.message ?? '世帯への参加に失敗しました');
        case 'invalid-argument':
          throw InvitationAcceptException(e.message);
        case 'unauthenticated':
          throw const InvitationAcceptException('認証が必要です');
        default:
          throw InvitationAcceptException(e.message ?? 'Unknown error');
      }
    } catch (e) {
      if (e is InvitationException) rethrow;
      throw InvitationAcceptException(e.toString());
    }
  }
}
