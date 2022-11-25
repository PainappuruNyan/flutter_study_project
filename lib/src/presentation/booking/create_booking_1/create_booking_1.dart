import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/booking_create_1/booking_create1_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../../domain/entities/office.dart';
import '../../routes/routes.dart';
import '../../shared_widgets/bottom_app_bar.dart';
import 'widgets/office_expandable.dart';

class CreateBooking1 extends StatefulWidget {
  const CreateBooking1({super.key});

  static const String routeName = '/create_booking/1';

  @override
  State<CreateBooking1> createState() => _CreateBooking1State();
}

class _CreateBooking1State extends State<CreateBooking1> {
  // List<Office> list = <Office>[
  //   const Office(
  //       id: 1,
  //       city: 'Владивосток',
  //       address: 'Океанская 12д',
  //       administrator: 'Мамаев Мамай',
  //       contactNumber: '+79099099090'),
  //   const Office(
  //       id: 2,
  //       city: 'Благовещенск',
  //       address: 'Дудуево 12д',
  //       administrator: 'Мамаев Мамай',
  //       contactNumber: '+79099099090'),
  //   const Office(id: 3, city: 'Владивосток', address: 'Светланская 59', administrator: 'Самый лучший чел', contactNumber: '+70000000000'),
  //   const Office(
  //       id: 4,
  //       city: 'Москва',
  //       address: 'Красного Знамени 12д',
  //       administrator: 'Иван Иванович',
  //       contactNumber: '+79099099090'),
  // ];
  //
  // List<String> citys = <String>['Избранное', 'Владивосток', 'Благовещенск', 'Москва'];
  // List<Office> favorites = <Office>[
  //   const Office(
  //     id: 1,
  //     city: 'Владивосток',
  //     address: 'Океанская 12д',
  //     administrator: 'Мамаев Мамай',
  //     contactNumber: '+79099099090'),
  //   const Office(
  //       id: 2,
  //       city: 'Благовещенск',
  //       address: 'Дудуево 12д',
  //       administrator: 'Мамаев Мамай',
  //       contactNumber: '+79099099090'),
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingCreate1Bloc>(
      create: (BuildContext context) =>
          BookingCreate1Bloc()..add(BookingCreate1Start()),
      child: const CreateBooking1View(),
    );
  }
}

class CreateBooking1View extends StatelessWidget {
  const CreateBooking1View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Новая бронь'),
        ),
        bottomNavigationBar: const CustomBottomAppBar(
          pageNum: '1',
          pageCount: '3',
          nextRoute: Routes.booking_create_2,
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        height: 40.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                        child: TextField(
                          style: const TextStyle(
                              fontSize: 14, color: MyColors.kPrimaryText),
                          cursorColor: MyColors.kPrimaryText,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 32.w),
                              suffixIcon: const Icon(
                                Icons.search_rounded,
                                color: Colors.black,
                              ),
                              hintText: 'Поиск',
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 230, 230, 231),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 230, 230, 231))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 230, 230, 231)))),
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
                                  // cityOffices = favorites;
                                } else {
                                  cityOffices =state.offices
                                      .where((Office element) =>
                                          element.cityName == state.cites[index])
                                      .toList();
                                }
                                return OfficeExpandable(
                                  offices: cityOffices,
                                  city: state.cites[index],
                                );
                              }),
                        ),
                      )
                    ],
                  ),
              );
            }
            return Center(
              child: Text('Ошибка'),
            );
          },
        ));
  }
}
