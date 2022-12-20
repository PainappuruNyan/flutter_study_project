import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../bloc/team_list/team_list_bloc.dart';
import '../../../bloc/teammate_list/teammate_list_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/team_model.dart';
import '../add_teammate/add_teammate.dart';
import '../team_list/team_list_screen.dart';
import '../teammate_list/teammate_list.dart';
import 'package:atb_first_project/dependency_injection_container.dart' as di;

class TeamDetailsScreen extends StatelessWidget {
  const TeamDetailsScreen({super.key, required this.e, required this.bloc, required this.mateBloc});

  final TeamModel e;
  final TeamListBloc bloc;
  final TeammateListBloc mateBloc;

  static const String routeName = '/team_details_screen';

  @override
  Widget build(BuildContext context) {
    final SharedPreferences prefs = di.sl();
    bool isLead = false;
    e.leaderId == prefs.getInt('id')? isLead = true : false;
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
              style: Theme.of(context).textTheme.headline4,
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
                              style: Theme.of(context).textTheme.headline6,
                              text: 'Лидер: ',
                              children: <TextSpan>[
                                TextSpan(
                                    text: e.leaderId.toString(),
                                    style: Theme.of(context).textTheme.bodyText2),
                              ]),
                        ),
                        Text(
                          'id0000001',
                          style: Theme.of(context).textTheme.caption,
                        )
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
                          style: Theme.of(context).textTheme.headline6,
                          text: 'Id: ',
                          children: <TextSpan>[
                            TextSpan(
                                text: e.id.toString(),
                                style: Theme.of(context).textTheme.bodyText2),
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
              onPressed: () {},
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
                    builder: (_) => TeamMateList(teamName: e.name, teamId: e.id, isLead: isLead,)));
              },
              color: MyColors.kWhite,
              child: const Text('Участники команды',
                  style: TextStyle(fontSize: 16.0, color: MyColors.kPrimary)),
            ),
          ),
              Visibility(
                visible: isLead,
                child: Container(
                  padding: EdgeInsets.only(top: 10.sp),
                  width: 286.w,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute<TeamMateList>(
                          builder: (_) => AddTeammate(teamId: e.id,)));
                    },
                    color: MyColors.kWhite,
                    child: const Text('Добавить участника',
                        style: TextStyle(fontSize: 16.0, color: MyColors.kPrimary)),
                  ),
                ),
              ),
          Container(
            padding: EdgeInsets.only(top: 10.sp),
            width: 286.w,
            child: MaterialButton(
              onPressed: () {
                mateBloc.add(TeammateDelete(teamId: e.id, employeeId: prefs.getInt('id')!));
                Navigator.of(context).pop(context);
              },
              color: MyColors.kWhite,
              child: const Text('Выйти из команды',
                  style: TextStyle(fontSize: 16.0, color: MyColors.kPrimary)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.sp),
            width: 286.w,
            child: MaterialButton(
              onPressed: () {
                bloc.add(TeamDelete(id: e.id));
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const TeamListScreen()));
              },
              color: MyColors.kWhite,
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
        },
        child: const Icon(
          Icons.edit,
        ),
      ),
    );
  }
}
