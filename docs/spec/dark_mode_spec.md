# ダークモード機能 設計書

## 概要

babymom-diary（milu）アプリにダークモード機能を実装する。ユーザーは「システム設定に追従」「ライトモード」「ダークモード」の3つから選択可能。

## 設計方針

- **テーマモード**: システム / ライト / ダーク の3択
- **設定配置**: メニュー画面に直接追加（専用ページは作成しない）
- **子どもの色との共存**: AppBar/NavigationBarは引き続き子どもの色を使用
- **段階的実装**: 基盤→基本UI→詳細UIの順で対応

---

## 1. アーキテクチャ

### 1.1 新規ファイル構成

```
flutter/lib/src/core/theme/
├── app_colors.dart              # 既存（変更なし）
├── app_theme.dart               # 既存（修正：Brightness引数追加）
├── app_theme_provider.dart      # 既存（修正：ThemeMode対応）
├── app_dark_colors.dart         # 新規：ダークモード用色定数
├── semantic_colors.dart         # 新規：テーマ対応色Extension
├── theme_mode_storage.dart      # 新規：設定永続化
└── theme_mode_provider.dart     # 新規：テーマモードProvider
```

### 1.2 データフロー

```
ユーザー選択 (システム/ライト/ダーク)
  → ThemeModeNotifier (Riverpod状態管理)
    → ThemeModeStorage (SharedPreferences永続化)
      → appThemeProvider (ThemeData生成)
        → MaterialApp.router (theme / darkTheme / themeMode)
```

---

## 2. 新規作成ファイル詳細

### 2.1 `theme_mode_storage.dart`

```dart
// flutter/lib/src/core/theme/theme_mode_storage.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeStorage {
  ThemeModeStorage(this._prefs);

  final SharedPreferences _prefs;
  static const _key = 'theme_mode';

  ThemeMode getThemeMode() {
    final value = _prefs.getString(_key);
    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await _prefs.setString(_key, value);
  }
}
```

### 2.2 `theme_mode_provider.dart`

```dart
// flutter/lib/src/core/theme/theme_mode_provider.dart
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../preferences/shared_preferences_provider.dart';
import 'theme_mode_storage.dart';

part 'theme_mode_provider.g.dart';

@riverpod
ThemeModeStorage themeModeStorage(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeModeStorage(prefs);
}

@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    final storage = ref.watch(themeModeStorageProvider);
    return storage.getThemeMode();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final storage = ref.read(themeModeStorageProvider);
    await storage.setThemeMode(mode);
    state = mode;
  }
}
```

### 2.3 `app_dark_colors.dart`

```dart
// flutter/lib/src/core/theme/app_dark_colors.dart
import 'package:flutter/material.dart';

class AppDarkColors {
  const AppDarkColors._();

  // Primary (明るめに調整してダーク背景で映えるように)
  static const Color primary = Color(0xFFFFB4C2);
  static const Color onPrimary = Color(0xFF5D1126);

  // Surface / Background
  static const Color surface = Color(0xFF1C1B1F);
  static const Color surfaceVariant = Color(0xFF2B2930);
  static const Color onSurface = Color(0xFFE6E1E5);
  static const Color onSurfaceVariant = Color(0xFFCAC4D0);

  // Outline
  static const Color outline = Color(0xFF49454F);
  static const Color outlineVariant = Color(0xFF79747E);

  // Vaccine badge colors (ダーク用に調整)
  static const Color vaccineInactivated = Color(0xFF4AE54E);
  static const Color vaccineLive = Color(0xFFFFAB40);
  static const Color reserved = Color(0xFFFFEE58);
  static const Color vaccinated = Color(0xFF69F0AE);

  // Weekday colors (ダーク用に調整)
  static const Color sunday = Color(0xFFFF8A80);
  static const Color saturday = Color(0xFF82B1FF);
}
```

### 2.4 `semantic_colors.dart`

```dart
// flutter/lib/src/core/theme/semantic_colors.dart
import 'package:flutter/material.dart';
import 'app_dark_colors.dart';

extension SemanticColorsExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // 背景色
  Color get menuSectionBackground => isDarkMode
      ? AppDarkColors.surfaceVariant
      : Colors.white;

  Color get menuSectionBorder => isDarkMode
      ? AppDarkColors.outline
      : const Color(0xFFE0E0E0);

  // テーブル行背景
  Color get tableRowEven => isDarkMode
      ? AppDarkColors.surface
      : Colors.white;

  Color get tableRowOdd => isDarkMode
      ? AppDarkColors.surfaceVariant
      : Colors.pink.shade50;

  // 曜日色
  Color get saturdayColor => isDarkMode
      ? AppDarkColors.saturday
      : Colors.blue;

  Color get sundayColor => isDarkMode
      ? AppDarkColors.sunday
      : Colors.red;

  // サブテキスト
  Color get subtextColor => isDarkMode
      ? AppDarkColors.onSurfaceVariant
      : Colors.black54;
}
```

---

## 3. 既存ファイル修正

### 3.1 `app_theme.dart` 修正

**変更点**: `buildTheme()` に `Brightness` 引数を追加

```dart
ThemeData buildTheme({
  Color? childColor,
  required Brightness brightness,
}) {
  final isDark = brightness == Brightness.dark;

  final scheme = isDark
      ? ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ).copyWith(
          primary: AppDarkColors.primary,
          surface: AppDarkColors.surface,
          onSurface: AppDarkColors.onSurface,
        )
      : ColorScheme.fromSeed(seedColor: AppColors.primary).copyWith(
          primary: AppColors.primary,
        );

  return base.copyWith(
    // ...
    scaffoldBackgroundColor: isDark ? AppDarkColors.surface : null,
    dialogTheme: DialogThemeData(
      backgroundColor: isDark ? AppDarkColors.surfaceVariant : Colors.white,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: isDark ? AppDarkColors.surfaceVariant : Colors.white,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: isDark ? AppDarkColors.surfaceVariant : Colors.white,
    ),
  );
}
```

### 3.2 `app_theme_provider.dart` 修正

**変更点**: ライト/ダーク両方のテーマを生成

```dart
@Riverpod(keepAlive: true)
ThemeData appTheme(Ref ref, String householdId) {
  // 既存の子どもの色取得ロジック...
  return buildTheme(childColor: selectedColor, brightness: Brightness.light);
}

@Riverpod(keepAlive: true)
ThemeData appDarkTheme(Ref ref, String householdId) {
  // 既存の子どもの色取得ロジック...
  return buildTheme(childColor: selectedColor, brightness: Brightness.dark);
}
```

### 3.3 `app_runner.dart` 修正

**変更点**: `darkTheme` と `themeMode` を追加

```dart
// build() メソッド内
final theme = ref.watch(appThemeProvider(householdId));
final darkTheme = ref.watch(appDarkThemeProvider(householdId));
final themeMode = ref.watch(themeModeNotifierProvider);

return MaterialApp.router(
  title: widget.appTitle,
  theme: theme,
  darkTheme: darkTheme,
  themeMode: themeMode,
  routerConfig: router,
  // ...
);
```

### 3.4 `menu_page.dart` 修正

**変更点**: テーマ設定のトグルを追加

メニューセクションに以下のような項目を追加:
- 「外観」セクション
- SegmentedButton で システム/ライト/ダーク を選択

---

## 4. 修正対象ファイル一覧（ハードコード色）

### Phase 2: 基本UI（優先度高）

| ファイル | 修正内容 |
|---------|---------|
| `flutter/lib/src/features/menu/presentation/widgets/menu_section.dart` | `Colors.white` → `context.menuSectionBackground` |
| `flutter/lib/src/features/onboarding/presentation/pages/onboarding_greeting_page.dart` | 白背景をテーマ対応 |
| `flutter/lib/src/features/calendar/presentation/widgets/calendar_day_cell.dart` | 土日の色を `context.saturdayColor` / `context.sundayColor` |

### Phase 3: 詳細UI（優先度中）

| ファイル | 修正内容 |
|---------|---------|
| `flutter/lib/src/features/child_record/presentation/widgets/record_table.dart` | テーブル背景色 |
| `flutter/lib/src/features/mom_record/presentation/components/shared_table_components.dart` | 土日の背景色 |
| `flutter/lib/src/features/vaccines/presentation/styles/vaccine_schedule_highlight_styles.dart` | `Colors.white` 混合 |
| `flutter/lib/src/features/baby_food/presentation/widgets/*.dart` | BottomSheet背景 |

---

## 5. 実装フェーズ

### Phase 1: 基盤構築

1. `theme_mode_storage.dart` 作成
2. `theme_mode_provider.dart` 作成
3. `app_dark_colors.dart` 作成
4. `semantic_colors.dart` 作成
5. `app_theme.dart` 修正（Brightness引数追加）
6. `app_theme_provider.dart` 修正（appDarkTheme追加）
7. `app_runner.dart` 修正（darkTheme, themeMode追加）
8. `menu_page.dart` にテーマ切り替えUI追加
9. コード生成（`dart run build_runner build`）

### Phase 2: 基本UI対応

- MenuSection の背景色
- OnboardingPage の背景色
- Calendar の曜日色

### Phase 3: 詳細UI対応

- テーブル系コンポーネント
- BottomSheet系
- ワクチン関連の色
- 離乳食関連の色

---

## 6. 検証方法

### 動作確認

```bash
cd flutter
rake run_stg
```

1. メニュー画面でテーマ切り替えが動作することを確認
2. 各モードで主要画面を確認:
   - ホーム画面
   - カレンダー画面
   - メニュー画面
   - 記録追加BottomSheet
3. アプリ再起動後も設定が保持されることを確認
4. システム設定を変更して追従することを確認

### テスト

```bash
cd flutter
fvm flutter test test/src/core/theme/
```

---

## 7. 主要ファイルパス

- `flutter/lib/src/core/theme/app_theme.dart`
- `flutter/lib/src/core/theme/app_theme_provider.dart`
- `flutter/lib/src/core/theme/app_colors.dart`
- `flutter/lib/src/app/app_runner.dart`
- `flutter/lib/src/features/menu/presentation/pages/menu_page.dart`
- `flutter/lib/src/core/preferences/shared_preferences_provider.dart`
