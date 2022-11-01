import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/BookingCard.dart' as booking;
import '../widgets/NavigationDrawer.dart' as NavigationDrawer;

TabBar get _tabBar =>
    const TabBar(
      labelColor: Colors.deepOrange,
      indicatorColor: Colors.deepOrangeAccent,
      tabs: [
        Tab(
          text: 'Текущее',
        ),
        Tab(text: 'История')
      ],
    );

class BookingListScreen extends StatelessWidget {

  static const String routeName = '/booking_list';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.deepOrange),
            backgroundColor: Colors.deepOrange,
            title: const Center(child: Text('Бронирования')),
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
                children: const [
                  booking.BookingCard('Владивосток, Окатовая 12',
                      'Рабочее место', 0000001, 0000001),
                  booking.BookingCard('Владивосток, Спортивная',
                      'Рабочее место', 0000002, 0000002),
                ],
              )),
          Center(
              child: Column(
                children: const [
                  booking.BookingCard('Владивосток, Окатовая 12',
                      'Рабочее место', 0000001, 0000001),
                  booking.BookingCard('Владивосток, Спортивная 15',
                      'Рабочее место', 0000002, 0000002),
                  booking.BookingCard('Владивосток, Спортивная 11',
                      'Рабочее место', 0000002, 0000002),
                  booking.BookingCard('Владивосток, Спортивная 12',
                      'Рабочее место', 0000002, 0000002),
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
