import 'package:atb_first_project/src/data/models/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/team_list/team_list_bloc.dart';
import '../../bloc/teammate_list/teammate_list_bloc.dart';
import '../../core/constants/colors.dart';
import '../teams/team_details/team_details_screen.dart';

class TeamCard extends StatelessWidget {
  const TeamCard({
    super.key,
    required this.team,
  });

  final TeamModel team;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 14.5.sp, right: 14.5.sp, top: 16.sp),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (_) => TeamDetailsScreen(
                          e: team,
                          bloc: context.read<TeamListBloc>(),
                          mateBloc: context.read<TeammateListBloc>())))
                  .then((_) {
                context.read<TeamListBloc>().add(GetTeamList());
                context.read<ProfileBloc>().add(ProfileStarted());

              });
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: MyColors.kPrimary)),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 9.sp, bottom: 6.sp),
                          child: Text(
                            team.name,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 18.sp),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(bottom: 11.sp),
                          child: Text(
                            'Лидер: ${team.leaderName}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 18.sp),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(bottom: 11.sp),
                          child: Text(
                            'Участников: ${team.membersNumber}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 18.sp),
                          ),
                        ),
                      ],
                    ),
                    // Container(
                    //     padding: EdgeInsets.symmetric(vertical: 10.sp),
                    //     height: 59.h,
                    //     width: 800.w,
                    //     decoration: const BoxDecoration(
                    //       borderRadius: BorderRadius.only(
                    //           bottomLeft: Radius.circular(4),
                    //           bottomRight: Radius.circular(4)),
                    //       color: MyColors.kSecondary,
                    //     ),
                    //     child: InkWell(
                    //       onTap: () {
                    //         Navigator.of(context).push(MaterialPageRoute(
                    //             builder: (_) => TeamDetailsScreen(
                    //                 e: team,
                    //                 bloc: context.read<TeamListBloc>(),
                    //                 mateBloc: context.read<TeammateListBloc>())));
                    //       },
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: <Widget>[
                    //           Container(
                    //             padding: EdgeInsets.symmetric(vertical: 10.sp),
                    //             height: 39.h,
                    //             width: 130.w,
                    //             decoration: BoxDecoration(
                    //               border: Border.all(
                    //                   color: MyColors.kWhite, width: 1.w),
                    //               borderRadius:
                    //                   const BorderRadius.all(Radius.circular(8)),
                    //               color: MyColors.kSecondary,
                    //             ),
                    //             child: Text(
                    //               'Роль',
                    //               textAlign: TextAlign.center,
                    //               style: Theme.of(context).textTheme.bodyText1,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     )),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
