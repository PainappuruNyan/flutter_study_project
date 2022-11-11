import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';

class TeamCard extends StatelessWidget {

  TeamCard(this.teamName, this.userName, this.userTeamRole, {super.key});
  String teamName = '';
  String userName = '';
  String userTeamRole = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 14.5.sp, right: 14.5.sp, top: 16.sp),
      child: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: MyColors.kPrimary)),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 9.sp, bottom: 6.sp),
                          child: Text(
                            teamName,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(bottom: 11.sp),
                          child: Text(
                            userName,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                      ],
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10.sp),
                        height: 59.h,
                        width: 800.w,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(4),
                              bottomRight: Radius.circular(4)),
                          color: MyColors.kSecondary,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10.sp),
                              height: 39.h,
                              width: 130.w,
                              decoration: BoxDecoration(
                                  border: Border.all(color: MyColors.kWhite, width: 1.w),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                color: MyColors.kSecondary,
                              ),
                              child: Text(
                                userTeamRole,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                          ],
                        )),
                  ],
                ))
          ],
        ),
    );
  }
}
