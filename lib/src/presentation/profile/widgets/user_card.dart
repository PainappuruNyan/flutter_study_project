import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../dependency_injection_container.dart' as di;

class UserCard extends StatelessWidget {
  const UserCard(this.name, this.email, {super.key, required this.imageId});

  final String name;
  final String email;
  final int? imageId;

  @override
  Widget build(BuildContext context) {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    return Card(
      color: Theme.of(context).canvasColor,
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(9.sp),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
              radius: 55.sp,
              backgroundImage: imageId != null
                  ? NetworkImage('http://10.0.2.2:8080/image/$imageId',
                      headers: <String, String>{
                          HttpHeaders.authorizationHeader:
                              'Basic ${base64.encode(utf8.encode('$username:$password'))}'
                        })
                  : const AssetImage('assets/images/Group 1740.png')
                      as ImageProvider,
            ),
            // Image(image: const AssetImage('assets/images/Group 1740.png'), height: 80.sp, width: 80.sp,),
            //'http://10.0.2.2:8080/image/$imageId'
            Container(
              margin: EdgeInsets.only(top: 16.h, left: 8.w, right: 8.w),
              child: Text(
                name,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 8.w, right: 8.sp),
                child: Text(
                  email,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ))
          ],
        ),
      ),
    );
  }
}
