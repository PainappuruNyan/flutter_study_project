import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dependency_injection_container.dart' as di;
import '../routes/routes.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    final SharedPreferences prefs = di.sl();
    return Material(
        color: Colors.deepOrange,
        child: InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, Routes.profile);
          },
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
              left: 40.sp,
              top: 24.sp + MediaQuery.of(context).padding.top,
              bottom: 24.sp,
            ),
            child: Column(
              children: <Widget>[
                const CircleAvatar(
                  radius: 52,
                  backgroundImage: AssetImage('assets/images/Group 1740.png'),
                ),
                const SizedBox(height: 12),
                Text(
                  prefs.getString('login')!,
                  style: const TextStyle(
                      fontSize: 20, color: Colors.white, fontFamily: 'Roboto'),
                ),
                Text(
                  prefs.getString('role')!,
                  style: const TextStyle(
                      fontSize: 16, color: Colors.white, fontFamily: 'Roboto'),
                )
              ],
            ),
          ),
        ));
  }

  Widget buildMenuItems(BuildContext context) => Container(
        padding: EdgeInsets.all(24.sp),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: Text(
                'Профиль',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.profile);
              },
            ),
            ListTile(
              leading: const Icon(Icons.list_alt_rounded),
              title: Text('Бронирования',
                  style: Theme.of(context).textTheme.bodyText2),
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.booking_list);
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title:
                  Text('Команды', style: Theme.of(context).textTheme.bodyText2),
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.team_list);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: Text('Инфоугол',
                  style: Theme.of(context).textTheme.bodyText2),
              onTap: () {
                // Navigator.pushReplacementNamed(context, Routes.user_list);
              },
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings),
              title: Text('Администрирование',
                  style: Theme.of(context).textTheme.bodyText2),
              onTap: () {
                // Navigator.pushReplacementNamed(context, Routes.user_list);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red,),
              title: Text('Выход',
                  style: Theme.of(context).textTheme.bodyText2),
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.login);
              },
            )
          ],
        ),
      );
}
