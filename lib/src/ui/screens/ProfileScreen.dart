import 'package:atb_first_project/src/ui/widgets/NavigationDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/BookingCard.dart';
import '../widgets/IdCard.dart';
import '../widgets/NavigationDrawer.dart' as NavigationDrawer;
import '../widgets/UserCard.dart';
import '../../constants/colors.dart';
import '../widgets/ProfileListCard.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: myColors.kPrimary,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      backgroundColor: myColors.kFrameBackground,
      drawer:  const NavigationDrawer.NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: myColors.kPrimary,
        elevation: 0,
        title: const Center(
          child: Text('Профиль сотрудника'),
        ),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 19.5),
            child: InkWell(
              onTap: () {},
              child: const Icon(Icons.search_rounded),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: myColors.kPrimary,
        child: const Icon(Icons.chat_outlined),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.only(top: 14.h, left: 13.w, right: 13.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 160.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Expanded(
                    flex: 57,
                    child:
                        UserCard('Роман Маленников', 'roman_mal@empl.atb.ru'),
                  ),
                  Expanded(
                    flex: 43,
                    child: IdCard(00000001, 'Сотрудник'),
                  )
                ],
              ),
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: Container(
                padding: EdgeInsets.all(9.sp),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 122.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.only(top: 5.h, left: 4.w, right: 4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text('Ближайшее бронирование'),
                            Image(image: AssetImage('assets/images/Union.png'))
                          ],
                        ),
                      ),
                      const BookingCard('Окатовая 12', 'Рабочее место', 1, 1),
                      Container(
                        margin: const EdgeInsets.only(top: 11),
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(width: 1, color: Colors.grey))),
                        child: const Text('Посмотреть полный список'),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 122.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 5.h, left: 6.w, right: 6.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text('Команды'),
                          Image(image: AssetImage('assets/images/Union.png'))
                        ],
                      ),
                    ),
                    const Text('Здесь пока пусто'),
                    Container(
                      margin: const EdgeInsets.only(top: 11),
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(width: 1, color: Colors.grey))),
                      child: const Text('Посмотреть полный список'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
