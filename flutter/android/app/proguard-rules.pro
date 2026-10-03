# Proguard rules for milu Flutter app

# Flutter standard rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.**  { *; }

# Keep native methods and classes used by JNI
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep Glance and Widget components
-keep class androidx.glance.** { *; }
-keep class com.aphlo.babymomdiary.widget.** { *; }

# Suppress missing class warnings for Play Core deferred components
-dontwarn com.google.android.play.core.**
