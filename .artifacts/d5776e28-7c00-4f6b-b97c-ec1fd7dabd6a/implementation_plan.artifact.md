# Implementation Plan - Permanent Fix for Asset Bundling & Kotlin Version

This plan provides a definitive solution to the "No file or variants found for asset" error and upgrades the Kotlin version to satisfy the latest Flutter requirements.

## User Review Required

> [!IMPORTANT]
> **Placeholder Strategy**: I will be committing a dummy version of `assets/app_config.properties` to your repository.
> - **Why?**: Flutter's build system requires assets to exist on disk during the initial phases. Creating them on-the-fly in CI is sometimes "too late" for the bundler.
> - **Security**: The committed file will only contain placeholder values. Your actual secrets will still be injected in CI, overwriting the placeholder.
>
> [!CAUTION]
> I will remove `assets/app_config.properties` from your `.gitignore` so it can be committed. **Do not put real secrets in this file locally** once this change is made.

## Proposed Changes

### 1. Robust Asset Strategy

#### [MODIFY] [.gitignore](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/.gitignore)
- Remove `assets/app_config.properties` from the ignored list.

#### [NEW] [app_config.properties](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/assets/app_config.properties)
- Create a file with dummy keys:
  ```properties
  ENVIRONMENT_NAME=placeholder
  BASE_URL=https://placeholder.com
  API_KEY=placeholder
  ```

### 2. Build Toolchain Modernization

#### [MODIFY] [settings.gradle.kts](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/android/settings.gradle.kts)
- Upgrade `org.jetbrains.kotlin.android` to **`2.3.20`** (or the latest stable `2.3.x`).

### 3. CI/CD Workflow Cleanup

#### [MODIFY] [codemagic.yaml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/codemagic.yaml) & [flutter_ci.yml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/.github/workflows/flutter_ci.yml)
- Ensure the "Overwrite" step happens as early as possible.
- Remove redundant `mkdir` calls since the file will now exist in the repo.

## Verification Plan

### Automated Tests
- I will run `flutter pub get` locally to ensure no errors.
- Push to GitHub and monitor the [Actions pipeline](https://github.com/VikasSaini1991/member_attendance/actions).

### Manual Verification
- You should verify that your local build still works (it will use the placeholder unless you manually put your real keys back—be careful not to commit them!).
