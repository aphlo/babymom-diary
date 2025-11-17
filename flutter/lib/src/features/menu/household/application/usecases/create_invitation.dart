import 'package:cloud_functions/cloud_functions.dart';

import '../../domain/errors/invitation_errors.dart';

class CreateInvitationResult {
  const CreateInvitationResult({
    required this.invitationId,
    required this.code,
    required this.expiresAt,
  });

  final String invitationId;
  final String code;
  final DateTime expiresAt;
}

class CreateInvitation {
  CreateInvitation(this._functions);

  final FirebaseFunctions _functions;

  Future<CreateInvitationResult> call(String householdId) async {
    try {
      final callable = _functions.httpsCallable('create-invitation');
      final result = await callable.call<Map<String, dynamic>>({
        'householdId': householdId,
      });

      final data = result.data;

      return CreateInvitationResult(
        invitationId: data['invitationId'] as String,
        code: data['code'] as String,
        expiresAt: DateTime.parse(data['expiresAt'] as String),
      );
    } on FirebaseFunctionsException catch (e) {
      switch (e.code) {
        case 'not-found':
          throw InvitationException('世帯が見つかりません: ${e.message}');
        case 'permission-denied':
          throw const InvitationPermissionDeniedException();
        case 'unauthenticated':
          throw const InvitationAcceptException('認証が必要です');
        case 'internal':
          throw InvitationException('サーバーエラー: ${e.message}');
        default:
          throw InvitationException(e.message ?? 'Unknown error: ${e.code}');
      }
    } catch (e) {
      if (e is InvitationException) rethrow;
      throw InvitationAcceptException(e.toString());
    }
  }
}
