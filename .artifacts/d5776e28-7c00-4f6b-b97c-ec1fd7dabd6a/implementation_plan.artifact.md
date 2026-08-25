# Implementation Plan - Fix Kotlin Version Mismatch & AGP 9+ Compatibility

This plan addresses the build failure where the built-in Kotlin version of AGP 9.1.0 (2.2.10) is lower than Flutter's requirement (2.2.20). We will revert to manual Kotlin management to ensure the correct version is used.

## User Review Required

> [!IMPORTANT]
> **Built-in Kotlin**: I am opting out of "Built-in Kotlin" because it currently defaults to version 2.2.10 in AGP 9.1.0, which is too low for your project's Flutter version. I will manually set Kotlin to **2.3.20**.
>
> [!WARNING]
> **AGP Warning**: I will continue to keep `android.newDsl=false` to ensure compatibility with the current Flutter Gradle plugin, which still relies on legacy DSL components.

## Proposed Changes

### 1. Build Toolchain Adjustment

#### [MODIFY] [gradle.properties](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/android/gradle.properties)
- Set `android.builtInKotlin=false` to allow manual version control.

#### [MODIFY] [settings.gradle.kts](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/android/settings.gradle.kts)
- Re-add `id("org.jetbrains.kotlin.android") version "2.3.20" apply false` to the `plugins` block.

#### [MODIFY] [app/build.gradle.kts](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/android/app/build.gradle.kts)
- Re-add `id("kotlin-android")` to the `plugins` block.
- Keep Java 17 compatibility.

## Verification Plan

### Automated Tests
- Run `flutter analyze` locally.
- Push to GitHub and monitor the [Actions pipeline](https://github.com/VikasSaini1991/member_attendance/actions).

### Manual Verification
- Verify that the error "Your project's Kotlin version (2.2.10) is lower than Flutter's minimum supported version of 2.2.20" is resolved.
