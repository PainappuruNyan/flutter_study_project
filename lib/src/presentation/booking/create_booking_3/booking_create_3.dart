import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/booking_create_3/booking_create3_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../routes/routes.dart';
import '../../shared_widgets/bottom_app_bar.dart';
import '../../shared_widgets/workplace_card.dart';

class BookingCreate3Screen extends StatefulWidget {
  const BookingCreate3Screen({super.key});
  static const String routeName = '/booking_create/3';
  @override
  State<BookingCreate3Screen> createState() => _BookingCreate3ScreenState();
}

class _BookingCreate3ScreenState extends State<BookingCreate3Screen> {

  // final List<bool> _isFavorited = List<bool>.filled(favoriteList.length, false);

  int? selectedFloor = 1;
  bool listChecked = true;
  bool mapChecked = false;
  String searchString = '';





  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingCreate3Bloc>(
      create: (BuildContext context) => BookingCreate3Bloc()..add(BookingCreate3Start()),
      child: Scaffold(
        backgroundColor: MyColors.kWhite,
        appBar: AppBar(
            title: const Text(
              'Формирование брони',
            )),
        body: BlocBuilder<BookingCreate3Bloc, BookingCreate3State>(
          builder: (BuildContext context, BookingCreate3State state) {
            if (state is BookingCreate3FloorLoading) {
              return const Center(child: CircularProgressIndicator(),);
            }
            if (state is BookingCreate3FloorLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 30.sp, bottom: 20.sp),
                      child: Row(
                        children: <Widget>[
                          //Выбор этажа
                          Container(
                            padding: EdgeInsets.only(left: 30.sp),
                            child: CustomDropDown(
                              value: '$selectedFloor Этаж',
                              itemsList: state.floors,
                              onChanged: (dynamic value) {
                                setState(() {
                                  selectedFloor = value as int;
                                });
                              },
                            ),
                          ),
                          //Карта и Спислк
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
                                        color: MyColors.kSecondary,
                                        fontSize: 18))
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

                    //Строка поиска
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
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2,
                        onChanged: (String value) {
                          setState(() {
                            searchString = value.toLowerCase();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Поиск',
                          hintStyle: Theme
                              .of(context)
                              .textTheme
                              .caption,
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
                    //expansions
                    Container(
                        padding:
                        EdgeInsets.only(left: 30.sp, top: 15.sp, right: 30.sp),
                        alignment: Alignment.topLeft,
                        child: ExpansionTile(
                          title: Text(
                            'Избранное',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline4,
                          ),
                          children: <Widget>[
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.favorites.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return WorkplaceCard(
                                      workplace: state.favorites[index]);
                                  // Card(
                                  //   elevation: 4,
                                  //   child: ListTile(
                                  //     title: Text(
                                  //       'id${favoriteList[index]}',
                                  //       style:
                                  //       Theme.of(context).textTheme.subtitle2,
                                  //     ),
                                  //     onTap: () {
                                  //       context.read<BookingCreate3Bloc>().add(BookingCreate3WorkplaceSelected(booking: BookingModel(id: -1, holder: 1, maker: -1, workplace: favoriteList[index], start: DateTime(2022, 11, 27, 10), end: DateTime(2022, 11, 27, 20), guests: 0,)));
                                  //     },
                                  //     trailing: const DecoratedIcon(
                                  //       icon: Icon(Icons.star,
                                  //           color: MyColors.kSecondary),
                                  //       decoration: IconDecoration(
                                  //           border: IconBorder(
                                  //               color: MyColors.kPrimaryText,
                                  //               width: 2)),
                                  //     ),
                                  //     // trailing: IconButton(
                                  //     //   onPressed: () => setState(() =>
                                  //     //       _isFavorited[index] =
                                  //     //           !_isFavorited[index]),
                                  //     //   icon: _isFavorited[index]
                                  //     //       ? const Icon(
                                  //     //           Icons.star,
                                  //     //           color: MyColors.kSecondary,
                                  //     //         )
                                  //     //       : const Icon(Icons.star_border),
                                  //     // ),
                                  //   ));
                                }),
                          ],
                        )),
                    Container(
                        padding:
                        EdgeInsets.only(left: 30.sp, top: 15.sp, right: 30.sp),
                        alignment: Alignment.topLeft,
                        child: ExpansionTile(
                          title: Text(
                            'Рабочие места',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline4,
                          ),
                          children: <Widget>[
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.usualWorkplaces.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return WorkplaceCard(
                                      workplace: state.usualWorkplaces[index]);
                                }),
                          ],
                        )),
                    Container(
                        padding:
                        EdgeInsets.only(left: 30.sp, top: 15.sp, right: 30.sp),
                        alignment: Alignment.topLeft,
                        child: ExpansionTile(
                          title: Text(
                            'Переговорки',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline4,
                          ),
                          children: <Widget>[
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.meetengRoom.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return WorkplaceCard(
                                      workplace: state.meetengRoom[index]);
                                }),
                          ],
                        )),
                  ],
                ),
              );
            }
            return const Text('error');
          },
        ),
        bottomNavigationBar: const CustomBottomAppBar(
          pageCount: '3',
          pageNum: '3',
          nextRoute: Routes.profile,
        ),
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
  final List<int> itemsList;
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
            items: itemsList.map((int item) => DropdownMenuItem<String>(
                      value: '$item Этаж',
                      child: Text(
                        '$item Этаж',
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
