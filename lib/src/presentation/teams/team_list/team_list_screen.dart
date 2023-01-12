import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependency_injection_container.dart' as di;
import '../../../bloc/team_list/team_list_bloc.dart';
import '../../../bloc/teammate_list/teammate_list_bloc.dart';
import '../../shared_widgets/navigation_drawer.dart' as navigation_drawer;
import '../../shared_widgets/team_card.dart' as teams;
import '../team_create/team_create_screen.dart';

class TeamListScreen extends StatelessWidget {
  const TeamListScreen({super.key});

  static const String routeName = '/team_list';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TeamListBloc>(
          create: (BuildContext context) =>
              TeamListBloc(di.sl())..add(const GetTeamList()),
        ),
        BlocProvider<TeammateListBloc>(
            create: (BuildContext context) => TeammateListBloc(di.sl()))
      ],
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
        appBar: AppBar(
          title: const Text('Команды'),
        ),
        drawer: const navigation_drawer.NavigationDrawer(),
        body: BlocBuilder<TeamListBloc, TeamListState>(
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
                  return teams.TeamCard(team: state.myTeamList.teams[index]);
                });
          } else if (state is TeamListError) {
            return Text(state.message);
          }

          return const Text('');
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute<dynamic>(
                    builder: (_) => const TeamCreateScreen()))
                .then((Object? value) {
              context.read<TeamListBloc>().add(const GetTeamList());
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
