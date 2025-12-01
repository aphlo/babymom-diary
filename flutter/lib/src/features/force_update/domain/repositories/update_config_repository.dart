import '../entities/update_requirement.dart';

abstract class UpdateConfigRepository {
  Future<UpdateRequirement> getUpdateRequirement();
}
