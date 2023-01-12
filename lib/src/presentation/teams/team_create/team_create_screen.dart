import 'package:atb_first_project/dependency_injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bloc/team_create/team_create_bloc.dart';
import '../../../bloc/team_list/team_list_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/team_model.dart';
import '../../shared_widgets/navigation_drawer.dart' as NavigationDrawer;

class TeamCreateScreen extends StatefulWidget {
  const TeamCreateScreen({super.key, this.teamId, this.isEdit});

  final int? teamId;
  final bool? isEdit;

  static const String routeName = '/team_create_screen';

  @override
  State<TeamCreateScreen> createState() =>
      _TeamCreateScreenState(teamId: teamId, isEdit: isEdit);
}

TextEditingController teamName = TextEditingController();

class _TeamCreateScreenState extends State<TeamCreateScreen>
    with SingleTickerProviderStateMixin {
  _TeamCreateScreenState({this.teamId, this.isEdit});

  int? teamId;
  bool? isEdit = false;

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2400));
    animationController.addStatusListener((AnimationStatus status) async {
      if (status == AnimationStatus.completed) {
        animationController.reset();
        Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SharedPreferences prefs = di.sl();
    void successAnimation() => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => Center(
              child: SizedBox(
                width: 200.w,
                height: 200.h,
                child: Lottie.asset('assets/animation/success.json',
                    repeat: false, controller: animationController,
                    onLoaded: (LottieComposition composition) {
                  animationController.duration = composition.duration;
                  animationController.forward();
                }),
              ),
            ));
    return BlocProvider<TeamCreateBloc>(
      create: (BuildContext context) =>
          TeamCreateBloc()..add(TeamCreateStart()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Создание команды'),
        ),
        drawer: const NavigationDrawer.NavigationDrawer(),
        body: BlocConsumer<TeamCreateBloc, TeamCreateState>(
          listener: (BuildContext context, TeamCreateState state) async {
            if (state is TeamCreateSuccess) {
              successAnimation();
            }
          },
          builder: (BuildContext context, TeamCreateState state) {
            if (state is TeamCreateLoading) {
              const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TeamCreateLoaded) {
              return SingleChildScrollView(
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(
                            left: 36.5.sp,
                            right: 36.5.sp,
                            top: 70.sp,
                            bottom: 35.sp),
                        child: TextFormField(
                          controller: teamName,
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.bodyText2,
                          decoration: const InputDecoration(
                              labelText: 'Название команды',
                              prefixIcon: Icon(
                                Icons.group,
                                color: MyColors.kPrimary,
                              )),
                        )),
                    Container(
                      padding: EdgeInsets.only(top: 76.sp),
                      width: 286.w,
                      child: MaterialButton(
                        onPressed: () {
                          if (isEdit ?? false) {
                            context.read<TeamListBloc>().add(TeamEdit(
                                team: TeamModel(
                                    id: teamId!,
                                    leaderId: prefs.getInt('id')!,
                                    name: teamName.text,
                                    leaderName: '',
                                    membersNumber: 0)));
                            successAnimation();
                          }
                          context.read<TeamCreateBloc>().add(
                              TeamCreateInfoSelected(
                                  team: TeamModel(
                                      id: -1,
                                      leaderId: prefs.getInt('id')!,
                                      name: teamName.text,
                                      leaderName: '',
                                      membersNumber: 0)));
                        },
                        color: MyColors.kPrimary,
                        child: const Text('Принять',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30.sp, right: 15.sp),
                      width: 286.w,
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
              );
            }
            return const Center(
              child: Text(''),
            );
          },
        ),
      ),
    );
  }
}
