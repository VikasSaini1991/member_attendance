# CI/CD Setup Guide for member_attendance

This document outlines the GitHub Secrets and Variables required for the CI/CD pipeline to function correctly.

## GitHub Secrets

Go to your repository on GitHub: `Settings > Secrets and variables > Actions`.

| Secret Name | Description |
| :--- | :--- |
| `ENV_FILE_CONTENT` | The full content of your `.env` file. |
| `KEYSTORE_BASE64` | The base64 encoded string of your `upload-keystore.jks` file. |
| `KEYSTORE_PASSWORD` | The password for your keystore file. |
| `KEY_ALIAS` | The alias for your key. |
| `KEY_PASSWORD` | The password for your key. |
| `FIREBASE_APP_ID` | The App ID from your Firebase Console (Project Settings > General). |
| `CREDENTIAL_FILE_CONTENT` | The full content of your Google Cloud Service Account JSON key. |

### How to get `KEYSTORE_BASE64`
Run the following command on your local machine and copy the output:
```bash
base64 -w 0 android/app/upload-keystore.jks
```

### How to get `CREDENTIAL_FILE_CONTENT`
1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Select your project.
3. Navigate to **IAM & Admin > Service Accounts**.
4. Create a new service account with the **Firebase App Distribution Admin** role.
5. Create a new JSON key for this service account and download it.
6. Copy the entire content of this JSON file into the `CREDENTIAL_FILE_CONTENT` secret.

## GitHub Variables

| Variable Name | Description |
| :--- | :--- |
| `FIREBASE_DISTRIBUTION_GROUPS` | (Optional) Comma-separated list of tester groups (e.g., `internal-testers`). Defaults to `internal-testers` in the workflow. |

## Workflow Steps
1. **Push to `main` or `develop`**: Triggers the full CI/CD pipeline (Build + Deploy).
2. **Pull Request**: Triggers CI only (Analyze + Test).
