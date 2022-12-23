import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../bloc/office_create_1/office_create_1_bloc.dart';
import '../../../../core/constants/colors.dart';

class CustomFormField extends StatefulWidget {
  CustomFormField({
    super.key,
    required this.icon,
    required this.controller,
    required this.labelText,
    this.isDateTime = false,
    required this.valid,
    required this.index,
    required this.formKey,
    this.inputType
  });

  GlobalKey<FormState> formKey;
  IconData icon;
  TextEditingController controller;
  String labelText;
  bool isDateTime;
  String? Function(String?) valid;
  final int index;
  final TextInputType? inputType;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _valid(String text) {
    if (text == '' || text == null || text == '0') {
      print('пустая строка');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> datePicker(TextEditingController dateinput) async {
      assert(dateinput != null);

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
            DateFormat.jm().parse(pickedTime.format(context));
        final String formattedTime = DateFormat('HH:mm').format(parsedTime);
        setState(() {
          dateinput.text = formattedTime;
        });
      }
    }

    return Container(
        padding: EdgeInsets.only(left: 6.5.sp, right: 40.5.sp, top: 7.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 22.w),
              child: InkWell(
                child: _valid(widget.controller.text)
                    ? Ink(
                        decoration: const ShapeDecoration(
                            color: MyColors.kPrimary, shape: CircleBorder()),
                        child: const Icon(
                          Icons.done,
                          color: MyColors.kWhite,
                        ),
                      )
                    : Ink(
                        child:
                            Stack(alignment: Alignment.center, children: <Icon>[
                          Icon(
                            Icons.circle,
                            color: MyColors.kPrimary,
                            size: 32.sp,
                          ),
                          Icon(Icons.circle,
                              color: MyColors.kWhite, size: 30.sp),
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
            TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              keyboardType: widget.inputType,
              style: Theme.of(context).textTheme.bodyText2,
              controller: widget.controller,
              decoration: InputDecoration(
                constraints: BoxConstraints(maxWidth: 250.w),
                prefixIcon: Icon(
                  widget.icon,
                  color: MyColors.kPrimary,
                ),
                labelText: widget.labelText,
              ),
              onTap: () =>
                  widget.isDateTime ? datePicker(widget.controller) : null,
              onFieldSubmitted: (String? text) => context
                  .read<OfficeCreate1Bloc>()
                  .add(FieldChanged(fieldChanged: widget.index, nText: text)),
            ),
          ],
        ));
  }
}
