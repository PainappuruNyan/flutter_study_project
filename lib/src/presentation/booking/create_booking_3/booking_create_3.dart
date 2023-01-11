import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../bloc/booking_create_3/booking_create3_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../../domain/entities/floor.dart';
import '../../shared_widgets/bottom_app_bar.dart';
import '../../shared_widgets/simple_teammate_card.dart';
import '../../shared_widgets/workplace_card.dart';
import '../booking_list/booking_list_screen.dart';
import 'package:atb_first_project/dependency_injection_container.dart' as di;

class BookingCreate3Screen extends StatefulWidget {
  BookingCreate3Screen({
    super.key,
    required this.selectedOffice,
    required this.dateStart,
    required this.timeStart,
    required this.timeEnd,
    required this.holdersId,
    required this.isEdit,
    this.editedBookingId,
  });

  final int selectedOffice;
  final String? dateStart;
  final String? timeStart;
  final String? timeEnd;
  final List<int> holdersId;
  final bool isEdit;
  int? editedBookingId;

  static const String routeName = '/booking_create/3';

  @override
  State<BookingCreate3Screen> createState() => _BookingCreate3ScreenState(
      selectedOffice, dateStart, timeStart, timeEnd, isEdit, editedBookingId);
}

class _BookingCreate3ScreenState extends State<BookingCreate3Screen>
    with SingleTickerProviderStateMixin {
  _BookingCreate3ScreenState(this.selectedOffice, this.dateStart,
      this.timeStart, this.timeEnd, this.isEdit, this.editedBookingId);

  final int selectedOffice;
  final String? dateStart;
  final String? timeStart;
  final String? timeEnd;
  final bool isEdit;
  int? editedBookingId;

  int? selectedFloor = 1;
  bool listChecked = true;
  bool mapChecked = false;
  String searchString = '';

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2400));
    animationController.addStatusListener((AnimationStatus status) async {
      if (status == AnimationStatus.completed) {
        animationController.reset();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const BookingListScreen(
                      isOfficeBooking: false,
                    )),
            (Route route) => route.isFirst);
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void successAnimation() => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => Center(
              child: SizedBox(
                width: 200.w,
                height: 200.h,
                child: Lottie.asset('assets/animation/success.json',
                    repeat: false, controller: animationController,
                    onLoaded: (LottieComposition composition) {
                  animationController.duration = composition.duration;
                  animationController.forward();
                }),
              ),
            ));
    final DateTime dateTimeStart = DateTime.parse('$dateStart $timeStart');
    final DateTime dateTimeEnd = DateTime.parse('$dateStart $timeEnd');
    return BlocProvider<BookingCreate3Bloc>(
      create: (BuildContext context) => BookingCreate3Bloc(
          selectedOffice, dateTimeStart, dateTimeEnd,
          holdersId: widget.holdersId,
          isEdit: isEdit,
          editedBookingId: editedBookingId)
        ..add(BookingCreate3Start()),
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
          'Формирование брони',
        )),
        body: SlidingUpPanel(
          color: Theme.of(context).scaffoldBackgroundColor,
          minHeight: 50.h,
          panelBuilder: (ScrollController sc) {
            return BlocConsumer<BookingCreate3Bloc, BookingCreate3State>(
              listener: (BuildContext context, BookingCreate3State state) {
                if (state is BookingCreate3FloorLoaded) {}
              },
              builder: (BuildContext context, BookingCreate3State state) {
                print('state is ${state}');
                if (state is BookingCreate3FloorLoaded) {
                  print('длина букинга ${state.bookings.length}');
                  return Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.grey,
                          width: 1.2.w,
                        ))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Выбрано ${state.bookings.length}/${state.holdersId.length}'),
                              Column(
                                children: [
                                  Text('Выберете место для'),
                                  Text('${state.selectedName.split(' ').first +' '+state.selectedName.split(' ')[1][0]+'. ' + state.selectedName.split(' ')[2][0] +'.'}')
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: sc,
                          itemCount: context
                              .read<BookingCreate3Bloc>()
                              .holdersId
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            return SimpleTeammateCard(
                              employee: state.holdersEmployee[index],
                              isSelected: state.selectedEmployee == index,
                              selectedPlace: state.getSelectedPlace(
                                  state.holdersEmployee[index].id),
                              onTap: () {
                                context.read<BookingCreate3Bloc>().add(
                                    ChangeSelectedEmployee(nSelectedId: index));
                              },
                            );
                          },
                        ),
                      )
                    ],
                  );
                }
                return Container();
              },
            );
          },
          body: BlocConsumer<BookingCreate3Bloc, BookingCreate3State>(
            builder: (BuildContext context, BookingCreate3State state) {
              if (state is! ShowWorkplaces && state is! BookingCreate3ShowMap) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ShowWorkplaces) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 200.h),
                  child: SingleChildScrollView(
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
                                  value: '${state.selectedFloor} Этаж',
                                  itemsList: state.floors
                                      .map((Floor e) => e.floorNumber)
                                      .toList(),
                                  onChanged: (dynamic value) {
                                    final String selected = value as String;
                                    final int result = int.parse(selected
                                        .substring(0, selected.indexOf(' ')));
                                    context.read<BookingCreate3Bloc>().add(
                                        BookingCreate3ChangeFloor(
                                            floorNumber: result));
                                  },
                                ),
                              ),
                              //Карта и Спислк
                              Container(
                                padding: EdgeInsets.only(left: 20.sp),
                                child: TextButton(
                                    onPressed: () {
                                      context
                                          .read<BookingCreate3Bloc>()
                                          .add(BookingCreate3ChangeToMap());
                                    },
                                    child: const Text('Карта',
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
                                    context
                                        .read<BookingCreate3Bloc>()
                                        .add(BookingCreate3ChangeToList());
                                  },
                                  child: const Text('Список',
                                      style: TextStyle(
                                          color: MyColors.kSecondary,
                                          fontSize: 18))),
                            ],
                          ),
                        ),

                        //Строка поиска
                        //expansions
                        Container(
                            padding: EdgeInsets.only(
                                left: 30.sp, top: 15.sp, right: 30.sp),
                            alignment: Alignment.topLeft,
                            child: ExpansionTile(
                              title: Text(
                                'Избранное',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              children: <Widget>[
                                ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.favorites.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return WorkplaceCard(
                                        workplace: state.favorites[index],
                                        dateTimeStart: dateTimeStart,
                                        dateTimeEnd: dateTimeEnd,
                                      );
                                    }),
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.only(
                                left: 30.sp, top: 15.sp, right: 30.sp),
                            alignment: Alignment.topLeft,
                            child: ExpansionTile(
                              title: Text(
                                'Рабочие места',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              children: <Widget>[
                                ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.usualWorkplaces.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return WorkplaceCard(
                                          workplace: state.usualWorkplaces[index],
                                          dateTimeStart: dateTimeStart,
                                          dateTimeEnd: dateTimeEnd);
                                    }),
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.only(
                                left: 30.sp, top: 15.sp, right: 30.sp),
                            alignment: Alignment.topLeft,
                            child: ExpansionTile(
                              title: Text(
                                'Переговорки',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              children: <Widget>[
                                ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.meetingRoom.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return WorkplaceCard(
                                          workplace: state.meetingRoom[index],
                                          dateTimeStart: dateTimeStart,
                                          dateTimeEnd: dateTimeEnd);
                                    }),
                              ],
                            )),
                      ],
                    ),
                  ),
                );
              }
              if (state is BookingCreate3ShowMap) {
                final SharedPreferences sharedPreference = di.sl();
                final String? username = sharedPreference.getString('username');
                final String? password = sharedPreference.getString('password');
                print('Выбран этаж ${state.selectedFloorEntity}');

                return SingleChildScrollView(
                    child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 30.sp, bottom: 20.sp),
                    child: Row(
                      children: <Widget>[
                        //Выбор этажа
                        Container(
                          padding: EdgeInsets.only(left: 30.sp),
                          child: CustomDropDown(
                            value: '${state.selectedFloor} Этаж',
                            itemsList: state.floors
                                .map((Floor e) => e.floorNumber)
                                .toList(),
                            onChanged: (dynamic value) {
                              final String selected = value as String;
                              final int result = int.parse(selected
                                  .substring(0, selected.indexOf(' ')));
                              context.read<BookingCreate3Bloc>().add(
                                  BookingCreate3ChangeFloor(
                                      floorNumber: result));
                            },
                          ),
                        ),
                        //Карта и Спислк
                        Container(
                            padding: EdgeInsets.only(left: 20.sp),
                            child: TextButton(
                                onPressed: () {
                                  context
                                      .read<BookingCreate3Bloc>()
                                      .add(BookingCreate3ChangeToMap());
                                },
                                child: const Text('Карта',
                                    style: TextStyle(
                                        color: MyColors.kSecondary,
                                        fontSize: 18)))),
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
                              context
                                  .read<BookingCreate3Bloc>()
                                  .add(BookingCreate3ChangeToList());
                            },
                            child: const Text('Список',
                                style: TextStyle(
                                    color: MyColors.kTextSecondary,
                                    fontSize: 18))),
                      ],
                    ),
                  ),
                  Container(
                    child: SizedBox(
                        width: 360.w,
                        height: 325.h,
                        child: ClipRect(
                          child: PhotoView(
                            backgroundDecoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            imageProvider: state.selectedFloorEntity!.mapFloor != null
                                ? NetworkImage(
                                    'http://10.0.2.2:8080/image/${state.selectedFloorEntity!.mapFloor}',
                                    headers: <String, String>{
                                        HttpHeaders.authorizationHeader:
                                            'Basic ${base64.encode(utf8.encode('$username:$password'))}'
                                      })
                                : const AssetImage(
                                        'assets/images/Default_image.png')
                                    as ImageProvider,
                          ),
                        )),
                  ),
                ]));
              }
              return const Text('');
            },
            listener: (BuildContext context, BookingCreate3State state) async {
              if (state is BookingSuccess) {
                successAnimation();
              }
            },
          ),
        ),
        bottomNavigationBar:
            BlocBuilder<BookingCreate3Bloc, BookingCreate3State>(
          builder: (BuildContext context, BookingCreate3State state) {
            return CustomBottomAppBar(
              pageCount: '3',
              pageNum: '3',
              dateValid: true,
              nextRoute: () {
                print('нажали на дальше');
                context
                    .read<BookingCreate3Bloc>()
                    .add(BookingCreate3SendWorkplaces());
              },
              nextPageButton: true,
            );
          },
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
        color: Theme.of(context).scaffoldBackgroundColor,
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
                .map((int item) => DropdownMenuItem<String>(
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
