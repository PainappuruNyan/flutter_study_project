import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dependency_injection_container.dart' as di;
import '../../bloc/profile/profile_bloc.dart';
import '../../core/constants/colors.dart';
import '../../data/repositories/employee_repository_impl.dart';
import '../booking/booking_list/booking_list_screen.dart';
import '../booking/create_booking_1/create_booking_1.dart';
import '../routes/routes.dart';
import '../shared_widgets/booking_card.dart';
import '../shared_widgets/navigation_drawer.dart' as NavigationDrawer;
import '../shared_widgets/team_card.dart';
import '../teams/team_create/team_create_screen.dart';
import 'widgets/id_card.dart';
import 'widgets/user_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String routeName = 'profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavigationDrawer.NavigationDrawer(),
        appBar: AppBar(
          elevation: 0,
          title: const Text('Профиль сотрудника'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.feedback);
          },
          backgroundColor: MyColors.kPrimary,
          child: const Icon(Icons.chat_outlined),
        ),
        body: const ProfileScreenView());
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
    context.read<ProfileBloc>().add(ProfileStarted());
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (BuildContext context, ProfileState state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProfileLoaded) {
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
                          flex: 55,
                          child: UserCard(state.profile.employee.fullName,
                              state.profile.employee.email, imageId: state.profile.employee.imageId),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        Flexible(
                          flex: 43,
                          child: IdCard(
                            state.profile.employee.id,
                            state.profile.employee.roleString,
                            login: state.profile.employee.login,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    child: Card(
                      color: Theme.of(context).canvasColor,
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.only(top: 14.h),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 122.h,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 14.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Бронивания',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    CreateBooking1(holdersId: [prefs.getInt('id')!],))).then((_)  {
                                              context.read<ProfileBloc>().add(ProfileStarted());
                                        });
                                      },
                                      child: Icon(Icons.add_box_outlined),
                                    )
                                  ],
                                ),
                              ),
                              if (state.profile.bookings != null) ...[
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 9.w),
                                  child: BookingCard(
                                      booking: state.profile.bookings!),
                                ),
                              ] else ...[
                                Text(
                                  'Здесь пока пусто',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 11.h),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey))),
                                      child: InkWell(
                                        child: Padding(
                                          padding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                          child: Text(
                                            'Весь список',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  color: MyColors.kTextSecondary,
                                                ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context, MaterialPageRoute(
                                              builder: (_) =>
                                                  BookingListScreen(isOfficeBooking: false,))).then((_)  {
                                            context.read<ProfileBloc>().add(ProfileStarted());
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Theme.of(context).canvasColor,
                    elevation: 2,
                    child: Container(
                      padding: EdgeInsets.only(top: 14.h),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 122.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Команды',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  TeamCreateScreen())).then((_)  {
                                        context.read<ProfileBloc>().add(ProfileStarted());
                                      });
                                    },
                                    child: Icon(Icons.add_box_outlined),
                                  )
                                ],
                              ),
                            ),
                            if (state.profile.teams!=null) ...[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 9.w),
                                  child: TeamCard(
                                team: state.profile.teams!,
                              )),
                            ] else ...[
                              Text(
                                'Здесь пока пусто',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 11.h),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.grey))),
                                    child: InkWell(
                                      child: Padding(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                        child: Text(
                                          'Весь список',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                color: MyColors.kTextSecondary,
                                              ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.team_list).then((_)  {
                                          context.read<ProfileBloc>().add(ProfileStarted());
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
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
        return const Center(
          child: Text('something off'),
        );
      },
    );
  }
}
