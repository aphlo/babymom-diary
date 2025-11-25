class InvitationException implements Exception {
  const InvitationException(this.message);
  final String message;

  @override
  String toString() => 'InvitationException: $message';
}

class InvitationNotFoundException extends InvitationException {
  const InvitationNotFoundException() : super('招待コードが見つからないか、既に使用されています');
}

class AlreadyMemberException extends InvitationException {
  const AlreadyMemberException() : super('既にこの世帯のメンバーです');
}

class InvitationAcceptException extends InvitationException {
  const InvitationAcceptException([String? message])
      : super(message ?? '招待の承認中にエラーが発生しました');
}
