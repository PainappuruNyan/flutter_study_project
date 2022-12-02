import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/colors.dart';

class CreateOffice1 extends StatefulWidget {
  const CreateOffice1({super.key});

  static const String routeName = '/create_office/1';

  @override
  State<CreateOffice1> createState() => _CreateOffice1();
}

class _CreateOffice1 extends State<CreateOffice1> {
  TextEditingController startdateinput = TextEditingController();
  TextEditingController enddateinput = TextEditingController();

  bool periodLimit = false;
  bool bookingCountLimit = false;

  //text editing controller for text field

  @override
  void initState() {
    startdateinput.text = '';
    enddateinput.text = '';
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

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Формирование офиса',
          )),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 36.sp),
          child: const Text(
            'Введите данные офиса',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto'),
          ),
        ),
        Container(
            padding: EdgeInsets.only(left: 36.5.sp, right: 36.5.sp, top: 35.sp),
            child: Center(
                child: TextField(
              style: Theme.of(context).textTheme.bodyText2,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.pin_drop,
                  color: MyColors.kPrimary,
                ),
                labelText: 'Выберите город офиса',
              ),
            ))),
        Container(
            padding: EdgeInsets.only(left: 36.5.sp, right: 36.5.sp),
            child: Center(
                child: TextField(
              style: Theme.of(context).textTheme.bodyText2,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.house,
                  color: MyColors.kPrimary,
                ),
                labelText: 'Выберите адрес офиса',
              ),
            ))),
        Container(
            padding: EdgeInsets.only(left: 36.5.sp, right: 36.5.sp),
            child: Center(
                child: TextField(
              readOnly: true,
              style: Theme.of(context).textTheme.bodyText2,
              controller: startdateinput,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.calendar_month,
                  color: MyColors.kPrimary,
                ),
                labelText: 'Начало бронирований',
              ),
              onTap: () => datePicker(startdateinput),
            ))),
        Container(
            padding: EdgeInsets.only(left: 36.5.sp, right: 36.5.sp),
            child: Center(
                child: TextField(
              readOnly: true,
              style: Theme.of(context).textTheme.bodyText2,
              controller: enddateinput,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.calendar_month,
                  color: MyColors.kPrimary,
                ),
                labelText: 'Конец бронирований',
              ),
              onTap: () => datePicker(enddateinput),
            ))),
            Container(
                padding: EdgeInsets.only(left: 36.5.sp, right: 36.5.sp, top: 45.sp),
                child: Center(
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.house,
                          color: MyColors.kPrimary,
                        ),
                        labelText: 'Диапазон брони',
                      ),
                    ))),
      ])),
      // bottomNavigationBar: const CustomBottomAppBar(pageNum: '1', pageCount: '3',nextRoute: Routes.profile,)
    );
  }
}
