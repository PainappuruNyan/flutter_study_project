import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

ThemeData basicTheme() => ThemeData(
      brightness: Brightness.light,
      primaryColor: MyColors.kPrimary,
      dividerColor: Colors.transparent,
      colorScheme:
          const ColorScheme.light(primary: MyColors.kSecondary // circle color
              ),
      tabBarTheme: const TabBarTheme(
          labelColor: MyColors.kPrimary,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: MyColors.kPrimary))),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle:
            SystemUiOverlayStyle(
              statusBarColor: MyColors.kPrimary,
              statusBarIconBrightness: Brightness.light,),
        backgroundColor: MyColors.kPrimary,
        titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            color: MyColors.kWhite,
            fontWeight: FontWeight.w500),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        elevation: 0,
        color: MyColors.kWhite,
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
      cardColor: MyColors.kWhite,
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
