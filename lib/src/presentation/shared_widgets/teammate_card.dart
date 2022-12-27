import 'dart:convert';
import 'dart:io';

import 'package:atb_first_project/dependency_injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/teammate_list/teammate_list_bloc.dart';
import '../../domain/entities/teammate.dart';

class TeammateCard extends StatelessWidget {
  const TeammateCard(
      {super.key,
      required this.teammate,
      required this.bloc,
      required this.isLead,
      this.imageId});

  final Teammate teammate;
  final TeammateListBloc bloc;
  final bool isLead;
  final int? imageId;

  @override
  Widget build(BuildContext context) {
    final SharedPreferences prefs = di.sl();
    final String? username = prefs.getString('username');
    final String? password = prefs.getString('password');
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        margin: EdgeInsets.only(left: 30.sp, right: 30.sp, top: 16.sp),
        child: InkWell(
          onLongPress: () {
            isLead
                ? showMaterialModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => Container(
                      padding: EdgeInsets.only(left: 30, right: 30, top: 25),
                      height: 100.h,
                      child: Center(
                        child: Column(
                          children: [
                            MaterialButton(
                              onPressed: () {
                                bloc.add(TeammateDelete(
                                    teamId: teammate.teamId,
                                    employeeId: teammate.employeeId));
                                Navigator.of(context).pop(context);
                              },
                              child: const Text('Удалить участника'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('У Вас недостаточно прав')),
                  );
          },
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.sp, bottom: 8.sp),
                child: Row(children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 40.sp,
                    backgroundImage: imageId != null
                        ? NetworkImage('http://10.0.2.2:8080/image/$imageId',
                            headers: <String, String>{
                                HttpHeaders.authorizationHeader:
                                    'Basic ${base64.encode(utf8.encode('$username:$password'))}'
                              })
                        : AssetImage('assets/images/Group 1740.png')
                            as ImageProvider,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${teammate.fullName}',
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
                                        text: '${teammate.roleString}',
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
                                      text: teammate.employeeId.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodyText2)
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 70.sp, right: 5.sp),
                    child: Image(
                      image: const AssetImage('assets/images/coolLogo.png'),
                      height: 45.sp,
                      width: 45.sp,
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
