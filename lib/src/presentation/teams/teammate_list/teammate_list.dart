import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../dependency_injection_container.dart' as di;
import '../../../bloc/teammate_list/teammate_list_bloc.dart';
import '../../shared_widgets/teammate_card.dart';

class TeamMateList extends StatelessWidget {
  const TeamMateList({super.key, required this.teamName, required this.teamId, required this.isLead});

  final String teamName;
  final int teamId;
  final bool isLead;

  static const String routeName = '/teammate_list';


  @override
  Widget build(BuildContext context) {
    return BlocProvider<TeammateListBloc>(
      create: (BuildContext context) =>
      TeammateListBloc(di.sl())
        ..add(GetTeammateList(teamId: teamId)),
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
              title: const Text(
                'Список участников',
              )),
          body: BlocBuilder<TeammateListBloc, TeammateListState>(
            builder: (BuildContext context, TeammateListState state) {
              if (state is TeammateListLoading) {
                return const Center(child: CircularProgressIndicator(),);
              }
              if (state is TeammateListLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 30.sp, bottom: 20.sp),
                        child: Text(
                          teamName,
                          textAlign: TextAlign.center,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4,
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.lengthTeammate,
                          itemBuilder: (BuildContext context, int index) {
                            return TeammateCard(teammate: state.teammateList.teammates[index], bloc: context.read<TeammateListBloc>(), isLead: isLead,);
                          }
                      )
                    ],
                  ),
                );
              }
              else if (state is TeammateListError) {
                return Center(child: Text(state.message),);
              }
              return const Center(child: Text('Ошибка'),);
            }
          )),
    );
  }
}
