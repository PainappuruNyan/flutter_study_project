import 'package:atb_first_project/src/presentation/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dependency_injection_container.dart' as di;
import 'src/core/constants/theme.dart';
import 'src/presentation/administration/create_office_1/create_office_1.dart';
import 'src/presentation/booking/booking_details/booking_detail_screen.dart';
import 'src/presentation/booking/booking_list/booking_list_screen.dart';
import 'src/presentation/booking/create_booking_1/create_booking_1.dart';
import 'src/presentation/booking/create_booking_2/booking_create_2.dart';
import 'src/presentation/booking/create_booking_3/booking_create_3.dart';
import 'src/presentation/log_in/log_in/log_in_screen.dart';
import 'src/presentation/routes/routes.dart';
import 'src/presentation/teams/team_list/team_list_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
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
            Routes.team_list : (BuildContext context) => const TeamListScreen(),
            Routes.booking_details: (BuildContext context) => const BookingDetailScreen(),
            Routes.create_office_1: (BuildContext context) => const CreateOffice1(),
            Routes.booking_create_1: (BuildContext context) => const CreateBooking1(),
            Routes.booking_create_2: (BuildContext context) => const BookingCreate2Screen(),
            Routes.booking_create_3: (BuildContext context) => const BookingCreate3Screen(),
          },
        );
      },
    );
  }


}
