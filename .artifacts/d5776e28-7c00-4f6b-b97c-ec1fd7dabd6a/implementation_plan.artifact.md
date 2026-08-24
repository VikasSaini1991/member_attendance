# Implementation Plan - Re-applying Permanent CI/CD Fixes

This plan re-applies the definitive fixes for asset bundling and toolchain compatibility that were previously reverted. This ensures the CI/CD pipeline remains green and future-proofed.

## User Review Required

> [!IMPORTANT]
> **Placeholder Commitment**: I will be committing a dummy file `assets/app_config.properties` to your repository. This is essential for the Flutter asset bundler to succeed in CI.
>
> [!CAUTION]
> **Kotlin & Java**: Upgrading to Kotlin `2.3.20` and Java `17` is necessary to satisfy the requirements of the Android Gradle Plugin `9.1.0`. Ensure your local environment is configured with JDK 17.

## Proposed Changes

### 1. Asset Bundling (Permanent Fix)

#### [MODIFY] [.gitignore](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/.gitignore)
- Ensure `assets/app_config.properties` is **tracked** (removed from ignore list).
- Ensure legacy `.env` and `app.env` remain ignored.

#### [NEW] [app_config.properties](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/assets/app_config.properties)
- Create a file with placeholder values.

#### [MODIFY] [pubspec.yaml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/pubspec.yaml)
- Point asset to `assets/app_config.properties`.

#### [MODIFY] [app_config.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/core/config/app_config.dart)
- Update code to load from `assets/app_config.properties`.

### 2. Toolchain Upgrades

#### [MODIFY] [settings.gradle.kts](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/android/settings.gradle.kts)
- Set Kotlin version to `2.3.20`.
- Set AGP version to `9.1.0`.

#### [MODIFY] [gradle.properties](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/android/gradle.properties)
- Enable `android.experimental.builtInKotlin=true`.
- Set `android.newDsl=false`.

#### [MODIFY] [build.gradle.kts](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/android/app/build.gradle.kts)
- Use Java 17 compatibility.
- Remove manual `kotlin-android` plugin.

### 3. CI/CD Workflows

#### [MODIFY] [flutter_ci.yml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/.github/workflows/flutter_ci.yml)
- Update to overwrite `assets/app_config.properties`.

#### [MODIFY] [codemagic.yaml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/codemagic.yaml)
- Update to overwrite `assets/app_config.properties`.

## Verification Plan

### Automated Tests
- Run `flutter pub get` and `flutter analyze` locally.
- Push to GitHub and monitor results.

### Manual Verification
- Verify `assets/app_config.properties` exists in the local file system.
