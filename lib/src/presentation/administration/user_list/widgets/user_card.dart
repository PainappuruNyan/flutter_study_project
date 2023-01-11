import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/entities/employee.dart';
import 'package:atb_first_project/dependency_injection_container.dart' as di;


class UserCard extends StatelessWidget {

  const UserCard(
      {super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs = di.sl();
    final String? username = prefs.getString('username');
    final String? password = prefs.getString('password');
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      margin: EdgeInsets.only(left: 30.sp, right: 30.sp, top: 16.sp),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.sp, bottom: 8.sp),
            child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 40.sp,
                    backgroundColor: null,
                    backgroundImage: employee.imageId != null
                        ? NetworkImage('http://10.0.2.2:8080/image/${employee.imageId}',
                        headers: <String, String>{
                          HttpHeaders.authorizationHeader:
                          'Basic ${base64.encode(utf8.encode('$username:$password'))}'
                        })
                        : AssetImage('assets/images/Group 1740.png') as ImageProvider,),
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
    );
  }
}
