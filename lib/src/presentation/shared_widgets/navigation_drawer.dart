import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dependency_injection_container.dart' as di;
import '../../core/constants/colors.dart';
import '../booking/booking_list/booking_list_screen.dart';
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
    final String? username = prefs.getString('username');
    final String? password = prefs.getString('password');
    final int? imageId = prefs.getInt('imageId');
    return Material(
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
            CircleAvatar(
              radius: 80,
                backgroundImage: prefs.getInt('imageId') != null
                    ? NetworkImage('http://10.0.2.2:8080/image/$imageId',
                    headers: <String, String>{
                      HttpHeaders.authorizationHeader:
                      'Basic ${base64.encode(utf8.encode('$username:$password'))}'
                    })
                    : const AssetImage('assets/images/Group 1740.png') as ImageProvider,),
            const SizedBox(height: 12),
            Text(
              prefs.getString('fullName')!,
              style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto'),
            ),
            Text(
              prefs.getString('role')!,
              style: const TextStyle(
                  fontSize: 16, color: MyColors.kPrimary, fontFamily: 'Roboto'),
            )
          ],
        ),
      ),
    ));
  }

  Widget buildMenuItems(BuildContext context) {
    final SharedPreferences prefs = di.sl();
    return Container(
      padding: EdgeInsets.all(24.sp),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.account_circle_outlined,
                color: MyColors.kPrimary),
            title: Text(
              'Профиль',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.profile);
            },
          ),
          ListTile(
            leading:
            const Icon(Icons.list_alt_rounded, color: MyColors.kPrimary),
            title: Text('Бронирования',
                style: Theme.of(context).textTheme.bodyText2),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute<dynamic>(
                  builder: (_) =>
                      const BookingListScreen(isOfficeBooking: false,)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.group, color: MyColors.kPrimary),
            title:
            Text('Команды', style: Theme.of(context).textTheme.bodyText2),
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.team_list);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: MyColors.kPrimary),
            title: Text('Инфоугол',
                style: Theme.of(context).textTheme.bodyText2),
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.faq);
            },
          ),
          if(prefs.getString('role')! == 'Админ')...<Widget>[
            ListTile(
              leading: const Icon(Icons.admin_panel_settings,
                  color: MyColors.kPrimary),
              title: Text('Администрирование',
                  style: Theme.of(context).textTheme.bodyText2),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, Routes.admin_office_list);
              },
            ),
          ],
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title:
            Text('Выход', style: Theme.of(context).textTheme.bodyText2),
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.login);
            },
          )
        ],
      ),
    );
  }
}
