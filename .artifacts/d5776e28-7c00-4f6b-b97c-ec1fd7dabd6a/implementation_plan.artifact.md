# Implementation Plan - Fix CI Asset Bundling Issue

This plan addresses the build failure `No file or variants found for asset: .env` by moving the environment configuration file to a more robust location and updating the project configuration.

## User Review Required

> [!IMPORTANT]
> I am moving your `.env` file into the `assets/` directory and renaming it to `env` (without the leading dot).
> - **Reason**: Dotfiles (files starting with `.`) are often ignored or hidden by build tools and operating systems (like the macOS runners used by Codemagic). Moving the file to a standard subdirectory ensures it is always bundled correctly.
>
> [!WARNING]
> After this change, you must ensure that your local `.env` is moved to `assets/env`. I will handle the file move in this plan, but don't forget to update any local backups you might have.

## Proposed Changes

### Project Structure & Configuration

#### [MODIFY] [pubspec.yaml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/pubspec.yaml)
- Update the assets section:
  - Remove `- .env`
  - Add `- assets/env`

#### [MODIFY] [app_config.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/core/config/app_config.dart)
- Update the `initialize` method to use the new paths:
  - `AppEnvironment.dev` -> `assets/env`
  - `AppEnvironment.staging` -> `assets/env_staging`
  - `AppEnvironment.prod` -> `assets/env_prod`

### CI/CD Workflows

#### [MODIFY] [flutter_ci.yml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/.github/workflows/flutter_ci.yml)
- Update the "Create .env file" step to write to `assets/env` instead of `.env`.

#### [MODIFY] [codemagic.yaml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/codemagic.yaml)
- Update the "Set up .env file" script:
  - Target path: `assets/env`
  - Add a check to fail the build with a clear error message if `$ENV_FILE_CONTENT` is empty.

## Verification Plan

### Automated Tests
- Run `flutter analyze` locally to ensure the code remains valid.
- Verify the build succeeds on GitHub Actions.

### Manual Verification
- You should run the app locally to ensure the configuration is still loaded correctly from `assets/env`.
