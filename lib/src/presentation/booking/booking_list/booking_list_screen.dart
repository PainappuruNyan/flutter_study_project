import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../shared_widgets/booking_card.dart';
import '../../shared_widgets/navigation_drawer.dart' as NavigationDrawer;
import '../../../bloc/booking_list/booking_list_bloc.dart';
import '../../routes/routes.dart';
import '../../../data/repositories/booking_repository_test.dart';

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
      create: (BuildContext context) => BookingListBloc(FakeBookingRepository())..add(GetBookingList()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: MyColors.kFrameBackground,
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
                    return BookingCard(state.bookingListActual[index].address, state.bookingListActual[index].place, state.bookingListActual[index].bookingId, state.bookingListActual[index].placeId);
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
                    return BookingCard(state.bookingListHistory[index].address, state.bookingListHistory[index].place, state.bookingListHistory[index].bookingId, state.bookingListHistory[index].placeId);
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
