# Implementation Plan - Theme Management (Dark/Light Mode)

This plan outlines the addition of theme management to the existing Clean Architecture project using BLoC and `shared_preferences`.

## User Review Required

> [!IMPORTANT]
> We will use `shared_preferences` to persist the user's theme choice (System, Light, or Dark). This requires an asynchronous initialization in `main.dart`.

## Proposed Changes

### Dependencies Update

#### [MODIFY] [pubspec.yaml](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/pubspec.yaml)
- Add `shared_preferences`.
- Remove `get` (if still present) to maintain clean BLoC architecture.

### Core Layer - Theme

- [NEW] `lib/core/theme/app_theme.dart`: Define the `ThemeData` for both Light and Dark modes.
- [NEW] `lib/core/theme/bloc/theme_event.dart`: Events for switching themes.
- [NEW] `lib/core/theme/bloc/theme_state.dart`: State to hold the current `ThemeMode`.
- [NEW] `lib/core/theme/bloc/theme_bloc.dart`: Logic to handle theme changes and persistence.

### Infrastructure

#### [MODIFY] [injection_container.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/injection_container.dart)
- Register `SharedPreferences`.
- Register `ThemeBloc`.

### App Entry Point

#### [MODIFY] [main.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/main.dart)
- Wrap `MyApp` or `MaterialApp` with `BlocProvider<ThemeBloc>`.
- Use `BlocBuilder<ThemeBloc, ThemeState>` to update `MaterialApp`'s `theme`, `darkTheme`, and `themeMode`.

### UI Changes

#### [MODIFY] [member_list_page.dart](file:///C:/Users/Acer/AndroidStudioProjects/member_attendance/lib/features/attendance/presentation/pages/member_list_page.dart)
- Add an `IconButton` to the `AppBar` to toggle between Light and Dark modes.

## Verification Plan

### Manual Verification
1. Launch the app.
2. Tap the theme toggle button in the AppBar.
3. Verify the app switches between Light and Dark modes instantly.
4. Restart the app and verify the selected theme is persisted.
