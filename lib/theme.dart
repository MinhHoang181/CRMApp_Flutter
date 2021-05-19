import 'package:flutter/material.dart';
import 'constants/colors.dart' as Colors;
import 'constants/layouts.dart' as Layouts;

ThemeData ligthThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    //Theme
    iconTheme: IconThemeData(color: Colors.PRIMARY),
    textTheme: Theme.of(context)
        .textTheme
        .apply(bodyColor: Colors.CONTENT_LIGHT_THEME),
    colorScheme: ColorScheme.light(
      primary: Colors.PRIMARY,
      secondary: Colors.SECONDARY,
      error: Colors.ERROR,
      background: Colors.BACKGROUND_LIGHT_THEME,
      onBackground: Colors.ON_BACKGROUND_LIGHT_THEME,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.BACKGROUND_LIGHT_THEME,
      selectedItemColor: Colors.CONTENT_LIGHT_THEME.withOpacity(0.7),
      unselectedItemColor: Colors.CONTENT_LIGHT_THEME.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: Colors.PRIMARY),
      showUnselectedLabels: true,
    ),
    inputDecorationTheme: inputDecorationTheme.copyWith(
      fillColor: Colors.ON_BACKGROUND_LIGHT_THEME,
    ),
    dividerTheme: DividerThemeData(
      color: Colors.CONTENT_LIGHT_THEME,
    ),
    //Color
    primaryColor: Colors.PRIMARY,
    scaffoldBackgroundColor: Colors.BACKGROUND_LIGHT_THEME,
    shadowColor: Colors.SHADOW_LIGHT_THEME,
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    //Theme
    iconTheme: IconThemeData(color: Colors.PRIMARY),
    textTheme:
        Theme.of(context).textTheme.apply(bodyColor: Colors.CONTENT_DARK_THEME),
    colorScheme: ColorScheme.light(
      primary: Colors.PRIMARY,
      secondary: Colors.SECONDARY,
      error: Colors.ERROR,
      background: Colors.BACKGROUND_DARK_THEME,
      onBackground: Colors.ON_BACKGROUND_DARK_THEME,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.BACKGROUND_DARK_THEME,
      selectedItemColor: Colors.CONTENT_DARK_THEME.withOpacity(0.7),
      unselectedItemColor: Colors.CONTENT_DARK_THEME.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: Colors.PRIMARY),
      showUnselectedLabels: true,
    ),
    inputDecorationTheme: inputDecorationTheme.copyWith(
      fillColor: Colors.ON_BACKGROUND_DARK_THEME,
    ),
    dividerTheme: DividerThemeData(
      color: Colors.CONTENT_DARK_THEME,
    ),
    //Color
    primaryColor: Colors.PRIMARY,
    scaffoldBackgroundColor: Colors.BACKGROUND_DARK_THEME,
    shadowColor: Colors.SHADOW_DARK_THEME,
  );
}

final inputDecorationTheme = InputDecorationTheme(
  filled: true,
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: const BorderRadius.all(Radius.circular(50)),
  ),
);
