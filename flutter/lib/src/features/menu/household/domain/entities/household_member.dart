import 'package:meta/meta.dart';

@immutable
class HouseholdMember {
  const HouseholdMember({
    required this.uid,
    required this.displayName,
    required this.role,
    required this.joinedAt,
  });

  final String uid;
  final String displayName;
  final String role; // 'admin' or 'member'
  final DateTime joinedAt;

  bool get isAdmin => role == 'admin';
}
