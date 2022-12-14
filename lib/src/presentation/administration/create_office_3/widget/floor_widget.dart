import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';

class FloorExpandable extends StatefulWidget {
  const FloorExpandable({super.key, required this.floor});

  final String floor;

  @override
  _OfficeExpandableState createState() => _OfficeExpandableState();
}

class _OfficeExpandableState extends State<FloorExpandable> {
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
              '${widget.floor} Этаж',
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1?.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
            contentHorizontalPadding: 20,
            contentBorderWidth: 1,

            content: Column(
              children: [
                WorkplaceCard(places: 24, type: true,),
                WorkplaceCard(places: 5, type: false,),
                Container( alignment:Alignment.centerRight,child: MaterialButton(onPressed: (){}, child: Text('Загрузить'),))
              ],
            ),/*ListView.builder(

              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (BuildContext context, int index){
                return WorkplaceCard(office: widget.offices[index]);
              },
              shrinkWrap: true,
            ),*/
          ),
        ]);
  }
}

class WorkplaceCard extends StatelessWidget {
  const WorkplaceCard({super.key, required this.places, required this.type});

  final bool type;
  final int places;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        color: MyColors.kPrimaryLight,
        child: Container(
            padding: EdgeInsets.only(top: 4.h, bottom: 4.h, right: 4.w, left: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(type ? 'Мест: $places' : 'Переговорок: $places',
                  style: Theme.of(context).textTheme.bodyText2
                      ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),),
                Wrap(
                  spacing: 8.sp,
                  children: <Widget>[
                    InkWell(child: Ink(decoration:
                    const ShapeDecoration(
                        color: MyColors.kPrimary, shape: CircleBorder())
                      , child: const Icon(Icons.list, color: MyColors.kWhite,),),
                      onTap: () {},)
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
            title: Text(type ? 'Места': 'Переговорки', style: textStyle,),
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
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(onPressed: (){}, child: Text('Избранное', style: Theme.of(context).textTheme.bodyText2),),
              MaterialButton(onPressed: (){}, child: Text('Выбрать', style: Theme.of(context).textTheme.bodyText2),),
            ],
          );
        });
      },
    );
  }
}
