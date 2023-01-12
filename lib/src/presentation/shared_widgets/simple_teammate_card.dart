import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dependency_injection_container.dart' as di;
import '../../core/constants/colors.dart';
import '../../domain/entities/employee.dart';

class SimpleTeammateCard extends StatelessWidget {
  const SimpleTeammateCard({
    super.key,
    required this.employee,
    this.onTap,
    this.onLongTap,
    this.selectedPlace,
    required this.isSelected,
  });

  final Employee employee;
  final dynamic onTap;
  final dynamic onLongTap;
  final int? selectedPlace;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final int? imageId = employee.imageId;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: isSelected
            ? const BorderSide(color: MyColors.kPrimary, width: 2)
            : BorderSide.none,
      ),
      elevation: 4,
      margin: EdgeInsets.only(left: 30.sp, right: 30.sp, top: 16.sp),
      child: InkWell(
        onLongPress: () {},
        onTap: () {
          onTap();
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10.sp, bottom: 8.sp),
              child: Row(children: <Widget>[
                CircleAvatar(
                  radius: 29,
                  backgroundImage: imageId != null
                      ? NetworkImage('http://10.0.2.2:8080/image/$imageId',
                          headers: <String, String>{
                              HttpHeaders.authorizationHeader:
                                  'Basic ${base64.encode(utf8.encode('$username:$password'))}'
                            })
                      : const AssetImage('assets/images/Group 1740.png')
                          as ImageProvider,
                ),
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
                        const Text('Место: '),
                        Text('$selectedPlace')
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
