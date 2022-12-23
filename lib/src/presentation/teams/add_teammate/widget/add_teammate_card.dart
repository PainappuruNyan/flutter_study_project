import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../bloc/teammate_list/teammate_list_bloc.dart';
import '../../../../data/models/teammate_model.dart';
import '../../../../domain/entities/employee.dart';


class AddTeammateCard extends StatelessWidget {

  const AddTeammateCard(
      {super.key, required this.employee, required this.teamId, required this.bloc});

  final Employee employee;
  final int teamId;
  final TeammateListBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      margin: EdgeInsets.only(left: 30.sp, right: 30.sp, top: 16.sp),
      child: InkWell(
        onLongPress: () {
          bloc.add(TeammateAdd(teammate: TeammateModel(teamId: teamId, employeeId: employee.id, id: -1, fullName: '', roleName: '')));
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${employee.fullName} добавлен в команду')));
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10.sp, bottom: 8.sp),
              child: Row(
                  children: <Widget>[
                    Image(image: const AssetImage('assets/images/Group 1740.png'),
                      height: 80.sp,
                      width: 80.sp,),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              employee.fullName,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 6.sp),
                              child: Text.rich(
                                TextSpan(
                                    text: 'Роль: ',
                                    style: Theme.of(context).textTheme.headline6,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: employee.role,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2)
                                    ]),
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  text: 'id: ',
                                  style: Theme.of(context).textTheme.headline6,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: employee.id.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2)
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 70.sp, right: 5.sp),
                      child: Image(image: const AssetImage('assets/images/coolLogo.png'),
                        height: 45.sp,
                        width: 45.sp,),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
