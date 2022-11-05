import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

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
      margin: const EdgeInsets.only(left: 14.5, right: 14.5, top: 16),
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
                        padding: const EdgeInsets.only(top: 7, left: 15),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'id $bookingId',
                          style: Theme.of(context).textTheme.caption
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding:
                            const EdgeInsets.only(top: 7, bottom: 11, left: 15),
                        child: Text(
                          'Офис: $address',
                          style: Theme.of(context).textTheme.bodyText2
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(bottom: 11, left: 15),
                        child: Text.rich(TextSpan(
                            text: 'Место: $placeType ',
                            style: Theme.of(context).textTheme.bodyText2,
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'id $placeId',
                                  style: const TextStyle(
                                      color: Colors.deepOrange))
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                    '01.02.2022 (пн) - 02.02.2022 (вт)\n21:00 - 05:00',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodyText1))),
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
