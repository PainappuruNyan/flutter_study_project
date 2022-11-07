import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: basicTheme(),
      title: 'Формирование брони',
      home: const BookingCreate2Screen(),
    );
  }
}

class BookingCreate2Screen extends StatefulWidget {
  const BookingCreate2Screen({super.key});

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
                    //editing controller of this TextField
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.calendar_month,
                        color: MyColors.kPrimary,
                      ),
                      //icon of text field
                      labelText: 'Дата начала брони',
                    ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      final DateTime now = DateTime.now();

                      final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: DateTime(now.year, now.month, now.day),
                          lastDate: DateTime(now.year + 10));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        final String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          dateinput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
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
                  onTap: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );

                    if (pickedTime != null) {
                      print(pickedTime.format(context)); //output 10:51 PM
                      final DateTime parsedTime = DateFormat.jm()
                          .parse(pickedTime.format(context).toString());
                      //converting to DateTime so that we can further format on different pattern.
                      print(parsedTime); //output 1970-01-01 22:53:00.000
                      final String formattedTime =
                          DateFormat('HH:mm').format(parsedTime);
                      print(formattedTime); //output 14:59:00
                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                        begintimeinput.text =
                            formattedTime; //set the value of text field.
                      });
                    } else {
                      print("Time is not selected");
                    }
                  },
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
                      labelText: 'Время начала брони',
                      prefixIcon: Icon(
                        Icons.watch_later_outlined,
                        color: Colors.deepOrange,
                      )),
                  onTap: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );

                    if (pickedTime != null) {
                      print(pickedTime.format(context)); //output 10:51 PM
                      final DateTime parsedTime = DateFormat.jm()
                          .parse(pickedTime.format(context).toString());
                      //converting to DateTime so that we can further format on different pattern.
                      print(parsedTime); //output 1970-01-01 22:53:00.000
                      final String formattedTime =
                          DateFormat('HH:mm').format(parsedTime);
                      print(formattedTime); //output 14:59:00
                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                        endtimeinput.text =
                            formattedTime; //set the value of text field.
                      });
                    } else {
                      print("Time is not selected");
                    }
                  },
                ),
              ),
              Container(
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
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
