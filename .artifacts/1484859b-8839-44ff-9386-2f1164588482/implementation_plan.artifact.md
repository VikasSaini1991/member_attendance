# Implementation Plan - Testing Infrastructure

This plan outlines the steps to add Unit, Widget, and Integration tests to the `member_attendance` project.

## User Review Required

> [!IMPORTANT]
> The implementation requires adding several development dependencies to `pubspec.yaml`:
> - `mocktail`: For creating mock objects in tests.
> - `bloc_test`: For testing BLoC states and transitions.
> - `integration_test`: For end-to-end testing on devices/emulators.

## Proposed Changes

### Configuration

#### [MODIFY] [pubspec.yaml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/pubspec.yaml)
- Add `mocktail`, `bloc_test`, and `integration_test` to `dev_dependencies`.

### Unit Testing

#### [NEW] [mp_entity_test.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/test/features/attendance/domain/entities/mp_entity_test.dart)
- Unit test for the `MpEntity` class to ensure value equality works as expected.

#### [NEW] [attendance_bloc_test.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/test/features/attendance/presentation/bloc/attendance_bloc_test.dart)
- Unit test for `AttendanceBloc` using `bloc_test`.
- Mocks `GetMps` and `VerifyOtp` use cases.

### Widget Testing

#### [MODIFY] [widget_test.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/test/widget_test.dart)
- Replace the default counter test with a meaningful test for `MemberListPage`.
- Mocks `AttendanceBloc` and `ThemeBloc` to verify the UI renders correctly when data is loaded.

### Integration Testing

#### [NEW] [app_test.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/integration_test/app_test.dart)
- Integration test to verify the full flow:
  1. App starts and loads MP list.
  2. User taps "Mark Attendance".
  3. User enters OTP in the dialog.
  4. User verifies the success dialog appears.

## Verification Plan

### Automated Tests
- Run unit and widget tests using: `flutter test`
- Run integration tests using: `flutter test integration_test/app_test.dart` (Requires a running device/emulator)

### Manual Verification
- Verify that the test files are correctly placed in the `test/` and `integration_test/` directories.
