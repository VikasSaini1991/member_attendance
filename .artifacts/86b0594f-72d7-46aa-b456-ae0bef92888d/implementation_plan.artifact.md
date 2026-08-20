# Implementation Plan - Clean Code & Project Restructuring

The goal of this task is to clean up the project by removing redundant code, standardizing on a single state management approach (Bloc with Clean Architecture), and improving overall code quality.

## User Review Required

> [!IMPORTANT]
> This plan involves deleting several files in the root `lib/` directory that appear to be part of a legacy or parallel GetX implementation. `main.dart` is already configured to use the Bloc-based implementation in `features/`.
>
> I will also remove the `get` package from `pubspec.yaml` as it will no longer be used.

## Proposed Changes

### [Cleanup] Redundant Files

The following files are part of a GetX implementation that is no longer used in the main app entry point (`main.dart`).

#### [DELETE] [attendance_controller.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/attendance_controller.dart)
#### [DELETE] [member_list_screen.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/member_list_screen.dart)
#### [DELETE] [mp_model.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/mp_model.dart)
#### [DELETE] [member_list_screen.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/member_list_screen.dart)

---

### [Refactor] Dependencies

#### [MODIFY] [pubspec.yaml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/pubspec.yaml)
I will remove the `get` package to keep the dependency list clean.

```diff
 dependencies:
   flutter:
     sdk: flutter

   cupertino_icons: ^1.0.8
   flutter_bloc: ^8.1.6
   equatable: ^2.0.5
   get_it: ^7.7.0
   dartz: ^0.10.1
   shared_preferences: ^2.3.5
-  get: ^4.7.3
```

---

### [Refactor] Presentation Layer

#### [MODIFY] [member_list_page.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/features/attendance/presentation/pages/member_list_page.dart)
I will optimize the UI to handle state transitions more gracefully.

---

### [Refactor] Global Cleanup

#### [MODIFY] [injection_container.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/injection_container.dart)
- Remove any GetX related registrations if they exist (none found so far, but I will double check).

## Verification Plan

### Automated Tests
- Run `flutter analyze` to ensure no linting errors or broken imports remain.
- Run `flutter test` (if any tests exist).

### Manual Verification
- Build and run the app to ensure the "Member List" functionality works as expected with Bloc.
- Verify OTP verification flow still works.
- Verify Theme switching still works.
