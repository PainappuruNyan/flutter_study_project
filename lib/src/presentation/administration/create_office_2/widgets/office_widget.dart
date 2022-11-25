import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../domain/entities/office.dart';

class OfficeWidgetHeader extends StatefulWidget {
  OfficeWidgetHeader({
    super.key,
    this.isFavorite = false,
    required this.office
  });

  bool isFavorite;
  final Office office;

  @override
  State<OfficeWidgetHeader> createState() {
    return _OfficeWidgetHeaderState();
  }
}

class _OfficeWidgetHeaderState extends State<OfficeWidgetHeader> {

  @override
  void initState() {
    super.initState();
  }

  void markFavorite() {
    setState(() {
      widget.isFavorite = !widget.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: 300.w,
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(onPressed: () {
              markFavorite();
            },
                padding: EdgeInsets.only(right: 5.w),
                constraints: const BoxConstraints(),
                icon: Stack(
                  children: <Widget>[
                    Icon(Icons.star,
                      color: widget.isFavorite ? Colors.orangeAccent : Colors.white,
                    size: 26.sp,),
                    Icon(Icons.star_border_outlined, color: Colors.black, size: 26.sp,)
                  ],)),
            Text(widget.office.address, style: Theme
                .of(context)
                .textTheme
                .bodyText2?.copyWith(fontSize: 18.sp),),
          ],
        ),
        childrenPadding: EdgeInsets.only(left: 29.5.w),
        expandedAlignment: Alignment.centerLeft,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.office.workNumber, style: Theme
                  .of(context)
                  .textTheme
                  .bodySmall,),
              Align(
                  alignment: Alignment.centerRight,
                  child: MaterialButton(
                    onPressed: () {},
                    minWidth: 118.w,
                    height: 40.h,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: MyColors.kPrimary, width: 2.0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textColor: MyColors.kPrimary,
                    child: const Text('Выбрать',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                  ),
              )
            ],
          )
        ],
      ),
    );
  }
}
