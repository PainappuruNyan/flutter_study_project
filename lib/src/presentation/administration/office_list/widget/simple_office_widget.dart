import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../domain/entities/office.dart';

class SimpleOffice extends StatelessWidget {
  const SimpleOffice({super.key, required this.office});

  final Office office;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 17.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              office.cityName,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
            Text(
              office.address,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
            Container(
              padding: EdgeInsets.only(top: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Скопировать адрес',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: MyColors.kPrimary,
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Рабочий телефон',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        Text('${office.workNumber}',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w400))
                      ],
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.copy,
                        color: MyColors.kPrimary,
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
