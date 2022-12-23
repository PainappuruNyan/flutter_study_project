import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/booking_create_3/booking_create3_bloc.dart';
import '../../core/constants/colors.dart';
import '../../data/models/booking_model.dart';
import '../../domain/entities/workplace.dart';
import '../booking/create_booking_3/widgets/free_time_picker.dart';

class WorkplaceCard extends StatelessWidget {
  WorkplaceCard(
      {super.key,
      required this.workplace,
      this.dateTimeStart,
      this.dateTimeEnd});

  final Workplace workplace;
  final DateTime? dateTimeStart;
  final DateTime? dateTimeEnd;

  TextEditingController guests = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCreate3Bloc, BookingCreate3State>(
      builder: (BuildContext context, BookingCreate3State state) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              '${workplace.typeName}: ${workplace.id}. ${workplace.capacity} мест',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            tileColor: !workplace.isFree ? Colors.grey.shade400 : null,
            onTap: () {
              !workplace.isFree
                  ? showDialog(
                      context: context,
                      builder: (BuildContext _) {
                        return FreeTimePicker(
                          placeId: workplace.id,
                          date: dateTimeStart!,
                          bookingBloc: context.read<BookingCreate3Bloc>(),
                          workplace: workplace,
                        );
                      })
                  : workplace.typeName == 'Одиночное место'
                      ? showDialog(
                          context: context,
                          builder: (BuildContext _) {
                            final TextStyle textStyle = Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontWeight: FontWeight.w500);
                            return AlertDialog(
                              title: Center(
                                child: Text(
                                  'Место ${workplace.id}',
                                  style: textStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              content: SizedBox(
                                height: 50.h,
                                child: Text(
                                  'Вы уверены, что хотите выбрать это место?',
                                  style: textStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              actions: <Widget>[
                                MaterialButton(
                                  onPressed: () {
                                    context
                                        .read<BookingCreate3Bloc>()
                                        .add(BookingCreate3WorkplaceSelected(
                                            booking: BookingModel(
                                          id: -1,
                                          holder: context
                                              .read<BookingCreate3Bloc>()
                                              .holdersId[0],
                                          maker: context
                                              .read<BookingCreate3Bloc>()
                                              .makerId,
                                          workplace: workplace.id,
                                          start: DateTime(
                                              dateTimeStart!.year,
                                              dateTimeStart!.month,
                                              dateTimeStart!.day,
                                              dateTimeStart!.hour,
                                              dateTimeEnd!.minute),
                                          end: DateTime(
                                              dateTimeEnd!.year,
                                              dateTimeEnd!.month,
                                              dateTimeEnd!.day,
                                              dateTimeEnd!.hour,
                                              dateTimeEnd!.minute),
                                          guests: 0,
                                        )));
                                  },
                                  child: Text('Да',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                ),
                                MaterialButton(
                                  onPressed: () {},
                                  child: Text('Нет',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                ),
                              ],
                            );
                          })
                      : showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            final TextStyle textStyle = Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontWeight: FontWeight.w500);
                            return AlertDialog(
                              title: Center(
                                child: Text(
                                  'Переговорка ${workplace.id}',
                                  style: textStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              content: SizedBox(
                                height: 50.h,
                                child: TextFormField(
                                  controller: guests,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  decoration: const InputDecoration(
                                      labelText: 'Количество гостей',
                                      prefixIcon: Icon(
                                        Icons.group_add,
                                        color: Colors.deepOrange,
                                      )),
                                ),
                              ),
                              actions: <Widget>[
                                MaterialButton(
                                  onPressed: () {
                                    context
                                        .read<BookingCreate3Bloc>()
                                        .add(BookingCreate3WorkplaceSelected(
                                            booking: BookingModel(
                                          id: -1,
                                          holder: context
                                              .read<BookingCreate3Bloc>()
                                              .holdersId[0],
                                          maker: context
                                              .read<BookingCreate3Bloc>()
                                              .makerId,
                                          workplace: workplace.id,
                                          start: DateTime(
                                              dateTimeStart!.year,
                                              dateTimeStart!.month,
                                              dateTimeStart!.day,
                                              dateTimeStart!.hour,
                                              dateTimeEnd!.minute),
                                          end: DateTime(
                                              dateTimeEnd!.year,
                                              dateTimeEnd!.month,
                                              dateTimeEnd!.day,
                                              dateTimeEnd!.hour,
                                              dateTimeEnd!.minute),
                                          guests: int.parse(guests.text),
                                        )));
                                  },
                                  child: Text('Подтвердить',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                ),
                                MaterialButton(
                                  onPressed: () {},
                                  child: Text('Отмена',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                ),
                              ],
                            );
                          });
            },
            trailing: IconButton(
              onPressed: () {
                context.read<BookingCreate3Bloc>().add(
                    BookingCreate3FavoriteChanged(
                        workplaceId: workplace.id,
                        isFavorite: !(context.read<BookingCreate3Bloc>().state
                                as BookingCreate3FloorLoaded)
                            .favorites
                            .contains(workplace)));
              },
              icon: (context.read<BookingCreate3Bloc>().state
                          as BookingCreate3FloorLoaded)
                      .favorites
                      .contains(workplace)
                  ? const Icon(
                      Icons.star,
                      color: MyColors.kSecondary,
                    )
                  : const Icon(Icons.star_border),
            ),

          ),
        );
      },
    );
  }
}
