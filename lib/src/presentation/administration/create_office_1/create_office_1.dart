import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../bloc/office_create_1/office_create_1_bloc.dart';
import '../../shared_widgets/bottom_app_bar.dart';
import '../create_office_2/create_office_2.dart';
import 'widgets/custom_form_field.dart';

class CreateOffice1 extends StatefulWidget {
  const CreateOffice1({super.key});

  static const String routeName = '/create_office/1';

  @override
  State<CreateOffice1> createState() => _CreateOffice1();
}

class _CreateOffice1 extends State<CreateOffice1> {
  TextEditingController startdateinput = TextEditingController();
  TextEditingController enddateinput = TextEditingController();
  TextEditingController bookingRangeInput = TextEditingController();
  TextEditingController floorCountInput = TextEditingController();
  TextEditingController cityInput = TextEditingController();
  TextEditingController addressInput = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //text editing controller for text field

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider<OfficeCreate1Bloc>(
      create: (BuildContext context) => OfficeCreate1Bloc(),
      child: BlocBuilder<OfficeCreate1Bloc, OfficeCreate1State>(
        builder: (BuildContext context, OfficeCreate1State state) {
          startdateinput.text = DateFormat('HH:mm').format((state as OfficeCreate1Initial).beginningTime);
          enddateinput.text = DateFormat('HH:mm').format(state.endTime);
          bookingRangeInput.text = state.bookingRange.toString();
          floorCountInput.text = state.floorsCount.toString();
          cityInput.text = state.city;
          addressInput.text = state.address;
          return Scaffold(
            appBar: AppBar(
                title: const Text(
                  'Формирование офиса',
                )),
            body: Container(
              padding: EdgeInsets.only(top: 36.sp),
              child: Column(
                children: <Widget>[
                  const Text(
                    'Введите данные офиса',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto'),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          CustomFormField(
                            formKey: _formKey,
                              valid: validator,
                              icon: Icons.calendar_month,
                              controller: startdateinput,
                              labelText: 'Начало бронирований',
                              isDateTime: true, index: 1,),
                          CustomFormField(
                            formKey: _formKey,
                              valid: validator,
                              icon: Icons.calendar_month,
                              controller: enddateinput,
                              labelText: 'Конец бронирований',
                              isDateTime: true, index: 2,),
                          CustomFormField(
                            formKey: _formKey,
                            valid: validator,
                            icon: Icons.house,
                            controller: bookingRangeInput,
                            labelText: 'Диапазон брони', index: 3,
                          ),
                          CustomFormField(
                            formKey: _formKey,
                            valid: validator,
                            icon: Icons.house,
                            controller: floorCountInput,
                            labelText: 'Количество этажей', index: 4,
                          ),
                          CustomFormField(
                            formKey: _formKey,
                            valid: validator,
                            icon: Icons.pin_drop,
                            controller: cityInput,
                            labelText: 'Выберите город офиса', index: 5,
                          ),
                          CustomFormField(
                            formKey: _formKey,
                            valid: validator,
                            labelText: 'Выберите адрес офиса',
                            icon: Icons.house,
                            controller: addressInput, index: 6,
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: CustomBottomAppBar(
              pageNum: '1',
              pageCount: '3',
              nextRoute: CreateOffice2(
                floorCount: int.parse(floorCountInput.text),
                nOffice: state.nOffice,
              ),
              nextPageButton: true,
              dateValid: _formKey.currentState?.validate(),
            ), // bottomNavigationBar: const CustomBottomAppBar(pageNum: '1', pageCount: '3',nextRoute: Routes.profile,)
          );
        },
      ),
    );
  }
}
