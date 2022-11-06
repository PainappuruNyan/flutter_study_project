import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';

class IdCard extends StatelessWidget {
  const IdCard(this.id, this.role,{super.key});

  final int id;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
      ),
      child: Container(
        padding: EdgeInsets.all(9.sp),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                const Text(
                  'Роль: ',
                  style: TextStyle(color: MyColors.kPrimary,),
                ),
                Text(role)
              ],
            ),
            Text('Id ${id.toString()}', style: Theme.of(context).textTheme.bodySmall,),
          ],
        ),
      ),
    );
  }
}
