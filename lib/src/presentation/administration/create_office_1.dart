import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/constants/colors.dart';

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
    Future<void> datePicker(dateinput) async {
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
          leading: const Icon(Icons.arrow_back_ios_new),
          title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 55),
            child: Text(
              'Формирование офиса',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          )),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 36),
          child: const Text(
            'Введите данные офиса',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto'),
          ),
        ),
        Container(
            padding: const EdgeInsets.only(left: 36.5, right: 36.5, top: 35),
            child: Center(
                child: TextField(
              style: Theme.of(context).textTheme.bodyText2,
              //editing controller of this TextField
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.pin_drop,
                  color: MyColors.kPrimary,
                ),
                //icon of text field
                labelText: 'Выберите город офиса',
              ),
              //set it true, so that user will not able to edit text
            ))),
        Container(
            padding: const EdgeInsets.only(left: 36.5, right: 36.5),
            child: Center(
                child: TextField(
              style: Theme.of(context).textTheme.bodyText2,
              //editing controller of this TextField
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.house,
                  color: MyColors.kPrimary,
                ),
                //icon of text field
                labelText: 'Выберите адрес офиса',
              ),
              //set it true, so that user will not able to edit text
            ))),
        Container(
            padding: const EdgeInsets.only(left: 36.5, right: 36.5),
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
                //icon of text field
                labelText: 'Начало бронирований',
              ),
              onTap: () => datePicker(startdateinput),
            ))),
        Container(
            padding: const EdgeInsets.only(left: 36.5, right: 36.5),
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
                padding: const EdgeInsets.only(left: 36.5, right: 36.5, top: 45),
                child: Center(
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyText2,
                      //editing controller of this TextField
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.house,
                          color: MyColors.kPrimary,
                        ),
                        //icon of text field
                        labelText: '...',
                      ),
                      //set it true, so that user will not able to edit text
                    ))),
            Container(
                padding: const EdgeInsets.only(left: 36.5, right: 36.5),
                child: Center(
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyText2,
                      //editing controller of this TextField
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.house,
                          color: MyColors.kPrimary,
                        ),
                        //icon of text field
                        labelText: '...',
                      ),
                      //set it true, so that user will not able to edit text
                    ))),
      ])),
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
                    const Text('1/3',
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
                  ]))),
    );
  }
}
