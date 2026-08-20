# Implementation Plan - CI/CD with Firebase App Distribution (Full Setup)

This plan covers the end-to-end setup for CI/CD, including generating a release keystore, setting up Firebase, and configuring GitHub Actions.

## User Review Required

> [!IMPORTANT]
> **Manual Steps Required**: Since I cannot access your personal Firebase Console or create a Google Cloud Service Account for you, I will provide the exact commands and links you need to follow.

> [!WARNING]
> **Security**: The keystore password and Service Account key are highly sensitive. We will use **GitHub Secrets** to keep them safe.

## Proposed Changes

### Phase 1: Preparation (Manual Steps)

1.  **Keystore Generation**:
    - I will provide a `keytool` command for you to run in your terminal. This will generate the `upload-keystore.jks` file.
2.  **Firebase Setup**:
    - **Project**: Create a project at [Firebase Console](https://console.firebase.google.com/).
    - **Android App**: Register your app using the package name `com.example.member_attendance`.
    - **Service Account**: Create a Service Account in the [GCP Console](https://console.cloud.google.com/iam-admin/serviceaccounts), give it the **Firebase App Distribution Admin** role, and download the JSON key.
    - **Testers**: Create a group named `internal-testers` in the Firebase App Distribution tab.

### Phase 2: Project Configuration

#### [MODIFY] [build.gradle.kts](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/android/app/build.gradle.kts)
- Configure `signingConfigs` to use environment variables for CI and local properties for local builds.

#### [MODIFY] [.gitignore](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/.gitignore)
- Ensure `*.jks`, `*.keystore`, and `service-account-key.json` are ignored.

### Phase 3: GitHub Actions Setup

#### [NEW] [flutter_ci.yml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/.github/workflows/flutter_ci.yml)
- **Job: build**:
    - Build release APK.
    - Sign the APK using the keystore stored in GitHub Secrets.
- **Job: deploy**:
    - Upload the signed APK to Firebase App Distribution.

## GitHub Secrets to Add
You will need to add these to your GitHub Repo (Settings > Secrets and variables > Actions):
- `KEYSTORE_BASE64`: The keystore file encoded in Base64.
- `KEYSTORE_PASSWORD`: The password you choose for the keystore.
- `KEY_ALIAS`: The alias you choose for the key (e.g., `upload`).
- `KEY_PASSWORD`: The password for the key.
- `FIREBASE_APP_ID`: From Firebase project settings.
- `CREDENTIAL_FILE_CONTENT`: The content of the Service Account JSON key.

## Verification Plan

### Automated Tests
- The CI pipeline will run `flutter test` before every build.

### Manual Verification
- Run the provided `keytool` command and verify the file is created.
- Verify the build appears in Firebase App Distribution after the first successful CI run.
