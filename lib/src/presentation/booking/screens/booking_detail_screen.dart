import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/colors.dart';

class BookingDetailScreen extends StatelessWidget {
  const BookingDetailScreen({super.key});

  static const String routeName = '/booking_details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Детали брони',
      )),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 40.sp, right: 40.sp),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 40.sp, bottom: 45.sp),
                child: Text(
                  'Бронь 00000001',
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
                                  text: 'id00000001',
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
                                  text: 'Окатовая 12',
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
                                  text: 'Владивосток',
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
                                  text: 'Переговорка',
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
                                  text: 'id0000001',
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
                                  '01.01.2022(пн)',
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
                                  '01.01.2022(пн)',
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
                                  '11:00',
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
                                  '17:00',
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
                  onPressed: () {},
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
        onPressed: () {},
        child: const Icon(
          Icons.edit,
        ),
      ),
    );
  }
}
