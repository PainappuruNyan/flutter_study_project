import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dependency_injection_container.dart' as di;
import '../../bloc/profile/profile_bloc.dart';
import '../../core/constants/colors.dart';
import '../../data/repositories/employee_repository_impl.dart';
import '../routes/routes.dart';
import '../shared_widgets/booking_card.dart';
import '../shared_widgets/navigation_drawer.dart' as NavigationDrawer;
import '../shared_widgets/team_card.dart';
import '../teams/team_create/team_create_screen.dart';
import 'widgets/id_card.dart';
import 'widgets/user_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProfileBloc()..add(ProfileStarted()),
      child: Scaffold(
          backgroundColor: MyColors.kFrameBackground,
          drawer: const NavigationDrawer.NavigationDrawer(),
          appBar: AppBar(
            elevation: 0,
            title: const Text('Профиль сотрудника'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: MyColors.kPrimary,
            child: const Icon(Icons.chat_outlined),
          ),
          body: ProfileScreenView()),
    );
  }
}

class ProfileScreenView extends StatefulWidget {
  const ProfileScreenView({super.key});

  @override
  State<ProfileScreenView> createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {

  final SharedPreferences prefs = di.sl();
  late EmployeeRepositoryImpl employeeRepositoryImpl;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColors.kPrimary,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ));
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (BuildContext context, ProfileState state) {
        if (state is ProfileLoading) {
          return Center(child: CircularProgressIndicator(),);
        }
        if (state is ProfileLoaded) {
          // prefs.setString('login', state.profile.employee.login);
          // prefs.setString('role', state.profile.employee.role);
          // prefs.setInt('id', state.profile.employee.id);
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 14.h, left: 13.w, right: 13.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          flex: 57,
                          child: UserCard(state.profile.employee.fullName, state.profile.employee.email),
                        ),
                        Flexible(
                          flex: 43,
                          child: IdCard(state.profile.employee.id,
                              'Админ', login: state.profile.employee.login,),
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
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Ближайшее бронирование',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .subtitle2,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Navigator.pushNamed(context, Routes.booking_create_1);
                                    },
                                    child: const Image(
                                        image: AssetImage(
                                            'assets/images/Union.png')),
                                  )
                                ],
                              ),
                            ),
                            if(state.profile.bookings!.isNotEmpty)...[
                              BookingCard(booking: state.profile.bookings![0]),
                            ]
                            else...[
                              Text(
                                'Здесь пока пусто',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,
                              ),
                            ],
                            Container(
                              margin: const EdgeInsets.only(top: 11),
                              decoration: const BoxDecoration(
                                  border:
                                  Border(top: BorderSide(color: Colors.grey))),
                              child: InkWell(
                                child: const Text('Посмотреть полный список'),
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
                              margin:
                              EdgeInsets.only(top: 5.h, left: 6.w, right: 6.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Команды',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .subtitle2,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (_) => TeamCreateScreen()));
                                    },
                                    child: const Image(
                                        image: AssetImage(
                                            'assets/images/Union.png')),
                                  )
                                ],
                              ),
                            ),
                            if(state.profile.teams!.isNotEmpty)...[
                              TeamCard(team: state.profile.teams![0],),
                            ]
                            else...[
                              Text(
                                'Здесь пока пусто',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,
                              ),
                            ],
                            Container(
                              margin: const EdgeInsets.only(top: 11),
                              decoration: const BoxDecoration(
                                  border:
                                  Border(top: BorderSide(color: Colors.grey))),
                              child: InkWell(
                                child: const Text('Посмотреть полный список'),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.team_list);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Center(child: Text('something off'),);
      },
    );
  }
}
