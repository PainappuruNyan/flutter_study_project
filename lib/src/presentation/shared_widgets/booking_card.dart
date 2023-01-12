import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../../core/constants/colors.dart';
import '../../domain/entities/booking.dart';
import '../booking/booking_details/booking_detail_screen.dart';
import '../booking/create_booking_2/booking_create_2.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final DateTime dateStart = DateTime.parse(booking.start.toString());
    final DateTime dateEnd = DateTime.parse(booking.end.toString());
    final DateTime timeStart = DateTime.parse(booking.start.toString());
    final DateTime timeEnd = DateTime.parse(booking.end.toString());

    final DateFormat date = DateFormat('yyyy.MM.dd');
    final DateFormat time = DateFormat('HH:mm');
    final String startDate = date.format(dateStart);
    final String endDate = date.format(dateEnd);
    final String startTime = time.format(timeStart);
    final String endTime = time.format(timeEnd);
    return Card(
      margin: EdgeInsets.only(left: 14.5.sp, right: 14.5.sp, top: 16.sp),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 7.sp, right: 15.sp),
            alignment: Alignment.topRight,
            child: Text('id ${booking.id}',
                style: Theme.of(context).textTheme.caption),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 7.sp, bottom: 10.sp, left: 15.sp),
            child: Text('Офис: ${booking.address}',
                style: Theme.of(context).textTheme.bodyText2),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(bottom: 10.sp, left: 15.sp),
            child: Text.rich(TextSpan(
                text: 'Место: ${booking.placeId} ',
                style: Theme.of(context).textTheme.bodyText2,
                children: <TextSpan>[
                  TextSpan(
                      text: 'id ${booking.placeId}',
                      style: const TextStyle(color: Colors.deepOrange))
                ])),
          ),
          Container(
            height: 44,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16)),
              color: MyColors.kSecondary,
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute<dynamic>(
                        builder: (_) => BookingDetailScreen(e: booking)))
                    .then((_) {
                  context.read<ProfileBloc>().add(ProfileStarted());
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(left: 20.sp),
                          child: Text(
                              '$startDate - $endDate\n$startTime - $endTime',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1))),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    color: Colors.white,
                    onPressed: () {
                      final List<int> holdersId = <int>[];
                      holdersId.add(booking.holder);
                      Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) =>
                                  BookingCreate2Screen(
                                    selectedOffice: booking.officeId!,
                                    holdersId: holdersId,
                                    isEdit: true,
                                    editedBookingId: booking.id,
                                    bookingRange: 360,
                                  )));
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
