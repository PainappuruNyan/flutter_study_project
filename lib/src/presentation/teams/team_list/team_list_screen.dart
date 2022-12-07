import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/team_list/team_list_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../shared_widgets/navigation_drawer.dart' as NavigationDrawer;
import '../../shared_widgets/team_card.dart' as teams;
import 'package:atb_first_project/dependency_injection_container.dart' as di;

import '../team_create/team_create_screen.dart';

TabBar get _tabBar => const TabBar(
      tabs: <Widget>[
        Tab(
          text: 'Мои',
        ),
        Tab(text: 'Все')
      ],
    );

class TeamListScreen extends StatelessWidget {
  const TeamListScreen({super.key});

  static const String routeName = '/team_list';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TeamListBloc>(
      create: (BuildContext context) =>
          TeamListBloc(di.sl())..add(GetTeamList()),
      child: const TeamListView(),
    );
  }
}

class TeamListView extends StatefulWidget {
  const TeamListView({super.key});

  @override
  State<TeamListView> createState() => _TeamListView();
}

class _TeamListView extends State<TeamListView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: MyColors.kFrameBackground,
        appBar: AppBar(
            title: const Text('Команды'),
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: Colors.white,
                child: _tabBar,
              ),
            )),
        drawer: const NavigationDrawer.NavigationDrawer(),
        body: TabBarView(children: <Widget>[
          BlocBuilder<TeamListBloc, TeamListState>(
              builder: (BuildContext context, TeamListState state) {
            if (state is TeamListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TeamListLoaded) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.lengthMyTeam,
                  itemBuilder: (BuildContext context, int index) {
                    return teams.TeamCard(
                      team: state.myTeamList.teams[index]
                    );
                  });
            } else if (state is TeamListError) {
              return Text(state.message);
            }

            return const Text('');
          }),
          BlocBuilder<TeamListBloc, TeamListState>(
              builder: (BuildContext context, TeamListState state) {
            if (state is TeamListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TeamListLoaded) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.lengthAllTeam,
                  itemBuilder: (BuildContext context, int index) {
                    return teams.TeamCard(
                      team: state.allTeamList.teams[index],
                    );
                  });
            } else if (state is TeamListError) {
              return Text(state.message);
            }

            return const Text('');
          })
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => TeamCreateScreen()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
