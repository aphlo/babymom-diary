class InvitationException implements Exception {
  const InvitationException(this.message);
  final String message;

  @override
  String toString() => 'InvitationException: $message';
}

class InvitationNotFoundException extends InvitationException {
  const InvitationNotFoundException() : super('招待コードが見つからないか、既に使用されています');
}

class InvitationExpiredException extends InvitationException {
  const InvitationExpiredException() : super('招待コードの有効期限が切れています');
}

class AlreadyMemberException extends InvitationException {
  const AlreadyMemberException() : super('既にこの世帯のメンバーです');
}

class InvitationPermissionDeniedException extends InvitationException {
  const InvitationPermissionDeniedException() : super('招待コードの作成権限がありません');
}

class InvalidClientException extends InvitationException {
  const InvalidClientException() : super('不正なクライアントからのリクエストです');
}

class InvitationAcceptException extends InvitationException {
  const InvitationAcceptException([String? message])
      : super(message ?? '招待の承認中にエラーが発生しました');
}
