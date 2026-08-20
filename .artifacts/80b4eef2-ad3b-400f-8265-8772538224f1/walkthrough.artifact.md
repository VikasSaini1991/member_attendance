# Firebase Setup Walkthrough

I have prepared the code for Firebase integration. To complete the setup, you must manually create the project in the Firebase Console because it requires your personal login.

## Changes Made

### 1. Flutter Configuration
- Added `firebase_core` to [pubspec.yaml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/pubspec.yaml).
- Initialized Firebase in [main.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/main.dart).

### 2. Android Native Configuration
- Updated [android/build.gradle.kts](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/android/build.gradle.kts) to include the Google Services plugin.
- Applied the Google Services plugin in [android/app/build.gradle.kts](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/android/app/build.gradle.kts).

---

## Action Items for You (Firebase Console)

### Step 1: Create the Firebase Project
1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Click **Add project** and name it `member-attendance`.
3. Disable or enable Google Analytics as you prefer.

### Step 2: Register the Android App
1. Inside your new project, click the **Android icon** to add an app.
2. **Android package name**: `com.example.member_attendance` (This must match exactly).
3. **App nickname**: `Member Attendance Android`.
4. Click **Register app**.

### Step 3: Download and Place the Config File
1. Download the `google-services.json` file.
2. Move it into your project folder at: `android/app/google-services.json`.

> [!IMPORTANT]
> The app will **fail to build** until you place the `google-services.json` file in the correct directory.

### Step 4: Finalize
Once the file is in place, you can run `flutter run` or push to GitHub to trigger the CI/CD pipeline.
