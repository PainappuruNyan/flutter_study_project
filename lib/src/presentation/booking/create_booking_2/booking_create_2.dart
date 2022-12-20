import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../bloc/booking_create_2/booking_create2_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../shared_widgets/bottom_app_bar.dart';
import '../create_booking_3/booking_create_3.dart';

class BookingCreate2Screen extends StatefulWidget {
  const BookingCreate2Screen({super.key, required this.selectedOffice});

  final int selectedOffice;

  static const String routeName = '/booking_create/2';

  @override
  State<StatefulWidget> createState() {
    return _BookingCreate2Screen(this.selectedOffice);
  }
}

class _BookingCreate2Screen extends State<BookingCreate2Screen> {
  _BookingCreate2Screen(this.selectedOffice);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int selectedOffice;
  TextEditingController dateinput = TextEditingController();
  TextEditingController begintimeinput = TextEditingController();
  TextEditingController endtimeinput = TextEditingController();

  //text editing controller for text field

  @override
  void initState() {
    dateinput.text = '';
    begintimeinput.text = '';
    endtimeinput.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void nextRoute() {
      Navigator.of(context).push(MaterialPageRoute<BookingCreate3Screen>(
          builder: (_) => BookingCreate3Screen(
        selectedOffice: selectedOffice,
        dateStart: dateinput.text,
        timeStart: begintimeinput.text,
        timeEnd: endtimeinput.text,
      )));
    }

    Future<void> datePicker(TextEditingController dateinput) async {
      assert(dateinput != null);
      final DateTime now = DateTime.now();

      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(now.year, now.month, now.day),
          lastDate: DateTime(now.year + 10));
      if (pickedDate != null) {
        final String formattedDate =
            DateFormat('yyyy-MM-dd').format(pickedDate);
        setState(() {
          dateinput.text = formattedDate;
        });
      }
    }

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
        setState(() {
          timeinput.text = formattedTime;
        });
      }
    }

    return BlocProvider<BookingCreate2Bloc>(
      create: (BuildContext context) => BookingCreate2Bloc()..add(BookingCreate2Start(selectedOffice: selectedOffice)),
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
          'Формирование брони',
        )),
        body: BlocBuilder<BookingCreate2Bloc, BookingCreate2State>(
  builder: (BuildContext context, BookingCreate2State state) {
    if (state is BookingCreate2Loading) {
      return const Center(child: CircularProgressIndicator(),);
    }
    if (state is BookingCreate2Loaded) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 12.sp),
                        child: Text(
                          'Выберите дату',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              left: 36.5.sp, right: 36.5.sp, top: 35.sp),
                          child: Center(
                              child: TextFormField(
                                  style: Theme.of(context).textTheme.bodyText2,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Выберите дату брони';
                                    }
                                    return null;
                                  },
                                  controller: dateinput,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.calendar_month,
                                      color: MyColors.kPrimary,
                                    ),
                                    labelText: 'Дата начала брони',
                                  ),
                                  readOnly: true,
                                  onTap: () => datePicker(dateinput)))),
                      Container(
                        padding: EdgeInsets.only(top: 70.sp),
                        child: Text(
                          'Выберите время',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 36.5.sp, right: 36.5.sp, top: 35.sp),
                        child: TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Выберите время начала брони';
                            }
                            return null;
                          },
                          controller: begintimeinput,
                          readOnly: true,
                          style: Theme.of(context).textTheme.bodyText2,
                          decoration: const InputDecoration(
                              labelText: 'Время начала брони',
                              prefixIcon: Icon(
                                Icons.watch_later_outlined,
                                color: Colors.deepOrange,
                              )),
                          onTap: () => timePicker(begintimeinput),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 36.5.sp, right: 36.5.sp, top: 35.sp),
                        child: TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Выберите время конца брони';
                            }
                            return null;
                          },
                          controller: endtimeinput,
                          readOnly: true,
                          style: Theme.of(context).textTheme.bodyText2,
                          decoration: const InputDecoration(
                              labelText: 'Время конца брони',
                              prefixIcon: Icon(
                                Icons.watch_later_outlined,
                                color: MyColors.kPrimary,
                              )),
                          onTap: () => timePicker(endtimeinput),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
    return Text('Error');
          },
),
        bottomNavigationBar: CustomBottomAppBar(
          pageCount: '3',
          pageNum: '2',
          dateValid: _formKey.currentState?.validate(),
          nextRoute: nextRoute,
          nextPageButton: true,
        ),
      ),
    );
  }
}
