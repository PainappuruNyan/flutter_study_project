import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../domain/entities/office.dart';
import '../../create_booking_2/booking_create_2.dart';

class OfficeExpandable extends StatefulWidget {
  const OfficeExpandable({super.key, required this.offices, required this.city});

  final String city;
  final List<Office> offices;

  @override
  _OfficeExpandableState createState() => _OfficeExpandableState();
}

class _OfficeExpandableState extends State<OfficeExpandable> {
  @override
  Widget build(BuildContext context) {
    return Accordion(
      disableScrolling: true,
        headerBorderRadius: 4,
        paddingListTop: 0,
        paddingListBottom: 0,
        contentBorderRadius: 4,
        contentBorderWidth: 0,
        children: <AccordionSection>[
          AccordionSection(
            contentBorderRadius: 4,
            headerBackgroundColor: MyColors.kPrimary,
            header: Text(
              widget.city,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1?.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
            contentHorizontalPadding: 20,
            contentBorderWidth: 1,
            content: ListView.builder(

              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.offices.length,
              itemBuilder: (BuildContext context, int index){
                return OfficeAddressCard(office: widget.offices[index]);
              },
              shrinkWrap: true,
            ),
          ),
        ]);
  }
}

class OfficeAddressCard extends StatelessWidget {
  const OfficeAddressCard({super.key, required this.office});

  final Office office;

  @override
  Widget build(BuildContext context) {
    int selectedOffice = office.id;
    return InkWell(
      child: Card(
        color: MyColors.kPrimaryLight,
        child: Container(
            padding: EdgeInsets.only(top: 4.h, bottom: 4.h, right: 4.w, left: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(office.address, style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),),
                Wrap(
                  spacing: 8.sp,
                  children: <Widget>[
                    InkWell(child: const Icon(
                      Icons.location_on_sharp, color: MyColors.kPrimary,),
                      onTap: () {},),
                    InkWell(child: Ink(decoration:
                    const ShapeDecoration(
                        color: MyColors.kPrimary, shape: CircleBorder())
                      , child: const Icon(Icons.done, color: MyColors.kWhite,),),
                      onTap: () {Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => BookingCreate2Screen(
                            selectedOffice: selectedOffice,
                          ),
                        ),
                      );},)
                  ],
                )
              ],
            )
        ),
      ),
      onTap: (){
        showDialog(context: context, builder: (BuildContext context){

          final TextStyle textStyle = Theme.of(context).textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w500
          );
          return AlertDialog(
            title: Text(office.address, style: textStyle,),
            content: SizedBox(
              height: 270.h,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Посмотреть на карте', style: textStyle),
                      InkWell(child: const Icon(
                        Icons.location_on_sharp, color: MyColors.kPrimary,),
                        onTap: () {},),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Рабочий телефон', style: textStyle),
                      Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: InkWell(child: const Icon(
                          Icons.copy, color: MyColors.kPrimary,),
                          onTap: () {},),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(office.workNumber, style: textStyle.copyWith(fontWeight: FontWeight.normal)),
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(onPressed: (){}, child: Text('Избранное', style: Theme.of(context).textTheme.bodyText2),),
              MaterialButton(onPressed: (){
                selectedOffice = office.id;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => BookingCreate2Screen(
                      selectedOffice: selectedOffice,
                    ),
                  ),
                );
              }, child: Text('Выбрать', style: Theme.of(context).textTheme.bodyText2),),
            ],
          );
        });
      },
    );
  }
}
