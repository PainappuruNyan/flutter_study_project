import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/booking_create_1/booking_create1_bloc.dart';
import '../../../domain/entities/office.dart';
import '../../shared_widgets/bottom_app_bar.dart';
import 'widgets/office_expandable.dart';

class CreateBooking1 extends StatefulWidget {
  const CreateBooking1({super.key, required this.holdersId});

  static const String routeName = '/create_booking/1';
  final List<int> holdersId;

  @override
  State<CreateBooking1> createState() => _CreateBooking1State();
}

class _CreateBooking1State extends State<CreateBooking1> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingCreate1Bloc>(
      create: (BuildContext context) =>
          BookingCreate1Bloc()..add(BookingCreate1Start()),
      child: CreateBooking1View(
        holdersId: widget.holdersId,
      ),
    );
  }
}

class CreateBooking1View extends StatelessWidget {
  const CreateBooking1View({super.key, required this.holdersId});

  final List<int> holdersId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Новая бронь'),
        ),
        bottomNavigationBar: CustomBottomAppBar(
          pageNum: '1',
          pageCount: '3',
          nextPageButton: false,
          nextRoute: () {},
        ),
        body: BlocBuilder<BookingCreate1Bloc, BookingCreate1State>(
          builder: (BuildContext context, BookingCreate1State state) {
            if (state is BookingCreate1Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is BookingCreate1Loaded) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 11.h, bottom: 25.h),
                      child: Text(
                        'Выберите офис',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 28.h),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.cites.length,
                            itemBuilder: (BuildContext context, int index) {
                              late List<Office> cityOffices;
                              if (state.cites[index] == 'Избранное') {
                                cityOffices = state.offices
                                    .where((Office element) =>
                                        element.isFavorite ?? false)
                                    .toList();
                              } else {
                                cityOffices = state.offices
                                    .where((Office element) =>
                                        element.cityName == state.cites[index])
                                    .toList();
                              }
                              return OfficeExpandable(
                                offices: cityOffices,
                                city: state.cites[index],
                                holdersId: holdersId,
                              );
                            }),
                      ),
                    )
                  ],
                ),
              );
            }
            return const Center(
              child: Text('Ошибка'),
            );
          },
        ));
  }
}
