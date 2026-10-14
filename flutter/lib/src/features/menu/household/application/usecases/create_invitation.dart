import 'package:cloud_functions/cloud_functions.dart';

class CreateInvitation {
  CreateInvitation(this._functions);
  final FirebaseFunctions _functions;

  Future<String> call(String householdId) async {
    final result = await _functions
        .httpsCallable('create-invitation')
        .call<Map<String, dynamic>>({'householdId': householdId});
    return result.data['token'] as String;
  }
}
