import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/colors.dart';
import '../../routes/routes.dart';
import '../../shared_widgets/bottom_app_bar.dart';

class BookingCreate2Screen extends StatefulWidget {
  const BookingCreate2Screen({super.key});

  static const String routeName = '/booking_create/2';

  @override
  State<StatefulWidget> createState() {
    return _BookingCreate2Screen();
  }
}

class _BookingCreate2Screen extends State<BookingCreate2Screen> {
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
              data: MediaQuery.of(context).copyWith(
                  alwaysUse24HourFormat: true),
              child: child ?? Container(),
            );
          }
      );

      if (pickedTime != null) {
        final DateTime parsedTime =
            DateFormat.jm().parse(pickedTime.format(context).toString());
        final String formattedTime = DateFormat('HH:mm').format(parsedTime);
        setState(() {
          timeinput.text = formattedTime;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Формирование брони',
      )),
      body: SingleChildScrollView(
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
                padding:
                    EdgeInsets.only(left: 36.5.sp, right: 36.5.sp, top: 35.sp),
                child: Center(
                    child: TextField(
                        style: Theme.of(context).textTheme.bodyText2,
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
              padding:
                  EdgeInsets.only(left: 36.5.sp, right: 36.5.sp, top: 35.sp),
              child: TextFormField(
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
              padding:
                  EdgeInsets.only(left: 36.5.sp, right: 36.5.sp, top: 35.sp),
              child: TextFormField(
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
      bottomNavigationBar: const CustomBottomAppBar(
        pageCount: '3',
        pageNum: '2',
        nextRoute: Routes.booking_create_3,
      ),
    );
  }
}
