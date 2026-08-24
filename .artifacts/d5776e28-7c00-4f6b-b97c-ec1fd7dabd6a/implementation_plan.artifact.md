# Implementation Plan - Solve Persistent Asset Bundling Error

The build continues to fail with `No file or variants found for asset: assets/app.env`, which indicates that despite our script's attempt to create the file, the Flutter build tool is not detecting it. This plan uses a more integrated approach and standardized naming to ensure the file is bundled.

## User Review Required

> [!IMPORTANT]
> **Check Variable Group Assignment**: In the Codemagic dashboard, please verify that the variable group `firebase_credentials` is **associated** with your workflow. If it's not associated, the `$ENV_FILE_CONTENT` variable will be empty.

## Proposed Changes

### 1. Robust File Creation & Directory Verification

#### [MODIFY] [codemagic.yaml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/codemagic.yaml)
- **Consolidate Scripts**: Move the `.env` creation into the same script block as the build command to prevent any potential disk cleanup between steps.
- **Absolute Paths**: Use `$CM_BUILD_DIR` to explicitly point to the project root.
- **Standardize Filename**: Use `assets/app_config.properties` instead of `.env` or `app.env`. Properties files are less likely to be ignored by build systems.

### 2. Project Configuration Updates

#### [MODIFY] [pubspec.yaml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/pubspec.yaml)
- Update asset path to `assets/app_config.properties`.

#### [MODIFY] [app_config.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/core/config/app_config.dart)
- Update code to load from `assets/app_config.properties`.

#### [MODIFY] [.gitignore](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/.gitignore)
- Update to ignore `assets/app_config.properties`.

## Verification Plan

### Automated Tests
- CI logs will display the directory contents immediately before the build to confirm the file exists in the correct location.

### Manual Verification
- Verify the app still works locally with the new filename.
