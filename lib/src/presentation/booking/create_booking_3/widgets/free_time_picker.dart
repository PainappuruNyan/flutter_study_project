import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../bloc/booking_create_3/booking_create3_bloc.dart';
import '../../../../bloc/free_time_picker/free_time_piker_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../data/models/booking_model.dart';
import '../../../../domain/entities/workplace.dart';

class FreeTimePicker extends StatefulWidget {
  const FreeTimePicker(
      {super.key,
      required this.placeId,
      required this.date,
      required this.bookingBloc,
      required this.workplace});

  final int placeId;
  final DateTime date;
  final BookingCreate3Bloc bookingBloc;
  final Workplace workplace;

  @override
  _FreeTimePickerState createState() => _FreeTimePickerState();
}

class _FreeTimePickerState extends State<FreeTimePicker> {
  DateFormat format = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FreeTimePikerBloc(),
      child: AlertDialog(
        title: Text('Выберите один из промежутков',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 22.sp),
            textAlign: TextAlign.center),
        content: BlocBuilder<FreeTimePikerBloc, FreeTimePikerState>(
          builder: (BuildContext context, FreeTimePikerState state) {
            if (state is FreeTimePikerInitial) {
              print(widget.placeId);
              print(widget.date);
              context.read<FreeTimePikerBloc>().add(
                  DialogStarted(placeId: widget.placeId, date: widget.date));
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FreeTimePikerLoaded) {
              return SizedBox(
                width: 270.w,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.intervals.length,
                    itemBuilder: (BuildContext _, int index) {
                      return Column(
                        children: <Widget>[
                          FlutterSlider(
                              handlerHeight: 30.h,
                              lockHandlers: false,
                              touchSize: 5,
                              selectByTap: false,
                              trackBar: const FlutterSliderTrackBar(
                                  activeTrackBar:
                                      BoxDecoration(color: MyColors.kPrimary)),
                              rightHandler: FlutterSliderHandler(
                                child: const Icon(
                                  Icons.access_time,
                                  color: Colors.grey,
                                  size: 24,
                                ),
                              ),
                              handler: FlutterSliderHandler(
                                child: const Icon(
                                  Icons.access_time,
                                  color: Colors.grey,
                                  size: 24,
                                ),
                              ),
                              values: <double>[
                                state.intervals[index].start
                                    .millisecondsSinceEpoch
                                    .toDouble(),
                                state
                                    .intervals[index].end.millisecondsSinceEpoch
                                    .toDouble()
                              ],
                              rangeSlider: true,
                              max: state.constIntervals[index].end
                                  .millisecondsSinceEpoch
                                  .toDouble(),
                              min: state.constIntervals[index].start
                                  .millisecondsSinceEpoch
                                  .toDouble(),
                              step: const FlutterSliderStep(step: 60),
                              onDragging: (int handlerIndex, dynamic lowerValue,
                                  dynamic upperValue) {
                                context.read<FreeTimePikerBloc>().add(
                                    TimeIntervalChanged(
                                        index: index,
                                        start: lowerValue as double,
                                        end: upperValue as double));
                              },
                              tooltip:
                                  FlutterSliderTooltip(custom: (dynamic value) {
                                final DateTime dtValue =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        (value as double).toInt());
                                final String valueInTime =
                                    format.format(dtValue);
                                return Card(
                                    child: Text(
                                  valueInTime,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ));
                              })),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                    '${format.format(state.intervals[index].start)}-'
                                    '${format.format(state.intervals[index].end)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500)),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                padding: EdgeInsets.only(right: 24.w),
                                child: MaterialButton(
                                  color: MyColors.kPrimary,
                                  height: 35.sp,
                                  onPressed: () {
                                    DateTime nStart = DateTime(
                                        widget.date.year,
                                        widget.date.month,
                                        widget.date.day,
                                        state.intervals[index].start.hour,
                                        state.intervals[index].start.minute);

                                    DateTime nEnd = DateTime(
                                        widget.date.year,
                                        widget.date.month,
                                        widget.date.day,
                                        state.intervals[index].end.hour,
                                        state.intervals[index].end.minute);
                                    widget.bookingBloc
                                        .add(BookingCreate3WorkplaceSelected(
                                            booking: BookingModel(
                                      id: -1,
                                      holder: widget.bookingBloc.holdersId[0],
                                      maker: widget.bookingBloc.makerId,
                                      workplace: widget.workplace.id!,
                                      start: nStart,
                                      end: nEnd,
                                      guests: 0,
                                    )));
                                  },
                                  child: const Text(
                                    'Выбрать',
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }),
              );
            }
            return const Center(
              child: Text('Ошибка'),
            );
          },
        ),
      ),
    );
  }
}
