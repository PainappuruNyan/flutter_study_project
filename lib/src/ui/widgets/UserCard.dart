import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/User.dart';

class UserCard extends StatelessWidget {
  const UserCard(this.name, this.email, {super.key});

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 141.h,
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const Image(image: AssetImage('assets/images/Group 1740.png')),
              Container(
                margin:  EdgeInsets.only(top: 16.h),
                child: Text('$name'),
              ),
              Text('$email')
            ],
          ),
        ),
      ),
    );
  }
}