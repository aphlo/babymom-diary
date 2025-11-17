import 'package:meta/meta.dart';

@immutable
class Invitation {
  const Invitation({
    required this.id,
    required this.code,
    required this.createdBy,
    required this.createdAt,
    required this.expiresAt,
    required this.status,
    this.acceptedBy,
    this.acceptedAt,
  });

  final String id;
  final String code;
  final String createdBy;
  final DateTime createdAt;
  final DateTime expiresAt;
  final InvitationStatus status;
  final String? acceptedBy;
  final DateTime? acceptedAt;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get isPending => status == InvitationStatus.pending && !isExpired;
}

enum InvitationStatus {
  pending,
  accepted,
  expired,
}
