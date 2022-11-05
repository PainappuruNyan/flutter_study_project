import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData basicTheme() => ThemeData(
    brightness: Brightness.light,
    primaryColor: MyColors.kPrimary,
    tabBarTheme: const TabBarTheme(
      labelColor: MyColors.kPrimary,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: MyColors.kPrimary)
      )
    ),
    textTheme: const TextTheme(
        headline6: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            color: MyColors.kWhite,
            fontWeight: FontWeight.w500),
        headline4: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
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
            fontWeight: FontWeight.w400)),
    iconTheme: const IconThemeData(color: MyColors.kWhite),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: MyColors.kPrimary, foregroundColor: MyColors.kWhite),
    buttonTheme: ButtonThemeData(
        height: 40,
        buttonColor: MyColors.kPrimary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: MyColors.kPrimary, width: 2))),
    cardColor: MyColors.kWhite,
    scaffoldBackgroundColor: MyColors.kFrameBackground);
