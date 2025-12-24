import 'package:freezed_annotation/freezed_annotation.dart';

part 'household_member.freezed.dart';

@freezed
sealed class HouseholdMember with _$HouseholdMember {
  const HouseholdMember._();

  const factory HouseholdMember({
    required String uid,
    required String displayName,
    required String role, // 'admin' or 'member'
    required DateTime joinedAt,
  }) = _HouseholdMember;

  bool get isAdmin => role == 'admin';
}
