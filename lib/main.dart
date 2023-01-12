import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'dependency_injection_container.dart' as di;
import 'src/bloc/booking_list/booking_list_bloc.dart';
import 'src/bloc/profile/profile_bloc.dart';
import 'src/bloc/team_list/team_list_bloc.dart';
import 'src/bloc/teammate_list/teammate_list_bloc.dart';
import 'src/core/constants/theme.dart';
import 'src/presentation/administration/create_office_1/create_office_1.dart';
import 'src/presentation/administration/office_list/office_list.dart';
import 'src/presentation/administration/user_list/user_list.dart';
import 'src/presentation/faq/faq.dart';
import 'src/presentation/feedback/feedback.dart';
import 'src/presentation/log_in/log_in/log_in_screen.dart';
import 'src/presentation/profile/profile_screen.dart';
import 'src/presentation/routes/routes.dart';
import 'src/presentation/teams/team_list/team_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SharedPreferences prefs = di.sl();
    final String initRoute =
        prefs.containsKey('username') && prefs.containsKey('password')
            ? Routes.profile
            : Routes.login;
    return MultiBlocProvider(
      providers: [
        BlocProvider<TeamListBloc>(
          create: (BuildContext context) =>
              TeamListBloc(di.sl())..add(const GetTeamList()),
        ),
        BlocProvider<TeammateListBloc>(
            create: (BuildContext context) => TeammateListBloc(di.sl())),
        BlocProvider<ProfileBloc>(
            create: (BuildContext context) => ProfileBloc()),
        BlocProvider<BookingListBloc>(
            create: (BuildContext context) =>
                BookingListBloc(di.sl(), false, null))
      ],
      child: ChangeNotifierProvider<ThemeProvider>(
        create: (BuildContext context) => ThemeProvider(),
        child: ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            final ThemeProvider themeProvider =
                Provider.of<ThemeProvider>(context);
            return MaterialApp(
              themeMode: themeProvider.themeMode,
              theme: basicTheme(),
              darkTheme: darkTheme(),
              debugShowCheckedModeBanner: false,
              initialRoute: initRoute,
              routes: <String, Widget Function(BuildContext)>{
                Routes.login: (BuildContext context) => const LoginScreen(),
                Routes.profile: (BuildContext context) => const ProfileScreen(),
                Routes.team_list: (BuildContext context) =>
                    const TeamListScreen(),
                Routes.user_list: (BuildContext context) => const UserList(),
                Routes.create_office_1: (BuildContext context) =>
                    const CreateOffice1(),
                Routes.admin_office_list: (BuildContext context) =>
                    const OfficeListScreen(),
                Routes.faq: (BuildContext context) => const FaqScreen(),
                Routes.feedback: (BuildContext context) => FeedbackScreen()
              },
            );
          },
        ),
      ),
    );
  }
}
