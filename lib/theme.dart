import 'package:flutter/material.dart';
import 'constants/colors.dart' as Colors;

ThemeData ligthThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    //Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
    ),
    iconTheme: IconThemeData(color: Colors.CONTENT_LIGHT_THEME),
    textTheme: textTheme(context, Colors.CONTENT_LIGHT_THEME),
    colorScheme: ColorScheme.light(
      primary: Colors.PRIMARY,
      secondary: Colors.SECONDARY,
      error: Colors.ERROR,
      background: Colors.BACKGROUND_LIGHT_THEME,
      onBackground: Colors.ON_BACKGROUND_LIGHT_THEME,
      onPrimary: Colors.ON_PRIMARY,
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
      space: 10,
      thickness: 0.3,
    ),
    //Color
    accentColor: Colors.TEXT_BLACK,
    primaryColor: Colors.PRIMARY,
    scaffoldBackgroundColor: Colors.BACKGROUND_LIGHT_THEME,
    shadowColor: Colors.SHADOW_LIGHT_THEME,
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    //Theme
    iconTheme: IconThemeData(color: Colors.CONTENT_DARK_THEME),
    textTheme: textTheme(context, Colors.CONTENT_DARK_THEME),
    colorScheme: ColorScheme.light(
      primary: Colors.PRIMARY,
      secondary: Colors.SECONDARY,
      error: Colors.ERROR,
      background: Colors.BACKGROUND_DARK_THEME,
      onBackground: Colors.ON_BACKGROUND_DARK_THEME,
      onPrimary: Colors.ON_PRIMARY,
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
      space: 10,
      thickness: 0.3,
    ),
    //Color
    accentColor: Colors.TEXT_WHITE,
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

TextTheme textTheme(BuildContext context, Color color) {
  return Theme.of(context)
      .textTheme
      .apply(
        bodyColor: color,
      )
      .copyWith(
          subtitle1: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color.withOpacity(1),
          ),
          subtitle2: TextStyle(
            fontSize: 10,
            color: color.withOpacity(0.68),
          ));
}
