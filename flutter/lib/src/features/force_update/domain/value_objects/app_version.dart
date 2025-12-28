import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_version.freezed.dart';

/// アプリのセマンティックバージョンを表す値オブジェクト。
///
/// major.minor.patch 形式のバージョン比較をサポートする。
@freezed
sealed class AppVersion with _$AppVersion implements Comparable<AppVersion> {
  const AppVersion._();

  const factory AppVersion({
    required int major,
    required int minor,
    required int patch,
  }) = _AppVersion;

  /// バージョン文字列をパースして [AppVersion] を生成する。
  ///
  /// "1.2.3", "1.2", "1" などの形式を受け付ける。
  /// minor, patch が省略された場合は 0 として扱う。
  ///
  /// [version] が空文字列、不正な形式、数値以外を含む場合は
  /// [FormatException] をスローする。
  factory AppVersion.parse(String version) {
    if (version.isEmpty) {
      throw const FormatException('Version string cannot be empty');
    }

    final parts = version.split('.');
    if (parts.length > 3) {
      throw FormatException('Invalid version format: $version');
    }

    int parsePart(String part, String name) {
      final trimmed = part.trim();
      if (trimmed.isEmpty) {
        throw FormatException('Empty $name version in "$version"');
      }
      final value = int.tryParse(trimmed);
      if (value == null || value < 0) {
        throw FormatException('Invalid $name version: "$part" in "$version"');
      }
      return value;
    }

    return AppVersion(
      major: parsePart(parts[0], 'major'),
      minor: parts.length > 1 ? parsePart(parts[1], 'minor') : 0,
      patch: parts.length > 2 ? parsePart(parts[2], 'patch') : 0,
    );
  }

  @override
  int compareTo(AppVersion other) {
    if (major != other.major) return major.compareTo(other.major);
    if (minor != other.minor) return minor.compareTo(other.minor);
    return patch.compareTo(other.patch);
  }

  bool operator <(AppVersion other) => compareTo(other) < 0;
  bool operator >(AppVersion other) => compareTo(other) > 0;
  bool operator <=(AppVersion other) => compareTo(other) <= 0;
  bool operator >=(AppVersion other) => compareTo(other) >= 0;

  @override
  String toString() => '$major.$minor.$patch';
}
