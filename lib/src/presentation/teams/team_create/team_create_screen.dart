import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/colors.dart';
import '../../shared_widgets/navigation_drawer.dart' as NavigationDrawer;

class TeamCreateScreen extends StatelessWidget {
  const TeamCreateScreen({super.key});

  static const String routeName = '/team_create_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создание команды'),
      ),
      drawer: const NavigationDrawer.NavigationDrawer(),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      left: 36.5.sp, right: 36.5.sp, top: 70.sp, bottom: 35.sp),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: const InputDecoration(
                        labelText: 'Название команды',
                        prefixIcon: Icon(
                          Icons.group,
                          color: MyColors.kPrimary,
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 36.5.sp, right: 36.5.sp),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: const InputDecoration(
                        labelText: 'Телефон лидера',
                        prefixIcon: Icon(
                          Icons.phone,
                          color: MyColors.kPrimary,
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 76.sp),
                  width: 286.w,
                  child: MaterialButton(
                    onPressed: () {},
                    color: MyColors.kPrimary,
                    child: const Text('Создать команду',
                        style:
                        TextStyle(fontSize: 16.0, color: Colors.white)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 30.sp, right: 15.sp),
                  width: 286.w,
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.close,
                      size: 24.0,
                      color: MyColors.kPrimary,
                    ),
                    label: const Text(
                      'Отмена',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: MyColors.kPrimary,
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
