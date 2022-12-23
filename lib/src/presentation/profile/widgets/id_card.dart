import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/colors.dart';

class IdCard extends StatelessWidget {
  const IdCard(this.id, this.role,{super.key, required this.login});

  final int id;
  final String role;
  final String login;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: ()async {
        await Clipboard.setData(ClipboardData(text: login));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Логин скопирован')),
        );
      },
      child: Card(
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
              Text('Login ${this.login}', style: Theme.of(context).textTheme.bodySmall,),
            ],
          ),
        ),
      ),
    );
  }
}
