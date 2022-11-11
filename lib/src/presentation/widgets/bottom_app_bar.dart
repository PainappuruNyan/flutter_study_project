import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
    this.pageNum,
    this.pageCount,
  });

  final String? pageCount;
  final String? pageNum;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
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
                        color: MyColors.kPrimary,
                      ),
                      label: Text(
                        'Отмена',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                  Text(
                    '$pageNum/$pageCount',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: TextButton.icon(
                      onPressed: () {},
                      label: Text(
                        'Дальше',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      icon: const Icon(
                        Icons.arrow_forward_outlined,
                        size: 24.0,
                        color: MyColors.kPrimary,
                      ),
                    ),
                  )
                ])));
  }
}
