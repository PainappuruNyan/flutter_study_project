import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/TeamCard.dart' as teams;
import '../widgets/NavigationDrawer.dart' as NavigationDrawer;

TabBar get _tabBar => const TabBar(
      labelColor: Colors.deepOrange,
      indicatorColor: Colors.deepOrangeAccent,
      tabs: [
        Tab(
          text: 'Мои',
        ),
        Tab(text: 'Все')
      ],
    );

class TeamListScreen extends StatelessWidget {

  static const String routeName = '/team_list';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.deepOrange),
                backgroundColor: Colors.deepOrange,
                title: const Center(child: Text('Команды')),
                actions: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(right: 19.5),
                    child: const Icon(Icons.search_rounded),
                  )
                ],
                bottom: PreferredSize(
                  preferredSize: _tabBar.preferredSize,
                  child: Material(
                    color: Colors.white,
                    child: _tabBar,
                  ),
                )),
            drawer: const NavigationDrawer.NavigationDrawer(),
            body: TabBarView(children: [
              Center(
                  child: Column(
                children: [
                  teams.TeamCard('Какое-то название',
                      'Какое-то имя', 'Участник'),
                  teams.TeamCard('Какое-то название',
                      'Какое-то имя', 'Участник'),
                ],
              )),
              Center(
                  child: Column(
                children: [
                  teams.TeamCard('Какое-то название',
                      'Какое-то имя', 'Участник'),
                  teams.TeamCard('Какое-то название',
                      'Какое-то имя', 'Участник'),
                  teams.TeamCard('Какое-то название',
                      'Какое-то имя', 'Участник'),
                  teams.TeamCard('Какое-то название',
                      'Какое-то имя', 'Участник'),
                ],
              )),
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.deepOrange,
              child: const Icon(Icons.add),
            ),
          ),
    );
  }
}
