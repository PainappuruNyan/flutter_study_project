import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../shared_widgets/navigation_drawer.dart' as NavigationDrawer;
import '../../shared_widgets/team_card.dart' as teams;

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
    return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: MyColors.kFrameBackground,
            appBar: AppBar(
                title: const Center(child: Text('Команды')),
                actions: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 19.5.sp),
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
            body: TabBarView(children: <Widget>[
              SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  teams.TeamCard('Какое-то название',
                      'Какое-то имя', 'Участник'),
                  teams.TeamCard('Какое-то название',
                      'Какое-то имя', 'Участник'),
                ],
              )),
              SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  teams.TeamCard('Какое-то название',
                      'Какое-то имя', 'Участник'),
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
