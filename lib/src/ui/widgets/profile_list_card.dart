import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileListCard extends StatefulWidget {
  const ProfileListCard(this.title, this.innerElement, {super.key});

  final String title;
  final Widget innerElement;

  @override
  State<ProfileListCard> createState() => _ProfileListCardState();
}

class _ProfileListCardState extends State<ProfileListCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
      ),
      child: Container(
        padding: EdgeInsets.all(9.sp),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 122.h,
          ),
          child: Column(
            children: const <Widget>[
              Text('Ближайшее бронирование'),
            ],
          ),
        ),
      ),
    );
  }
}
