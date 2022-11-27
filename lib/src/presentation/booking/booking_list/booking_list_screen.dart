import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/booking_list/booking_list_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../routes/routes.dart';
import '../../shared_widgets/booking_card.dart';
import '../../shared_widgets/navigation_drawer.dart' as NavigationDrawer;
import 'package:atb_first_project/dependency_injection_container.dart' as di;

TabBar get _tabBar =>
    const TabBar(
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
    return BlocProvider<BookingListBloc>(
      create: (BuildContext context) => BookingListBloc(di.sl())..add(GetBookingList()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: MyColors.kFrameBackground,
          appBar: AppBar(
              title: const Text('Бронирования'),
              bottom: PreferredSize(
                preferredSize: _tabBar.preferredSize,
                child: Material(
                  color: Colors.white,
                  child: _tabBar,
                ),
              )),
          drawer: const NavigationDrawer.NavigationDrawer(),
          body: const BookingListView(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {Navigator.pushNamed(context, Routes.booking_create_1);},
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class BookingListView extends StatefulWidget {
  const BookingListView({super.key});

  @override
  State<BookingListView> createState() => _BookingListView();
}

class _BookingListView extends State<BookingListView> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(children: <Widget>[
      BlocBuilder<BookingListBloc, BookingListState>(
          builder: (BuildContext context, BookingListState state) {
            if (state is BookingListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (state is BookingListLoaded) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.lengthActual,
                  itemBuilder: (BuildContext context, int index) {
                    return BookingCard(booking: state.bookingListActual.bookings[index]);
                  });
            }
            else if (state is BookingListError) {
              return Text(state.message);
            }

            return const Text('');
          }
      ),
      BlocBuilder<BookingListBloc, BookingListState>(
          builder: (BuildContext context, BookingListState state) {
            if (state is BookingListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (state is BookingListLoaded) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.lengthHistory,
                  itemBuilder: (BuildContext context, int index) {
                    return BookingCard(booking: state.bookingListHistory.bookings[index]);
                  });
            }
            else if (state is BookingListError) {
              return Text(state.message);
            }
            else {
              return const Text('');
            }
          }
      ),
    ]);
  }
}
