import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/booking_create_3/booking_create3_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../shared_widgets/bottom_app_bar.dart';
import '../../shared_widgets/workplace_card.dart';
import '../booking_list/booking_list_screen.dart';

class BookingCreate3Screen extends StatefulWidget {
  const BookingCreate3Screen({
    super.key,
    required this.selectedOffice,
    required this.dateStart,
    required this.timeStart,
    required this.timeEnd,
  });

  final int? selectedOffice;
  final String? dateStart;
  final String? timeStart;
  final String? timeEnd;

  static const String routeName = '/booking_create/3';

  @override
  State<BookingCreate3Screen> createState() =>
      _BookingCreate3ScreenState(selectedOffice, dateStart, timeStart, timeEnd);
}

class _BookingCreate3ScreenState extends State<BookingCreate3Screen> {
  // final List<bool> _isFavorited = List<bool>.filled(favoriteList.length, false);
  _BookingCreate3ScreenState(
      this.selectedOffice, this.dateStart, this.timeStart, this.timeEnd);

  final int? selectedOffice;
  final String? dateStart;
  final String? timeStart;
  final String? timeEnd;

  int? selectedFloor = 1;
  bool listChecked = true;
  bool mapChecked = false;
  String searchString = '';

  @override
  Widget build(BuildContext context) {
    final DateTime dateTimeStart = DateTime.parse('$dateStart $timeStart');
    final DateTime dateTimeEnd = DateTime.parse('$dateStart $timeEnd');
    return BlocProvider<BookingCreate3Bloc>(
      create: (BuildContext context) =>
          BookingCreate3Bloc()..add(BookingCreate3Start()),
      child: Scaffold(
        backgroundColor: MyColors.kWhite,
        appBar: AppBar(
            title: const Text(
          'Формирование брони',
        )),
        body: BlocConsumer<BookingCreate3Bloc, BookingCreate3State>(
          builder: (BuildContext context, BookingCreate3State state) {
            if (state is BookingCreate3FloorLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is BookingCreate3FloorLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 30.sp, bottom: 20.sp),
                      child: Row(
                        children: <Widget>[
                          //Выбор этажа
                          Container(
                            padding: EdgeInsets.only(left: 30.sp),
                            child: CustomDropDown(
                              value: '$selectedFloor Этаж',
                              itemsList: state.floors,
                              onChanged: (dynamic value) {
                                setState(() {
                                  selectedFloor = value as int;
                                });
                              },
                            ),
                          ),
                          //Карта и Спислк
                          Container(
                            padding: EdgeInsets.only(left: 20.sp),
                            child: TextButton(
                                onPressed: () {
                                  context
                                      .read<BookingCreate3Bloc>()
                                      .add(BookingCreate3ChangeToMap());
                                },
                                child: const Text('Карта',
                                    style: TextStyle(
                                        color: MyColors.kTextSecondary,
                                        fontSize: 18))),
                          ),
                          SizedBox(
                            height: 20.h,
                            child: const VerticalDivider(
                              color: MyColors.kPrimaryText,
                              thickness: 2,
                              width: 15,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                context
                                    .read<BookingCreate3Bloc>()
                                    .add(BookingCreate3ChangeToList());
                              },
                              child: const Text('Список',
                                  style: TextStyle(
                                      color: MyColors.kSecondary,
                                      fontSize: 18))),
                        ],
                      ),
                    ),

                    //Строка поиска
                    Container(
                      padding: EdgeInsets.only(
                          left: 32.sp, right: 10, bottom: 5.sp, top: 5.sp),
                      width: 320.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey.shade300,
                      ),
                      child: TextField(
                        style: Theme.of(context).textTheme.bodyText2,
                        onChanged: (String value) {
                          setState(() {
                            searchString = value.toLowerCase();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Поиск',
                          hintStyle: Theme.of(context).textTheme.caption,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    //expansions
                    Container(
                        padding: EdgeInsets.only(
                            left: 30.sp, top: 15.sp, right: 30.sp),
                        alignment: Alignment.topLeft,
                        child: ExpansionTile(
                          title: Text(
                            'Избранное',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          children: <Widget>[
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.favorites.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return WorkplaceCard(
                                      workplace: state.favorites[index],
                                      onApprove:
                                          context.read<BookingCreate3Bloc>(),
                                      dateTimeStart: dateTimeStart,
                                      dateTimeEnd: dateTimeEnd);
                                }),
                          ],
                        )),
                    Container(
                        padding: EdgeInsets.only(
                            left: 30.sp, top: 15.sp, right: 30.sp),
                        alignment: Alignment.topLeft,
                        child: ExpansionTile(
                          title: Text(
                            'Рабочие места',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          children: <Widget>[
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.usualWorkplaces.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return WorkplaceCard(
                                      workplace: state.usualWorkplaces[index],
                                      onApprove:
                                          context.read<BookingCreate3Bloc>(),
                                      dateTimeStart: dateTimeStart,
                                      dateTimeEnd: dateTimeEnd);
                                }),
                          ],
                        )),
                    Container(
                        padding: EdgeInsets.only(
                            left: 30.sp, top: 15.sp, right: 30.sp),
                        alignment: Alignment.topLeft,
                        child: ExpansionTile(
                          title: Text(
                            'Переговорки',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          children: <Widget>[
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.meetengRoom.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return WorkplaceCard(
                                      workplace: state.meetengRoom[index],
                                      onApprove:
                                          context.read<BookingCreate3Bloc>(),
                                      dateTimeStart: dateTimeStart,
                                      dateTimeEnd: dateTimeEnd);
                                }),
                          ],
                        )),
                  ],
                ),
              );
            }
            if (state is BookingCreate3FloorMapLoaded) {
              return SingleChildScrollView(
                  child: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 30.sp, bottom: 20.sp),
                  child: Row(
                    children: <Widget>[
                      //Выбор этажа
                      Container(
                        padding: EdgeInsets.only(left: 30.sp),
                        child: CustomDropDown(
                          value: '$selectedFloor Этаж',
                          itemsList: state.floors,
                          onChanged: (dynamic value) {
                            setState(() {
                              selectedFloor = value as int;
                            });
                          },
                        ),
                      ),
                      //Карта и Спислк
                      Container(
                          padding: EdgeInsets.only(left: 20.sp),
                          child: TextButton(
                              onPressed: () {
                                context
                                    .read<BookingCreate3Bloc>()
                                    .add(BookingCreate3ChangeToMap());
                              },
                              child: const Text('Карта',
                                  style: TextStyle(
                                      color: MyColors.kSecondary,
                                      fontSize: 18)))),
                      SizedBox(
                        height: 20.h,
                        child: const VerticalDivider(
                          color: MyColors.kPrimaryText,
                          thickness: 2,
                          width: 15,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            context
                                .read<BookingCreate3Bloc>()
                                .add(BookingCreate3ChangeToList());
                          },
                          child: const Text('Список',
                              style: TextStyle(
                                  color: MyColors.kTextSecondary,
                                  fontSize: 18))),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 200.h),
                  child: Text(
                    'На стадии разработки',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 30),
                  ),
                )
              ]));
            }
            return const Text('error');
          },
          listener: (BuildContext context, BookingCreate3State state) {
            if (state is BookingSuccess) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const BookingListScreen(),
                  ));
            }
          },
        ),
        bottomNavigationBar: const CustomBottomAppBar(
          pageCount: '3',
          pageNum: '3',
          nextRoute: BookingListScreen(),
          nextPageButton: true,
        ),
      ),
    );
  }
}

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    required this.value,
    required this.itemsList,
    required this.onChanged,
    super.key,
  });

  final dynamic value;
  final List<int> itemsList;
  final Function(dynamic value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      height: 35.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: MyColors.kSecondary, width: 1.5.w),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 5),
          child: DropdownButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: MyColors.kSecondary,
            ),
            isExpanded: true,
            value: value,
            items: itemsList
                .map((int item) => DropdownMenuItem<String>(
                      value: '$item Этаж',
                      child: Text(
                        '$item Этаж',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ))
                .toList(),
            onChanged: (Object? value) => onChanged(value),
          ),
        ),
      ),
    );
  }
}
