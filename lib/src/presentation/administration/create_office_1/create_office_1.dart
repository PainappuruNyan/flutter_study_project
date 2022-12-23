import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../bloc/office_create_1/office_create_1_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../../domain/entities/city.dart';
import '../../../domain/entities/office.dart';
import '../../shared_widgets/bottom_app_bar.dart';
import '../create_office_2/create_office_2.dart';
import 'widgets/custom_form_field.dart';

class CreateOffice1 extends StatefulWidget {
  const CreateOffice1({super.key});

  static const String routeName = '/create_office/1';

  @override
  State<CreateOffice1> createState() => _CreateOffice1State();
}

class _CreateOffice1State extends State<CreateOffice1> {
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

  String? validatorCity(City? value) {
    if (value == null) {
      return 'Please enter some text';
    }
    return null;
  }

  void nextRoute(Office office) {
    Navigator.of(context).push(MaterialPageRoute<CreateOffice2>(
        builder: (_) =>
            CreateOffice2(
              floorCount: int.parse(floorCountInput.text),
              nOffice: office,
              officeId: 8,
            )

    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OfficeCreate1Bloc>(
      create: (BuildContext context) =>
      OfficeCreate1Bloc()
        ..add(Starting()),
      child: BlocBuilder<OfficeCreate1Bloc, OfficeCreate1State>(
        builder: (BuildContext context, OfficeCreate1State state) {
          if (state is OfficeCreate1Initial) {
            startdateinput.text = DateFormat('HH:mm')
                .format(state.beginningTime);
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
                              isDateTime: true,
                              index: 1,
                            ),
                            CustomFormField(
                              formKey: _formKey,
                              valid: validator,
                              icon: Icons.calendar_month,
                              controller: enddateinput,
                              labelText: 'Конец бронирований',
                              isDateTime: true,
                              index: 2,
                            ),
                            CustomFormField(
                              formKey: _formKey,
                              valid: validator,
                              icon: Icons.house,
                              controller: bookingRangeInput,
                              labelText: 'Диапазон брони',
                              inputType: TextInputType.number,
                              index: 3,
                            ),
                            CustomFormField(
                              formKey: _formKey,
                              valid: validator,
                              icon: Icons.house,
                              controller: floorCountInput,
                              labelText: 'Количество этажей',
                              inputType: TextInputType.number,
                              index: 4,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 6.5.sp, right: 40.5.sp, top: 7.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 22.w),
                                    child: InkWell(
                                      child: validator(cityInput.text) == null
                                          ? Ink(
                                        decoration: const ShapeDecoration(
                                            color: MyColors.kPrimary,
                                            shape: CircleBorder()),
                                        child: const Icon(
                                          Icons.done,
                                          color: MyColors.kWhite,
                                        ),
                                      )
                                          : Ink(
                                        child: Stack(
                                            alignment: Alignment.center,
                                            children: <Icon>[
                                              Icon(
                                                Icons.circle,
                                                color: MyColors.kPrimary,
                                                size: 32.sp,
                                              ),
                                              Icon(Icons.circle,
                                                  color: MyColors.kWhite,
                                                  size: 30.sp),
                                              Icon(
                                                Icons.circle,
                                                color: MyColors.kPrimary,
                                                size: 10.sp,
                                              ),
                                            ]),
                                      ),
                                      onTap: () {},
                                    ),
                                  ),
                                  DropdownSearch<City>(
                                    items: context
                                        .read<OfficeCreate1Bloc>()
                                        .cityList,
                                    dropdownDecoratorProps:
                                    DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                        InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.location_city,
                                            color: MyColors.kPrimary,),
                                          labelText: 'Город',
                                          constraints:
                                          BoxConstraints(maxWidth: 250.w),
                                        )),
                                    onChanged: (City? data) {
                                      print(data);
                                      context.read<OfficeCreate1Bloc>().add(
                                          FieldChanged(
                                              fieldChanged: 5,
                                              nText: '${data!.name} ${data.id}'));
                                    },
                                    itemAsString: (City u) => u.name,
                                  ),
                                ],
                              ),
                            ),
                            CustomFormField(
                              formKey: _formKey,
                              valid: validator,
                              labelText: 'Выберите адрес офиса',
                              icon: Icons.location_pin,
                              controller: addressInput,
                              index: 6,
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: BlocListener<OfficeCreate1Bloc, OfficeCreate1State>(
                listener: (BuildContext context, OfficeCreate1State state) {
                  if(state is OfficeCreated){
                    nextRoute(state.nOffice);
                  }
                },
                child: CustomBottomAppBar(
                  pageNum: '1',
                  pageCount: '3',
                  nextRoute: () {
                    context.read<OfficeCreate1Bloc>().add(ConfirmCreation(office: state.nOffice));
                  },
                  nextPageButton: true,
                  dateValid: _formKey.currentState?.validate(),
                ),
              ), // bottomNavigationBar: const CustomBottomAppBar(pageNum: '1', pageCount: '3',nextRoute: Routes.profile,)
            );
          }
          return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ));
        },
      ),
    );
  }
}
