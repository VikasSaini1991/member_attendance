# CI/CD Setup Walkthrough

I have completed the technical setup for your CI/CD pipeline. To make it operational, you need to perform a few manual steps to generate your keystore and set up your Firebase project.

## Changes Made

### 1. Security & Hygiene
- Updated [.gitignore](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/.gitignore) to ensure keystores, service account keys, and `.env` files are never committed to your repository.

### 2. Android Build Configuration
- Modified [build.gradle.kts](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/android/app/build.gradle.kts) to support secure signing during the CI process. It now looks for environment variables provided by GitHub Actions to sign the release APK.

### 3. CI/CD Pipeline
- Created [.github/workflows/flutter_ci.yml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/.github/workflows/flutter_ci.yml) which automates:
    - Code analysis (`flutter analyze`)
    - Unit testing (`flutter test`)
    - Release APK building
    - Automatic deployment to Firebase App Distribution on pushes to `main` or `develop`.

---

## Action Items for You

### Step 1: Generate your Keystore
Run this command in your terminal (at the root of your project) to generate your release keystore:

```powershell
keytool -genkey -v -keystore android/app/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
> [!IMPORTANT]
> Keep track of the **Keystore Password**, **Key Alias**, and **Key Password** you choose. You will need them for Step 3.

### Step 2: Firebase Setup
1.  **Create Project**: Go to [Firebase Console](https://console.firebase.google.com/) and create a project.
2.  **Add Android App**: Use package name `com.example.member_attendance`.
3.  **App Distribution**:
    - Enable "App Distribution" in the sidebar.
    - Create a group called `internal-testers` and add your email.
4.  **Service Account**:
    - Go to [GCP Console Service Accounts](https://console.cloud.google.com/iam-admin/serviceaccounts).
    - Create a Service Account with the **Firebase App Distribution Admin** role.
    - Create a **JSON Key** for this account and download it.

### Step 3: Add GitHub Secrets
Go to your GitHub repository > **Settings** > **Secrets and variables** > **Actions** and add the following:

| Secret Name | Description |
| :--- | :--- |
| `ENV_FILE_CONTENT` | The entire content of your `.env` file. |
| `KEYSTORE_BASE64` | The content of `upload-keystore.jks` encoded in Base64 (see tip below). |
| `KEYSTORE_PASSWORD` | The password you set for the keystore. |
| `KEY_ALIAS` | The alias you set (e.g., `upload`). |
| `KEY_PASSWORD` | The password you set for the key. |
| `FIREBASE_APP_ID` | Found in Firebase Project Settings > General. |
| `CREDENTIAL_FILE_CONTENT` | The entire content of the Service Account JSON key. |

> [!TIP]
> To get the Base64 string of your keystore:
> **Windows (PowerShell):** `[Convert]::ToBase64String([IO.File]::ReadAllBytes("android/app/upload-keystore.jks")) | clip`
> **macOS/Linux:** `base64 -i android/app/upload-keystore.jks | pbcopy`
