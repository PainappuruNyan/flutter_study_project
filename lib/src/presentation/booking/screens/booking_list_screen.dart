import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/booking_card.dart' as booking;
import '../../widgets/navigation_drawer.dart' as NavigationDrawer;

TabBar get _tabBar => const TabBar(
      tabs: <Widget>[
        Tab(
          text: 'Текущее',
        ),
        Tab(text: 'История')
      ],
    );

class BookingListScreen extends StatelessWidget {
  const BookingListScreen({super.key});

  static const String routeName = '/booking_list';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: const Center(child: Text('Бронирования')),
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
            children: const <Widget>[
              booking.BookingCard('Владивосток, Окатовая 12', 'Рабочее место',
                  0000001, 0000001),
              booking.BookingCard(
                  'Владивосток, Спортивная', 'Рабочее место', 0000002, 0000002),
            ],
          )),
          SingleChildScrollView(
              child: Column(
            children: const <Widget>[
              booking.BookingCard('Владивосток, Окатовая 12', 'Рабочее место',
                  0000001, 0000001),
              booking.BookingCard('Владивосток, Спортивная 15', 'Рабочее место',
                  0000002, 0000002),
              booking.BookingCard('Владивосток, Спортивная 11', 'Рабочее место',
                  0000002, 0000002),
              booking.BookingCard('Владивосток, Спортивная 12', 'Рабочее место',
                  0000002, 0000002),
              booking.BookingCard('Владивосток, Спортивная 12', 'Рабочее место',
                  0000002, 0000002),
            ],
          )),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
