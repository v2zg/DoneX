import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String kThemeBox = 'themeBox';
const String kIsDarkKey = 'isDark';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system) {
    _loadTheme();
  }

  final Box settingsBox = Hive.box(kThemeBox);

  void _loadTheme() {
    final hasStored = settingsBox.containsKey(kIsDarkKey);

    if (hasStored) {
      final isDark = settingsBox.get(kIsDarkKey) as bool;
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    } else {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final isDark = brightness == Brightness.dark;
      settingsBox.put(kIsDarkKey, isDark);
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    }
  }

  void toggleTheme() {
    final isDark = state == ThemeMode.dark;
    settingsBox.put(kIsDarkKey, !isDark);
    emit(isDark ? ThemeMode.light : ThemeMode.dark);
  }
}
