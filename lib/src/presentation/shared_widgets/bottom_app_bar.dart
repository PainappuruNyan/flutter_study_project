import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';
import '../routes/routes.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
    this.pageNum,
    this.pageCount,
    this.dateValid,
    this.startTimeValid,
    this.endTimeValid,
    required this.nextRoute,
    required this.nextPageButton,
  });

  final bool? dateValid;
  final bool? startTimeValid;
  final bool? endTimeValid;
  final dynamic nextRoute;
  final String? pageCount;
  final String? pageNum;
  final bool nextPageButton;

  @override
  Widget build(BuildContext context) {
    bool lastPageCheck = false;
    pageNum == pageCount ? lastPageCheck = false : lastPageCheck = true;
    return BottomAppBar(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 40),
                child: TextButton(
                  onPressed: () {},
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.booking_list);
                    },
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
              ),
              Visibility(
                visible: lastPageCheck,
                child: Text(
                  '$pageNum/$pageCount',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              if (pageCount != pageNum && nextPageButton == true)
                Padding(
                  padding: const EdgeInsets.only(right: 5, left: 40),
                  child: TextButton(
                    onPressed: () {},
                    child: TextButton.icon(
                      onPressed: () {
                        if (dateValid ?? false) {
                          nextRoute();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Заполните все поля')),
                          );
                        }
                      },
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
                  ),
                )
              else if (pageCount == pageNum && nextPageButton == true)
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 5),
                  child: TextButton(
                    onPressed: () {

                    },
                    child: TextButton.icon(
                      onPressed: () {
                        print('нажали в виджите');
                        nextRoute();
                      },
                      label: Text(
                        'Подтвердить',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      icon: const Icon(
                        Icons.check,
                        size: 24.0,
                        color: MyColors.kPrimary,
                      ),
                    ),
                  ),
                ),
            ])));
  }
}
