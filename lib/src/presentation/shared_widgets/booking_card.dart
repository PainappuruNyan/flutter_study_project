import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';
import '../booking/booking_details/booking_detail_screen.dart';

class BookingCard extends StatelessWidget {
  const BookingCard(this.address, this.placeType, this.bookingId, this.placeId,
      {super.key});

  final String address;
  final String placeType;
  final int bookingId;
  final int placeId;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 14.5.sp, right: 14.5.sp, top: 16.sp),
      child: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: MyColors.kPrimary)),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 7.sp, right: 15.sp),
                        alignment: Alignment.topRight,
                        child: Text('id $bookingId',
                            style: Theme.of(context).textTheme.caption),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                            top: 7.sp, bottom: 10.sp, left: 15.sp),
                        child: Text('Офис: $address',
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 10.sp, left: 15.sp),
                        child: Text.rich(TextSpan(
                            text: 'Место: $placeType ',
                            style: Theme.of(context).textTheme.bodyText2,
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'id $placeId',
                                  style:
                                      const TextStyle(color: Colors.deepOrange))
                            ])),
                      ),
                    ],
                  ),
                  Container(
                    height: 44,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4)),
                      color: MyColors.kSecondary,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => BookingDetailScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.only(left: 10.sp),
                                  child: Text(
                                      '01.02.2022 (пн) - 02.02.2022 (вт)\n21:00 - 05:00',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1))),
                          const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
