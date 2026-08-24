# Implementation Plan - Fix AGP 9.1 & Kotlin 2.3 Script Compilation Errors

This plan addresses the script compilation errors in `build.gradle.kts` caused by the upgrade to Android Gradle Plugin (AGP) 9.1.0 and Kotlin 2.3.20. It aligns the project with the new "Built-in Kotlin" standards and resolves DSL deprecations.

## User Review Required

> [!IMPORTANT]
> **Built-in Kotlin**: I am finalizing the migration to Built-in Kotlin by removing the explicit Kotlin plugin from `settings.gradle.kts` and using the new `compilerOptions` pattern.
>
> [!WARNING]
> **DSL Strictness**: AGP 9.0+ is more strict with its DSL. I will resolve the deprecation errors in `app/build.gradle.kts` to satisfy the Kotlin script compiler.

## Proposed Changes

### 1. Gradle Properties Cleanup

#### [MODIFY] [gradle.properties](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/android/gradle.properties)
- Change `android.experimental.builtInKotlin=true` to `android.builtInKotlin=true`.
- Ensure `android.newDsl=false` is maintained for Flutter compatibility.

### 2. Dependency Management

#### [MODIFY] [settings.gradle.kts](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/android/settings.gradle.kts)
- Remove `id("org.jetbrains.kotlin.android")` from the `plugins` block. Built-in Kotlin handles this automatically based on the AGP version.

### 3. Build Script Modernization

#### [MODIFY] [app/build.gradle.kts](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/android/app/build.gradle.kts)
- **Remove `kotlinOptions`**: This block is deprecated. With Built-in Kotlin, it's replaced by `compilerOptions`.
- **Set `compileOptions`**: Ensure `sourceCompatibility` and `targetCompatibility` are set to `JavaVersion.VERSION_17`.
- **Address `android` block deprecation**: If the `android { }` block still causes an error, I will switch to using the explicit `ApplicationExtension` type configuration.

## Verification Plan

### Automated Tests
- Run `flutter analyze` to ensure the project structure is valid.
- Push to GitHub and monitor the CI/CD pipeline.

### Manual Verification
- Check the CI logs to verify that the "assembleRelease" task now proceeds without script compilation errors.
