import 'package:atb_first_project/dependency_injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bloc/team_list/team_list_bloc.dart';
import '../../../bloc/teammate_list/teammate_list_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/team_model.dart';
import '../../booking/create_booking_1/create_booking_1.dart';
import '../add_teammate/add_teammate.dart';
import '../team_create/team_create_screen.dart';
import '../teammate_list/teammate_list.dart';

class TeamDetailsScreen extends StatelessWidget {
  const TeamDetailsScreen(
      {super.key, required this.e, required this.bloc, required this.mateBloc});

  final TeamModel e;
  final TeamListBloc bloc;
  final TeammateListBloc mateBloc;

  static const String routeName = '/team_details_screen';

  @override
  Widget build(BuildContext context) {
    final SharedPreferences prefs = di.sl();
    bool isLead = false;
    e.leaderId == prefs.getInt('id') ? isLead = true : false;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Детали команды',
          )),
      body: SingleChildScrollView(
        child: Center(
            child: Column(children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 30, bottom: 40),
                child: Text(
                  e.name,
                  textAlign: TextAlign.center,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline4,
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 30.sp, left: 10.sp),
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(
                          color: Colors.deepOrange,
                          width: 1.2,
                        ))),
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 300.w,
                        padding: EdgeInsets.only(left: 10.sp),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade300,
                                ))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text.rich(
                              TextSpan(
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline6,
                                  text: 'Лидер: ',
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: e.leaderName,
                                        style:
                                        Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText2),
                                  ]),
                            ),
                          ],
                        )),
                    Container(
                        width: 300.w,
                        padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 0.5.w,
                                ))),
                        child: Text.rich(
                          TextSpan(
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6,
                              text: 'Количество участников: ',
                              children: <TextSpan>[
                                TextSpan(
                                    text: e.membersNumber.toString(),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyText2),
                              ]),
                        )),
                    Container(
                        width: 300.w,
                        padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 0.5.w,
                                ))),
                        child: Text.rich(
                          TextSpan(
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6,
                              text: 'Id: ',
                              children: <TextSpan>[
                                TextSpan(
                                    text: e.id.toString(),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyText2),
                              ]),
                        )),
                    SizedBox(
                      height: 14.h,
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 54.sp),
                width: 286.w,
                child: MaterialButton(
                  onPressed: () {
                    context
                        .read<TeammateListBloc>()
                        .add(GetTeammateList(teamId: e.id));
                    final List<int> holdersId = context
                        .read<TeammateListBloc>()
                        .holdersId;
                    Navigator.push(
                        context,
                        MaterialPageRoute<CreateBooking1>(
                            builder: (BuildContext context) =>
                                CreateBooking1(holdersId: holdersId)));
                  },
                  color: MyColors.kPrimary,
                  child: const Text('Забронировать на команду',
                      style: TextStyle(fontSize: 16.0, color: Colors.white)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.sp),
                width: 286.w,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<TeamMateList>(
                        builder: (_) =>
                            TeamMateList(
                              teamName: e.name,
                              teamId: e.id,
                              isLead: isLead,
                            )));
                  },
                  child: const Text('Участники команды',
                      style: TextStyle(
                          fontSize: 16.0, color: MyColors.kPrimary)),
                ),
              ),
              Visibility(
                visible: isLead,
                child: Container(
                  padding: EdgeInsets.only(top: 10.sp),
                  width: 286.w,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute<TeamMateList>(
                              builder: (_) =>
                                  AddTeammate(
                                    teamId: e.id,
                                  )));
                    },
                    child: const Text('Добавить участника',
                        style: TextStyle(
                            fontSize: 16.0, color: MyColors.kPrimary)),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.sp),
                width: 286.w,
                child: MaterialButton(
                  onPressed: () {
                    context.read<TeammateListBloc>().add(TeammateDelete(
                        teamId: e.id, employeeId: prefs.getInt('id')!));
                    Navigator.of(context).pop(context);
                  },
                  child: const Text('Выйти из команды',
                      style: TextStyle(
                          fontSize: 16.0, color: MyColors.kPrimary)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.sp),
                width: 286.w,
                child: MaterialButton(
                  onPressed: () async {
                    context.read<TeamListBloc>().add(TeamDelete(id: e.id));
                    await Future.delayed(
                        const Duration(milliseconds: 50), () {});
                    Navigator.of(context).pop();
                  },
                  child: const Text('Удалить команду',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: MyColors.kPrimary,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) =>
                  TeamCreateScreen(isEdit: true, teamId: e.id,)));
        },
        child: const Icon(
          Icons.edit,
        ),
      ),
    );
  }
}
