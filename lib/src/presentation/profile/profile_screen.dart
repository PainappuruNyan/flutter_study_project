import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../../core/constants/colors.dart';
import '../../data/repositories/employee_repository_impl.dart';
import '../../domain/entities/employee.dart';
import '../routes/routes.dart';
import '../shared_widgets/booking_card.dart';
import '../shared_widgets/navigation_drawer.dart' as NavigationDrawer;
import 'widgets/id_card.dart';
import 'widgets/user_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.login});

  static const String routeName = '/profile';
  final String login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.kFrameBackground,
        drawer: const NavigationDrawer.NavigationDrawer(),
        appBar: AppBar(
          backgroundColor: MyColors.kPrimary,
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
          backgroundColor: MyColors.kPrimary,
          child: const Icon(Icons.chat_outlined),
        ),
        body: BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(login: login)..add(ProfileStarted()),
          child: const ProfileScreenView(),
        ));
  }
}

class ProfileScreenView extends StatefulWidget {
  const ProfileScreenView({super.key});

  @override
  State<ProfileScreenView> createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {
  Employee employee = const Employee(
      id: 0, login: 'login', role: 'role', fullName: 'Test', email: 'email',
    phoneNumber: '1', photo: null, );
  late SharedPreferences sharedPreferences;
  late EmployeeRepositoryImpl employeeRepositoryImpl;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColors.kPrimary,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ));
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.only(top: 14.h, left: 13.w, right: 13.w),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (BuildContext context, ProfileState state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 57,
                        child: UserCard(employee.fullName, 'roman_mal@empl.atb.ru'),
                      ),
                      Flexible(
                        flex: 43,
                        child: IdCard(employee.id, employee.role),
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
                            margin: EdgeInsets.only(
                                top: 5.h, left: 4.w, right: 4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Ближайшее бронирование',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Image(
                                    image:
                                        AssetImage('assets/images/Union.png'))
                              ],
                            ),
                          ),
                          const BookingCard(
                              'Окатовая 12', 'Рабочее место', 1, 1),
                          Container(
                            margin: const EdgeInsets.only(top: 11),
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(color: Colors.grey))),
                            child: InkWell(
                              child: Text('Посмотреть полный список'),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.booking_list);
                              },
                            ),
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
                  child: Container(
                    padding: EdgeInsets.all(9.sp),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: 122.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                top: 5.h, left: 6.w, right: 6.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Команды',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Image(
                                    image:
                                        AssetImage('assets/images/Union.png'))
                              ],
                            ),
                          ),
                          Text(
                            'Здесь пока пусто',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 11),
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(color: Colors.grey))),
                            child: InkWell(
                              child: Text('Посмотреть полный список'),
                              onTap: () {
                                Navigator.pushNamed(context, Routes.team_list);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return Container(
            alignment: Alignment.center,
            child: Text('get an error'),
          );
        },
      ),
    ));
  }
}
