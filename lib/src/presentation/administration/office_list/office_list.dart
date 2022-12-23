import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/booking_create_1/booking_create1_bloc.dart';
import '../../../domain/entities/office.dart';
import '../../booking/create_booking_1/widgets/office_expandable.dart';

class OfficeList extends StatefulWidget {
  const OfficeList({Key? key}) : super(key: key);

  @override
  State<OfficeList> createState() => _OfficeListState();
}

class _OfficeListState extends State<OfficeList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingCreate1Bloc>(
      create: (BuildContext context) => BookingCreate1Bloc(),
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
          'Новый офис',
        )),
        body: BlocBuilder<BookingCreate1Bloc, BookingCreate1State>(
          builder: (BuildContext context, BookingCreate1State state) {
            if (state is BookingCreate1Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is BookingCreate1Loaded) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20.w),
                child: Column(
                  children: [
                    const Text('Выбирете офис'),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.cites.length,
                        itemBuilder: (BuildContext context, int index) {
                          late List<Office> cityOffices;
                          if (state.cites[index] == 'Избранное') {
                            cityOffices = state.offices
                                .where((Office element) =>
                                    element.isFavorite == true)
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
                          );
                        }),
                  ],
                ),
              );
            }
            return const Center(
              child: Text('Что-то пошло не так'),
            );
          },
        ),
      ),
    );
  }
}
