import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'src/core/constants/theme.dart';
import 'src/presentation/routes/routes.dart';
import 'src/presentation/screens/booking_list_screen.dart';
import 'src/presentation/screens/log_in_screen.dart';
import 'src/presentation/screens/profile_screen.dart';
import 'src/presentation/screens/team_list_screen.dart';


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
          theme: basicTheme(),
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.login,
          routes: <String, Widget Function(BuildContext)>{
            Routes.login: (BuildContext context) => const LoginScreen(),
            Routes.profile: (BuildContext context) => const ProfileScreen(),
            Routes.booking_list : (BuildContext context) => const BookingListScreen(),
            Routes.team_list : (BuildContext context) => const TeamListScreen()
          },
        );
      },
    );
  }


}
