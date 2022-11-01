import 'dart:convert';

import 'package:atb_first_project/src/ui/screens/BookingListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'src/data/model/User.dart';
import 'src/routes/Routes.dart';
import 'src/ui/screens/ProfileScreen.dart';
import 'src/ui/screens/LogInScreen.dart';
import 'src/ui/screens/BookingDetailScreen.dart';
import 'src/ui/screens/TeamListScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child){
        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.login,
          routes: {
            Routes.login: (BuildContext context) => const LoginScreen(),
            Routes.profile: (BuildContext context) => const ProfileScreen(),
            Routes.booking_list : (BuildContext context) => BookingListScreen(),
            Routes.team_list : (BuildContext context) => TeamListScreen()
          },
        );
      },
    );
  }


}
