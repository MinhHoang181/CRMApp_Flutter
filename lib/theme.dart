import 'package:flutter/material.dart';
import 'constants/colors.dart' as Colors;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'constants/layouts.dart' as Layouts;
import 'package:google_fonts/google_fonts.dart';

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
    inputDecorationTheme: inputDecorationTheme(context).copyWith(
      fillColor: Colors.ON_BACKGROUND_LIGHT_THEME,
    ),
    dividerTheme: DividerThemeData(
      color: Colors.CONTENT_LIGHT_THEME,
      space: 10,
      thickness: 0.3,
    ),
    //Color
    backgroundColor: Colors.PRIMARY,
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
    inputDecorationTheme: inputDecorationTheme(context).copyWith(
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

InputDecorationTheme inputDecorationTheme(BuildContext context) =>
    InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        vertical: Layouts.SPACING / 2,
        horizontal: Layouts.SPACING,
      ),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      hintStyle: Theme.of(context).textTheme.bodyText2,
      labelStyle: Theme.of(context).textTheme.bodyText2,
      errorStyle:
          Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.ERROR),
    );

TextTheme textTheme(BuildContext context, Color color) {
  return Theme.of(context)
      .textTheme
      .apply(
        bodyColor: color,
      )
      .copyWith(
          headline1: TextStyle(
            // Header
            fontSize: 27,
            fontWeight: FontWeight.w400,
          ),
          headline2: TextStyle(
            // Header
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          subtitle1: TextStyle(
            fontSize: Fonts.SIZE_TEXT_LARGE,
            fontWeight: FontWeight.bold,
            color: color.withOpacity(1),
          ),
          subtitle2: TextStyle(
            fontSize: Fonts.SIZE_TEXT_LARGE - 3,
            fontWeight: FontWeight.bold,
            color: color.withOpacity(0.55),
          ),
          bodyText1: TextStyle(
            // normal text
            fontSize: 13,
            fontWeight: FontWeight.w200,
            // fontFamily: "Comfortaa",
            color: color.withOpacity(0.5),
          ),
          bodyText2: GoogleFonts.comfortaa(
            textStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: color.withOpacity(1),
            ),
          ));
}
