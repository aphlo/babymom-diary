import 'package:cloud_functions/cloud_functions.dart';

import '../../domain/errors/invitation_errors.dart';

class AcceptInvitation {
  AcceptInvitation(this._functions);

  final FirebaseFunctions _functions;

  Future<String> call(String invitationCode) async {
    try {
      final callable = _functions.httpsCallable('accept-invitation');
      final result = await callable.call<Map<String, dynamic>>({
        'code': invitationCode.trim().toUpperCase(),
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
          throw const InvitationExpiredException();
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
