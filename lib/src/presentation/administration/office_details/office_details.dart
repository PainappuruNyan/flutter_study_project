import 'package:atb_first_project/dependency_injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../bloc/office_details/office_details_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/new_admin_model.dart';
import '../../../data/models/office_model.dart';
import '../../../domain/entities/office.dart';
import '../../booking/booking_list/booking_list_screen.dart';
import '../create_office_3/create_office_3.dart';
import '../office_list/office_list.dart';
import '../user_list/user_list.dart';

class OfficeDetailsScreen extends StatelessWidget {
  OfficeDetailsScreen({super.key, required this.office});

  final Office office;

  static const String routeName = '/office_details_screen';

  TextEditingController startdateinput = TextEditingController();

  TextEditingController enddateinput = TextEditingController();

  TextEditingController bookingRangeInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> timePicker(TextEditingController timeinput) async {
      final TimeOfDay? pickedTime = await showTimePicker(
          initialTime: TimeOfDay.now(),
          context: context,
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child ?? Container(),
            );
          });

      if (pickedTime != null) {
        final DateTime parsedTime =
            DateFormat.jm().parse(pickedTime.format(context).toString());
        final String formattedTime = DateFormat('HH:mm').format(parsedTime);
        timeinput.text = formattedTime;
      }
    }

    return BlocProvider<OfficeDetailsBloc>(
      create: (BuildContext context) => OfficeDetailsBloc(di.sl()),
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
          'Детали офиса',
        )),
        body: BlocBuilder<OfficeDetailsBloc, OfficeDetailsState>(
          builder: (BuildContext context, OfficeDetailsState state) {
            onTapFunc(int employeeId) {
              context.read<OfficeDetailsBloc>().add(PostAdmin(
                  NewAdminModel(officeId: office.id!, employeeId: employeeId)));
            }

            if (state is OfficeDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Center(
                  child: Column(children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 30, bottom: 40),
                  child: Text(
                    '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 30.sp, left: 10.sp),
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(
                    color: Colors.deepOrange,
                    width: 1.2,
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
                          child: Text.rich(
                            TextSpan(
                                style: Theme.of(context).textTheme.headline6,
                                text: 'Город: ',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: office.cityName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
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
                                      text: office.address,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
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
                                text: 'Начало рабочего дня: ',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: DateFormat('HH:mm')
                                          .format(office.startOfDay),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
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
                                text: 'Конец рабочего дня: ',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: DateFormat('HH:mm')
                                          .format(office.endOfDay),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
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
                                text: 'Диапазон брони: ',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: office.bookingRange.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                ]),
                          )),
                      SizedBox(
                        height: 14.h,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 54.sp),
                  width: 286.w,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BookingListScreen(
                                    isOfficeBooking: true,
                                    officeId: office.id,
                                  )),
                          (Route route) => route.isFirst);
                    },
                    color: MyColors.kPrimary,
                    child: const Text('Список бронирований',
                        style: TextStyle(fontSize: 16.0, color: Colors.white)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.sp),
                  width: 286.w,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute<OfficeListScreen>(
                              builder: (BuildContext context) =>
                                  CreateOffice3(officeId: office.id!)));
                    },
                    child: const Text('Список этажей',
                        style: TextStyle(
                            fontSize: 16.0, color: MyColors.kPrimary)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.sp),
                  width: 286.w,
                  child: MaterialButton(
                    onPressed: () {
                      final OfficeDetailsBloc bloc =
                          context.read<OfficeDetailsBloc>();
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16))),
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40.sp, vertical: 15.sp),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TextFormField(
                                    readOnly: true,
                                    controller: startdateinput,
                                    decoration: const InputDecoration(
                                      labelText: 'Начало бронирований',
                                      icon: Icon(Icons.calendar_month),
                                    ),
                                    onTap: () {
                                      timePicker(startdateinput);
                                    },
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.sp),
                                    child: TextFormField(
                                      readOnly: true,
                                      controller: enddateinput,
                                      decoration: const InputDecoration(
                                        labelText: 'Конец бронирований',
                                        icon: Icon(Icons.calendar_month),
                                      ),
                                      onTap: () {
                                        timePicker(enddateinput);
                                      },
                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: bookingRangeInput,
                                    decoration: const InputDecoration(
                                      labelText: 'Диапазон брони',
                                      icon: Icon(Icons.house),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.sp),
                                    child: MaterialButton(
                                      onPressed: () {
                                        bloc.add(OfficeEdit(OfficeModel(
                                            id: office.id,
                                            cityId: 1,
                                            cityName: office.cityName,
                                            address: office.address,
                                            workNumber: office.workNumber,
                                            startOfDay: DateFormat('HH:mm')
                                                .parse(startdateinput.text),
                                            endOfDay: DateFormat('HH:mm')
                                                .parse(enddateinput.text),
                                            bookingRange: int.parse(
                                                bookingRangeInput.text),
                                            isFavorite: null)));
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    const OfficeListScreen()),
                                            (Route route) => route.isFirst);
                                      },
                                      child:
                                          const Text('Подтвердить изменения'),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: const Text('Редактировать ограничения',
                        style: TextStyle(
                            fontSize: 16.0, color: MyColors.kPrimary)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.sp),
                  width: 286.w,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => UserList(
                                    officeId: office.id,
                                    onTapFunc: onTapFunc,
                                  )));
                    },
                    child: const Text('Назначить администратора',
                        style: TextStyle(
                            fontSize: 16.0, color: MyColors.kPrimary)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.sp),
                  width: 286.w,
                  child: MaterialButton(
                    onPressed: () {
                      context
                          .read<OfficeDetailsBloc>()
                          .add(OfficeDelete(id: office.id!));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<OfficeListScreen>(
                              builder: (BuildContext context) =>
                                  const OfficeListScreen()));
                    },
                    child: const Text('Удалить офис',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: MyColors.kPrimary,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ])),
            );
          },
        ),
      ),
    );
  }
}
