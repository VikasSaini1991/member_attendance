# Walkthrough - Theme Management (Dark/Light Mode)

I have successfully implemented a theme management system that allows users to toggle between Light and Dark modes.

## Key Features

### 1. Theme Definitions
Created `lib/core/theme/app_theme.dart` which defines:
- **Light Theme**: Indigo-based with Material 3.
- **Dark Theme**: Indigo-based with dark backgrounds and Material 3.

### 2. State Management (BLoC)
Implemented `ThemeBloc` to handle theme transitions:
- `LoadThemeEvent`: Loads the saved theme preference on app startup.
- `ToggleThemeEvent`: Switches between Light and Dark modes and saves the choice.

### 3. Persistence
Integrated `shared_preferences` to ensure the user's theme selection is remembered across app restarts.

### 4. Global Integration
- Updated `injection_container.dart` to register the new `ThemeBloc` and `SharedPreferences`.
- Wrapped the entire app in `main.dart` with a `BlocProvider<ThemeBloc>` and `BlocBuilder` to reactively update the `MaterialApp` theme.

### 5. UI Control
Added a theme toggle button in the `AppBar` of the `MemberListPage`. The icon dynamically changes (Sun/Moon) based on the current mode.

## How to Test
1. Launch the app.
2. Look at the top right of the `AppBar`.
3. Tap the **Sun/Moon icon** to toggle the theme.
4. Restart the app to verify that your selected theme is still active.
