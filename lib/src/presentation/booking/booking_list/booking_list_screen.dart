import 'package:atb_first_project/dependency_injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/booking_list/booking_list_bloc.dart';
import '../../../bloc/profile/profile_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../shared_widgets/booking_card.dart';
import '../../shared_widgets/navigation_drawer.dart' as NavigationDrawer;
import '../create_booking_1/create_booking_1.dart';



class BookingListScreen extends StatelessWidget {
  const BookingListScreen({super.key, required this.isOfficeBooking, this.officeId, });

  static const String routeName = '/booking_list';

  final bool isOfficeBooking;
  final int? officeId;

  TabBar get _tabBarPerson {
    if(isOfficeBooking){
      return const TabBar(
        tabs: <Widget>[
          Tab(
            text: 'Рабочие',
          ),
          Tab(text: 'Переговорки')
        ],
      );
    }
    else{
      return const TabBar(
        tabs: <Widget>[
          Tab(
            text: 'Текущее',
          ),
          Tab(text: 'История')
        ],
      );
    }
    }


  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingListBloc>(
      create: (BuildContext context) => BookingListBloc(di.sl(), isOfficeBooking, officeId)..add(GetBookingList()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: const Text('Бронирования'),
              bottom: PreferredSize(
                preferredSize: _tabBarPerson.preferredSize,
                child: Material(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: _tabBarPerson,
                ),
              )),
          drawer: const NavigationDrawer.NavigationDrawer(),
          body: const BookingListView(),
          floatingActionButton: !isOfficeBooking ? FloatingActionButton(
            onPressed: () {Navigator.push(context, MaterialPageRoute(
                builder: (_) =>
                    CreateBooking1(holdersId: [context.read<ProfileBloc>().userId])));},
            child: const Icon(Icons.add),
          ) : null,
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
