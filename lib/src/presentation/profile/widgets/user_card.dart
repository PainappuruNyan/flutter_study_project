import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserCard extends StatelessWidget {
  const UserCard(this.name, this.email, {super.key});

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        padding: EdgeInsets.all(9.sp),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image(image: const AssetImage('assets/images/Group 1740.png'), height: 80.sp, width: 80.sp,),
            Container(

              margin:  EdgeInsets.only(top: 16.h, left: 8.w, right: 8.w),
              child: Text(name, textAlign: TextAlign.center,),
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
