import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/colors.dart';

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
    Future<void> datePicker(dynamic dateinput) async {
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

    Future<void> timePicker(dynamic timeinput) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
      );

      if (pickedTime != null) {
        final DateTime parsedTime = DateFormat.jm()
            .parse(pickedTime.format(context).toString());
        final String formattedTime =
        DateFormat('HH:mm').format(parsedTime);
        setState(() {
          timeinput.text =
              formattedTime;
        });
      }
    }

    return Scaffold(
        appBar: AppBar(
            leading: const Icon(Icons.arrow_back_ios_new),
            title: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: 55),
              child: Text(
                'Формирование брони',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 12),
                child: const Text(
                  'Выберите дату',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto'),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 36.5, right: 36.5, top: 35),
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
                    onTap: () => datePicker(dateinput)
                  ))),
              Container(
                padding: const EdgeInsets.only(top: 70),
                child: const Text(
                  'Выберите время',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto'),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.only(left: 36.5, right: 36.5, top: 35),
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
                    const EdgeInsets.only(left: 36.5, right: 36.5, bottom: 200),
                child: TextFormField(
                  controller: endtimeinput,
                  readOnly: true,
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: const InputDecoration(
                      labelText: 'Время конца брони',
                      prefixIcon: Icon(
                        Icons.watch_later_outlined,
                        color: Colors.deepOrange,
                      )),
                  onTap: () => timePicker(endtimeinput),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: MyColors.kFrameBackground,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.close,
                        size: 24.0,
                        color: Colors.deepOrange,
                      ),
                      label: const Text(
                        'Отмена',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.deepOrange,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  const Text('2/3',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.deepOrange,
                          fontSize: 16)),
                  TextButton(
                    onPressed: () {},
                    child: TextButton.icon(
                      onPressed: () {},
                      label: const Text(
                        'Дальше',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.deepOrange,
                            fontSize: 16),
                      ),
                      icon: const Icon(
                        Icons.arrow_forward_outlined,
                        size: 24.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                  )
                ]))),);
  }
}
