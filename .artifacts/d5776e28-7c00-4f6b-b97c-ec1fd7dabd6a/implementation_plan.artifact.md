# Implementation Plan - Definitive CI/CD Pipeline Fix (Recovery)

This plan re-establishes the stable CI/CD configuration that was previously lost. It ensures asset bundling succeeds by using a tracked placeholder and upgrades the toolchain to meet Flutter's latest requirements.

## User Review Required

> [!IMPORTANT]
> **Asset Strategy**: I am committing a placeholder file `assets/app_config.properties`. This ensures the path exists for Flutter's asset bundler. CI will overwrite this with your real secrets.
>
> [!CAUTION]
> **Toolchain Upgrade**: Upgrading to **Kotlin 2.3.20** and **Java 17** is required to resolve recent build warnings and errors with the Android Gradle Plugin 9.1.0.

## Proposed Changes

### 1. Robust Asset Bundling

#### [MODIFY] [.gitignore](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/.gitignore)
- Stop ignoring `assets/app_config.properties` so it can be tracked by Git.

#### [NEW] [app_config.properties](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/assets/app_config.properties)
- Create a placeholder file with dummy values.

#### [MODIFY] [pubspec.yaml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/pubspec.yaml)
- Point assets to `assets/app_config.properties`.

#### [MODIFY] [app_config.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/core/config/app_config.dart)
- Update code to load from `assets/app_config.properties`.

### 2. Android Build Modernization

#### [MODIFY] [settings.gradle.kts](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/android/settings.gradle.kts)
- Upgrade Kotlin to **2.3.20** and AGP to **9.1.0**.

#### [MODIFY] [gradle.properties](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/android/gradle.properties)
- Enable `android.experimental.builtInKotlin=true` and `android.newDsl=false`.

#### [MODIFY] [build.gradle.kts](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/android/app/build.gradle.kts) (app level)
- Switch to Java 17 and remove the manual `kotlin-android` plugin (now handled by built-in Kotlin).

### 3. CI/CD Workflow Alignment

#### [MODIFY] [flutter_ci.yml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/.github/workflows/flutter_ci.yml)
- Update to overwrite the placeholder at `assets/app_config.properties`.

#### [MODIFY] [codemagic.yaml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/codemagic.yaml)
- Update to overwrite the placeholder at `assets/app_config.properties` within a consolidated script block for maximum stability.

## Verification Plan

### Automated Tests
- Run `flutter analyze` locally.
- Push to GitHub and monitor the Actions and Codemagic pipelines.

### Manual Verification
- Check CI logs to confirm `assets/app_config.properties` is overwritten correctly.
