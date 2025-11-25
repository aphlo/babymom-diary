import 'package:cloud_functions/cloud_functions.dart';

import '../../domain/errors/invitation_errors.dart';

class RemoveMember {
  RemoveMember(this._functions);

  final FirebaseFunctions _functions;

  Future<void> call({
    required String householdId,
    required String memberUid,
  }) async {
    try {
      final callable = _functions.httpsCallable('remove-member');
      await callable.call<Map<String, dynamic>>({
        'householdId': householdId,
        'memberUid': memberUid,
      });
    } on FirebaseFunctionsException catch (e) {
      switch (e.code) {
        case 'not-found':
          throw InvitationAcceptException(e.message ?? 'メンバーが見つかりません');
        case 'permission-denied':
          throw InvitationAcceptException(e.message ?? '権限がありません');
        case 'invalid-argument':
          throw InvitationAcceptException(e.message ?? '不正なリクエストです');
        default:
          throw InvitationAcceptException(e.message ?? 'エラーが発生しました');
      }
    } catch (e) {
      throw InvitationAcceptException(e.toString());
    }
  }
}
