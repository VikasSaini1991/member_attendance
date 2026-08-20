import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences sharedPreferences;
  static const String themeKey = "theme_mode";

  ThemeBloc({required this.sharedPreferences}) : super(const ThemeState(ThemeMode.system)) {
    on<LoadThemeEvent>((event, emit) {
      final String? themeStr = sharedPreferences.getString(themeKey);
      if (themeStr == null) {
        emit(const ThemeState(ThemeMode.system));
      } else {
        final mode = ThemeMode.values.firstWhere(
          (e) => e.toString() == themeStr,
          orElse: () => ThemeMode.system,
        );
        emit(ThemeState(mode));
      }
    });

    on<ToggleThemeEvent>((event, emit) async {
      final newMode = state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      await sharedPreferences.setString(themeKey, newMode.toString());
      emit(ThemeState(newMode));
    });
  }
}
