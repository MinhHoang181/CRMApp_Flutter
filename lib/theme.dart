import 'package:flutter/material.dart';
import 'constants/colors.dart' as Colors;
import 'constants/layouts.dart' as Layouts;

ThemeData ligthThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: Colors.PRIMARY,
    scaffoldBackgroundColor: Colors.BACKGROUND_LIGHT_THEME,
    appBarTheme: appBarTheme,
    iconTheme: IconThemeData(color: Colors.CONTENT_LIGHT_THEME),
    textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.CONTENT_LIGHT_THEME),
    colorScheme: ColorScheme.light(
      primary: Colors.PRIMARY,
      secondary: Colors.SECONDARY,
      error: Colors.ERROR,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.BACKGROUND_LIGHT_THEME,
      selectedItemColor: Colors.CONTENT_LIGHT_THEME.withOpacity(0.7),
      unselectedItemColor: Colors.CONTENT_LIGHT_THEME.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: Colors.PRIMARY),
      showUnselectedLabels: true,
    ),
    inputDecorationTheme: inputDecorationTheme.copyWith(
      fillColor: Colors.CONTENT_LIGHT_THEME.withOpacity(0.05),
    )
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
      primaryColor: Colors.PRIMARY,
      scaffoldBackgroundColor: Colors.BACKGROUND_DARK_THEME,
      appBarTheme: appBarTheme,
      iconTheme: IconThemeData(color: Colors.CONTENT_DARK_THEME),
      textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.CONTENT_DARK_THEME),
      colorScheme: ColorScheme.light(
        primary: Colors.PRIMARY,
        secondary: Colors.SECONDARY,
        error: Colors.ERROR,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.BACKGROUND_DARK_THEME,
        selectedItemColor: Colors.CONTENT_DARK_THEME.withOpacity(0.7),
        unselectedItemColor: Colors.CONTENT_DARK_THEME.withOpacity(0.32),
        selectedIconTheme: IconThemeData(color: Colors.PRIMARY),
        showUnselectedLabels: true,
      ),
      inputDecorationTheme: inputDecorationTheme.copyWith(
        fillColor: Colors.CONTENT_DARK_THEME.withOpacity(0.08),
      )
  );
}

final appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);

final inputDecorationTheme = InputDecorationTheme(
  filled: true,
  contentPadding: EdgeInsets.symmetric(
    horizontal: Layouts.SPACING * 1.5,
    vertical: Layouts.SPACING,
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: const BorderRadius.all(Radius.circular(50)),
  ),
);