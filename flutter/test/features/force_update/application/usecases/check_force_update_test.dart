import 'package:babymom_diary/src/features/force_update/application/usecases/check_force_update.dart';
import 'package:babymom_diary/src/features/force_update/domain/entities/update_requirement.dart';
import 'package:babymom_diary/src/features/force_update/domain/repositories/update_config_repository.dart';
import 'package:babymom_diary/src/features/force_update/domain/value_objects/app_version.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MockUpdateConfigRepository extends Mock
    implements UpdateConfigRepository {}

void main() {
  late MockUpdateConfigRepository mockRepository;
  late CheckForceUpdate useCase;

  setUp(() {
    mockRepository = MockUpdateConfigRepository();
    PackageInfo.setMockInitialValues(
      appName: 'Test App',
      packageName: 'com.example.test',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
  });

  Future<CheckForceUpdate> createUseCase() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return CheckForceUpdate(mockRepository, packageInfo);
  }

  group('CheckForceUpdate', () {
    test('現在のバージョンが最小バージョンより低い場合、UpdateRequirementを返す', () async {
      // Arrange
      PackageInfo.setMockInitialValues(
        appName: 'Test App',
        packageName: 'com.example.test',
        version: '1.0.0',
        buildNumber: '1',
        buildSignature: '',
      );
      useCase = await createUseCase();

      final requirement = UpdateRequirement(
        minimumVersion: AppVersion.parse('1.1.0'),
        message: 'アップデートしてください',
        storeUrl: 'https://example.com',
      );
      when(() => mockRepository.getUpdateRequirement())
          .thenAnswer((_) async => requirement);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, isNotNull);
      expect(result!.minimumVersion, equals(AppVersion.parse('1.1.0')));
    });

    test('現在のバージョンが最小バージョンと等しい場合、nullを返す', () async {
      // Arrange
      PackageInfo.setMockInitialValues(
        appName: 'Test App',
        packageName: 'com.example.test',
        version: '1.1.0',
        buildNumber: '1',
        buildSignature: '',
      );
      useCase = await createUseCase();

      final requirement = UpdateRequirement(
        minimumVersion: AppVersion.parse('1.1.0'),
        message: 'アップデートしてください',
        storeUrl: 'https://example.com',
      );
      when(() => mockRepository.getUpdateRequirement())
          .thenAnswer((_) async => requirement);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, isNull);
    });

    test('現在のバージョンが最小バージョンより高い場合、nullを返す', () async {
      // Arrange
      PackageInfo.setMockInitialValues(
        appName: 'Test App',
        packageName: 'com.example.test',
        version: '2.0.0',
        buildNumber: '1',
        buildSignature: '',
      );
      useCase = await createUseCase();

      final requirement = UpdateRequirement(
        minimumVersion: AppVersion.parse('1.1.0'),
        message: 'アップデートしてください',
        storeUrl: 'https://example.com',
      );
      when(() => mockRepository.getUpdateRequirement())
          .thenAnswer((_) async => requirement);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, isNull);
    });

    test('パッチバージョンの差でも正しく比較できる', () async {
      // Arrange
      PackageInfo.setMockInitialValues(
        appName: 'Test App',
        packageName: 'com.example.test',
        version: '1.0.2',
        buildNumber: '1',
        buildSignature: '',
      );
      useCase = await createUseCase();

      final requirement = UpdateRequirement(
        minimumVersion: AppVersion.parse('1.0.3'),
        message: 'アップデートしてください',
        storeUrl: 'https://example.com',
      );
      when(() => mockRepository.getUpdateRequirement())
          .thenAnswer((_) async => requirement);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, isNotNull);
    });
  });
}
