import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../bloc/booking_list/booking_list_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../../domain/entities/booking.dart';
import '../booking_list/booking_list_screen.dart';
import '../create_booking_2/booking_create_2.dart';

class BookingDetailScreen extends StatelessWidget {
  const BookingDetailScreen({super.key, required this.e});
  final Booking e;

  static const String routeName = '/booking_details';

  @override
  Widget build(BuildContext context) {
    final DateTime dateStart = DateTime.parse(e.start.toString());
    final DateTime dateEnd = DateTime.parse(e.end.toString());
    final DateTime timeStart = DateTime.parse(e.start.toString());
    final DateTime timeEnd = DateTime.parse(e.end.toString());

    final DateFormat date = DateFormat('yyyy-MM-dd');
    final DateFormat time = DateFormat('HH:mm');
    final String startDate = date.format(dateStart);
    final String endDate = date.format(dateEnd);
    final String startTime = time.format(timeStart);
    final String endTime = time.format(timeEnd);
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Детали брони',
      )),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 25.sp, right: 25.sp),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 40.sp, bottom: 45.sp),
                child: Text(
                  'Бронь ${e.id}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 30.sp, left: 10.sp),
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                  color: Colors.deepOrange,
                  width: 1.2.w,
                ))),
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 300.w,
                        padding: EdgeInsets.only(left: 10.sp),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.grey.shade300,
                        ))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text.rich(
                              TextSpan(
                                  style: Theme.of(context).textTheme.headline6,
                                  text: 'Этаж: ',
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '2',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ]),
                            ),
                            Text('id0000001',
                                style: Theme.of(context).textTheme.caption)
                          ],
                        )),
                    Container(
                        width: 300.w,
                        padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.grey.shade400,
                          width: 0.5,
                        ))),
                        child: Text.rich(
                          TextSpan(
                              style: Theme.of(context).textTheme.headline6,
                              text: 'Место: ',
                              children: <TextSpan>[
                                TextSpan(
                                  text: e.placeId.toString(),
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                              ]),
                        )),
                    Container(
                        width: 300.w,
                        padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.grey.shade400,
                          width: 0.5.w,
                        ))),
                        child: Text.rich(
                          TextSpan(
                              style: Theme.of(context).textTheme.headline6,
                              text: 'Офис: ',
                              children: <TextSpan>[
                                TextSpan(
                                  text: e.address,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ]),
                        )),
                    Container(
                        width: 300.w,
                        padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.grey.shade400,
                          width: 0.5,
                        ))),
                        child: Text.rich(
                          TextSpan(
                              style: Theme.of(context).textTheme.headline6,
                              text: 'Город: ',
                              children: <TextSpan>[
                                TextSpan(
                                  text: e.city,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ]),
                        )),
                    Container(
                        width: 300.w,
                        padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.grey.shade400,
                          width: 0.5,
                        ))),
                        child: Text.rich(
                          TextSpan(
                              style: Theme.of(context).textTheme.headline6,
                              text: 'Тип: ',
                              children: <TextSpan>[
                                TextSpan(
                                  text: e.type.toString(),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ]),
                        )),
                    Container(
                        width: 300.w,
                        padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.grey.shade400,
                          width: 0.5,
                        ))),
                        child: Text.rich(
                          TextSpan(
                              style: Theme.of(context).textTheme.headline6,
                              text: 'Забронировал: ',
                              children: <TextSpan>[
                                TextSpan(
                                  text: e.makerName.toString(),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ]),
                        )),
                    Container(
                      width: 300.w,
                      padding: EdgeInsets.only(top: 10.sp),
                      //
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Colors.grey.shade400,
                        width: 0.5.w,
                      ))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 101.w,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Дата начала:',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  startDate,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 140.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  'Дата окончания:',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  endDate,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 300.w,
                      padding: EdgeInsets.only(top: 10.sp),
                      //
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Colors.grey.shade400,
                        width: 0.5.w,
                      ))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 103.w,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Время начала:',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  startTime,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 142.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  'Время окончания:',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  endTime,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 54.sp),
                width: 286.w,
                child: MaterialButton(
                  onPressed: () async {
                    context.read<BookingListBloc>().add(BookingDelete(id: e.id));
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (_) =>
                            BookingListScreen(isOfficeBooking: false,)), (Route route) => route.isFirst);
                  },
                  color: MyColors.kPrimary,
                  child: const Text('Удалить бронь',
                      style: TextStyle(fontSize: 16.0, color: Colors.white)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.sp),
                width: 286.w,
                child: MaterialButton(
                  onPressed: () {},
                  child: const Text('Скопировать адрес',
                      style:
                          TextStyle(fontSize: 16.0, color: MyColors.kPrimary)),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          final List<int> holdersId = <int>[];
          holdersId.add(e.holder);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      BookingCreate2Screen(
                        selectedOffice: e.officeId!,
                        holdersId: holdersId,
                        isEdit: true,
                        editedBookingId: e.id,
                        bookingRange: 360,
                      )));
        },
        child: const Icon(
          Icons.edit,
        ),
      ),
    );
  }
}
