import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/colors.dart';

class BookingCard extends StatelessWidget {
  const BookingCard(this.address, this.placeType, this.bookingId, this.placeId,
      {super.key});

  final String address;
  final String placeType;
  final int bookingId;
  final int placeId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 14.5, right: 14.5),
      child: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: MyColors.kPrimary)),
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 7, left: 15),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'id $bookingId',
                          style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Roboto',
                              fontSize: 12),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding:
                            const EdgeInsets.only(top: 7, bottom: 11, left: 15),
                        child: Text(
                          'Офис: $address',
                          style: const TextStyle(
                              fontFamily: 'Roboto', fontSize: 12),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(bottom: 11, left: 15),
                        child: Text.rich(TextSpan(
                            text: 'Место: $placeType ',
                            style: const TextStyle(
                                fontFamily: 'Roboto', fontSize: 12),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'id $placeId',
                                  style: const TextStyle(
                                      color: Colors.deepOrange,
                                      fontFamily: 'Roboto'))
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
                      color: Colors.deepOrange,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        const Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                    '01.02.2022 (пн) - 02.02.2022 (вт)\n21:00 - 05:00',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontFamily: 'Roboto')))),
                        Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.menu_open_sharp,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
