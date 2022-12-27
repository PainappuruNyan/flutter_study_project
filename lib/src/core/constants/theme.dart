import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

ThemeData basicTheme() => ThemeData(
      brightness: Brightness.light,
      primaryColor: MyColors.kPrimary,
      dividerColor: Colors.transparent,
      colorScheme:
          const ColorScheme.light(primary: MyColors.kSecondary // circle color
              ),
      tabBarTheme: const TabBarTheme(
          labelColor: MyColors.kPrimaryText,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: MyColors.kPrimary))),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: MyColors.kWhite,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: MyColors.kWhite,
        iconTheme: IconThemeData(
          color: MyColors.kPrimaryText
        ),
        titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            color: MyColors.kPrimaryText,
            fontWeight: FontWeight.w500),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        elevation: 0,
      ),
      textTheme: const TextTheme(
          headline6: TextStyle(
              fontWeight: FontWeight.w500,
              color: MyColors.kPrimary,
              fontSize: 16),
          headline4: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 26,
              color: MyColors.kPrimaryText,
              fontWeight: FontWeight.w500),
          bodyText1: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              color: MyColors.kWhite,
              fontWeight: FontWeight.w400),
          bodyText2: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              color: MyColors.kPrimaryText,
              fontWeight: FontWeight.w400),
          caption: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              color: MyColors.kTextSecondary,
              fontWeight: FontWeight.w400),
          subtitle1: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 24,
              color: MyColors.kPrimary,
              fontWeight: FontWeight.w500),
          subtitle2: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
              color: MyColors.kPrimaryText,
              fontWeight: FontWeight.w500)),
      iconTheme: const IconThemeData(color: MyColors.kWhite),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: MyColors.kPrimary, foregroundColor: MyColors.kWhite),
      buttonTheme: ButtonThemeData(
          height: 40.h,
          buttonColor: MyColors.kPrimary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: MyColors.kPrimary, width: 1.w))),
      cardTheme: CardTheme(
        color: MyColors.kWhite,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.kPrimary,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.kPrimary,
          ),
        ),
        labelStyle: TextStyle(
          color: MyColors.kTextSecondary,
          fontSize: 14,
        ),
      ),
      canvasColor: MyColors.kWhite,
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateColor.resolveWith(
                  (Set<MaterialState> states) => MyColors.kPrimary))),
      timePickerTheme: const TimePickerThemeData(
          helpTextStyle:
              TextStyle(fontFamily: 'Roboto', color: MyColors.kPrimary),
          entryModeIconColor: MyColors.kPrimary,
          dialBackgroundColor: MyColors.kWhite,
          dayPeriodTextColor: MyColors.kPrimary,
          dialHandColor: MyColors.kPrimary,
          hourMinuteTextColor: MyColors.kPrimary),
      scaffoldBackgroundColor: MyColors.kWhite,
    );

ThemeData darkTheme() => ThemeData(
  brightness: Brightness.dark,
  primaryColor: MyColors.kDarkOrange,
  dividerColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.grey.shade900,
  colorScheme:
  const ColorScheme.dark(primary: MyColors.kSecondary // circle color
  ),
  tabBarTheme: const TabBarTheme(
      labelColor: MyColors.kWhite,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: MyColors.kPrimary))),
  canvasColor: Colors.grey.shade800,
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: MyColors.kPrimaryText,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Colors.grey.shade900,
    iconTheme: IconThemeData(
        color: Colors.grey.shade200
    ),
    titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20,
        color: Colors.grey.shade200,
        fontWeight: FontWeight.w500),
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    elevation: 0,
    color: Colors.grey.shade900,
  ),
  textTheme: TextTheme(
      headline6: TextStyle(
          fontWeight: FontWeight.w500,
          color: MyColors.kPrimary,
          fontSize: 16),
      headline4: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 26,
          color: Colors.grey.shade200,
          fontWeight: FontWeight.w500),
      bodyText1: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          color: MyColors.kPrimaryText,
          fontWeight: FontWeight.w400),
      bodyText2: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          color: Colors.grey.shade200,
          fontWeight: FontWeight.w400),
      caption: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          color: MyColors.kTextSecondary,
          fontWeight: FontWeight.w400),
      subtitle1: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24,
          color: MyColors.kPrimary,
          fontWeight: FontWeight.w500),
      subtitle2: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          color: Colors.grey.shade200,
          fontWeight: FontWeight.w500)),
  iconTheme: const IconThemeData(color: MyColors.kWhite),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: MyColors.kPrimary, foregroundColor: MyColors.kWhite),
  buttonTheme: ButtonThemeData(
      height: 40.h,
      buttonColor: Colors.grey.shade800,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: MyColors.kPrimary, width: 1.w))),
  cardTheme: CardTheme(
    color: Colors.grey.shade700,
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: MyColors.kPrimary,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: MyColors.kPrimary,
      ),
    ),
    labelStyle: TextStyle(
      color: MyColors.kTextSecondary,
      fontSize: 14,
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.grey.shade800,
  ),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStateColor.resolveWith(
                  (Set<MaterialState> states) => MyColors.kPrimary))),
  timePickerTheme: TimePickerThemeData(
      helpTextStyle:
      TextStyle(fontFamily: 'Roboto', color: MyColors.kPrimary),
      entryModeIconColor: MyColors.kPrimary,
      dialBackgroundColor: Colors.grey.shade800,
      dayPeriodTextColor: MyColors.kPrimary,
      dialHandColor: MyColors.kPrimary,
      hourMinuteTextColor: MyColors.kPrimary),

);
