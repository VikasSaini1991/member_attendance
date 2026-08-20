# Task - Implement Theme Management

- [x] Add `shared_preferences` dependency
- [x] Create Theme BLoC and Data
    - [x] `lib/core/theme/app_theme.dart`
    - [x] `lib/core/theme/bloc/theme_event.dart`
    - [x] `lib/core/theme/bloc/theme_state.dart`
    - [x] `lib/core/theme/bloc/theme_bloc.dart`
- [x] Update Dependency Injection
    - [x] Register `SharedPreferences` in `injection_container.dart`
    - [x] Register `ThemeBloc` in `injection_container.dart`
- [x] Update `main.dart` for Theme Support
- [x] Add Theme Toggle UI in `MemberListPage`
- [x] Verify persistence and UI switching
