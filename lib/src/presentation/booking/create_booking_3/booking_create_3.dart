import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_decoration/icon_decoration.dart';

import '../../../core/constants/colors.dart';
import '../../routes/routes.dart';
import '../../shared_widgets/bottom_app_bar.dart';

class BookingCreate3Screen extends StatefulWidget {
  const BookingCreate3Screen({super.key});

  static const String routeName = '/booking_create/3';

  @override
  State<StatefulWidget> createState() {
    return _BookingCreate3Screen();
  }
}

class _BookingCreate3Screen extends State<BookingCreate3Screen> {
  static final List<String> favoriteList = <String>[
    'id 1',
    'id 2',
    'id 3',
    'id 4',
    'id 5',
  ];
  static final List<String> workplaceList = <String>[
    'id 1',
    'id 2',
    'id 3',
    'id 4',
    'id 5',
  ];
  static final List<String> meetingroomList = <String>[
    'id 1',
    'id 2',
    'id 3',
    'id 4',
    'id 5',
  ];
  // final List<bool> _isFavorited = List<bool>.filled(favoriteList.length, false);

  static final List<String> floors = <String>[
    '1 Этаж',
    '2 Этаж',
    '3 Этаж',
    '4 Этаж',
    '5 Этаж',
    '6 Этаж',
  ];
  String? selectedFloor = '1 Этаж';
  bool listChecked = true;
  bool mapChecked = false;
  String searchString = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.kWhite,
      appBar: AppBar(
          title: const Text(
        'Формирование брони',
      )),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30.sp, bottom: 20.sp),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 30.sp),
                    child: CustomDropDown(
                      value: selectedFloor,
                      itemsList: floors,
                      onChanged: (dynamic value) {
                        setState(() {
                          selectedFloor = value.toString();
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.sp),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            mapChecked = true;
                            listChecked = false;
                          });
                        },
                        child: mapChecked
                            ? const Text('Карта',
                                style: TextStyle(
                                    color: MyColors.kSecondary, fontSize: 18))
                            : const Text('Карта',
                                style: TextStyle(
                                    color: MyColors.kTextSecondary,
                                    fontSize: 18))),
                  ),
                  SizedBox(
                    height: 20.h,
                    child: const VerticalDivider(
                      color: MyColors.kPrimaryText,
                      thickness: 2,
                      width: 15,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          mapChecked = false;
                          listChecked = true;
                        });
                      },
                      child: listChecked
                          ? const Text('Список',
                              style: TextStyle(
                                  color: MyColors.kSecondary, fontSize: 18))
                          : const Text('Список',
                              style: TextStyle(
                                  color: MyColors.kTextSecondary,
                                  fontSize: 18))),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: 32.sp, right: 10, bottom: 5.sp, top: 5.sp),
              width: 320.w,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
              ),
              child: TextField(
                style: Theme.of(context).textTheme.bodyText2,
                onChanged: (String value) {
                  setState(() {
                    searchString = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Поиск',
                  hintStyle: Theme.of(context).textTheme.caption,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 30.sp, top: 15.sp, right: 30.sp),
                alignment: Alignment.topLeft,
                child: ExpansionTile(
                  title: Text(
                    'Избранное',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: favoriteList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              elevation: 4,
                              child: ListTile(
                                title: Text(
                                  favoriteList[index],
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                trailing: const DecoratedIcon(
                                  icon: Icon(Icons.star,
                                      color: MyColors.kSecondary),
                                  decoration: IconDecoration(
                                      border: IconBorder(
                                          color: MyColors.kPrimaryText,
                                          width: 2)),
                                ),
                                // trailing: IconButton(
                                //   onPressed: () => setState(() =>
                                //       _isFavorited[index] =
                                //           !_isFavorited[index]),
                                //   icon: _isFavorited[index]
                                //       ? const Icon(
                                //           Icons.star,
                                //           color: MyColors.kSecondary,
                                //         )
                                //       : const Icon(Icons.star_border),
                                // ),
                              ));
                        }),
                  ],
                )),
            Container(
                padding: EdgeInsets.only(left: 30.sp, top: 15.sp, right: 30.sp),
                alignment: Alignment.topLeft,
                child: ExpansionTile(
                  title: Text(
                    'Рабочие места',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: workplaceList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 4,
                            child: ListTile(
                              title: Text(
                                workplaceList[index],
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              trailing: const DecoratedIcon(
                                icon: Icon(Icons.star,
                                    color: MyColors.kSecondary),
                                decoration: IconDecoration(
                                    border: IconBorder(
                                        color: MyColors.kPrimaryText,
                                        width: 2)),
                              ),
                              onTap: () {},
                            ),
                          );
                        }),
                  ],
                )),
            Container(
                padding: EdgeInsets.only(left: 30.sp, top: 15.sp, right: 30.sp),
                alignment: Alignment.topLeft,
                child: ExpansionTile(
                  title: Text(
                    'Переговорки',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: meetingroomList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 4,
                            child: ListTile(
                              title: Text(
                                meetingroomList[index],
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              trailing: const DecoratedIcon(
                                icon: Icon(Icons.star,
                                    color: MyColors.kSecondary),
                                decoration: IconDecoration(
                                    border: IconBorder(
                                        color: MyColors.kPrimaryText,
                                        width: 2)),
                              ),
                              onTap: () {},
                            ),
                          );
                        }),
                  ],
                )),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(
        pageCount: '3',
        pageNum: '3',
        nextRoute: Routes.profile,
      ),
    );
  }
}

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    required this.value,
    required this.itemsList,
    required this.onChanged,
    super.key,
  });

  final dynamic value;
  final List<String> itemsList;
  final Function(dynamic value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      height: 35.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: MyColors.kSecondary, width: 1.5.w),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 5),
          child: DropdownButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: MyColors.kSecondary,
            ),
            isExpanded: true,
            value: value,
            items: itemsList
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ))
                .toList(),
            onChanged: (Object? value) => onChanged(value),
          ),
        ),
      ),
    );
  }
}
