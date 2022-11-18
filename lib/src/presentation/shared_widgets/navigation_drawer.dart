import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routes/routes.dart';


class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
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

  Widget buildHeader(BuildContext context) => Material(
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
            children: const <Widget>[
              CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/originals/b1/90/ea/b190eaf16ed403f2e2b426ef59cfcdc1.jpg'),
              ),
              SizedBox(height: 12),
              Text(
                'Nyan Nyan',
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontFamily: 'Roboto'),
              ),
              Text(
                'Сотрудник',
                style: TextStyle(
                    fontSize: 16, color: Colors.white, fontFamily: 'Roboto'),
              )
            ],
          ),
        ),
      ));

  Widget buildMenuItems(BuildContext context) => Container(
    padding: EdgeInsets.all(24.sp),
    child: Column(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.account_circle_outlined),
          title: Text('Профиль', style: Theme.of(context).textTheme.bodyText2,
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, Routes.profile);
          },
        ),
        ListTile(
          leading: const Icon(Icons.list_alt_rounded),
          title: Text('Бронирования', style: Theme.of(context).textTheme.bodyText2),
          onTap: () {
            Navigator.pushReplacementNamed(context, Routes.booking_list);
          },
        ),
        ListTile(
          leading: const Icon(Icons.group),
          title: Text('Команды', style: Theme.of(context).textTheme.bodyText2),
          onTap: () {
            Navigator.pushReplacementNamed(context, Routes.team_list);
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: Text('Настройки', style: Theme.of(context).textTheme.bodyText2),
          onTap: () {},
        )
      ],
    ),
  );
}
