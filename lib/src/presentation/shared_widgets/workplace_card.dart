import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_decoration/icon_decoration.dart';

import '../../bloc/booking_create_3/booking_create3_bloc.dart';
import '../../core/constants/colors.dart';
import '../../data/models/booking_model.dart';
import '../../domain/entities/workplace.dart';

class WorkplaceCard extends StatelessWidget {
  const WorkplaceCard(
      {super.key,
      required this.workplace,
      required this.onApprove,
      this.dateTimeStart,
      this.dateTimeEnd});

  final BookingCreate3Bloc onApprove;
  final Workplace workplace;
  final DateTime? dateTimeStart;
  final DateTime? dateTimeEnd;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        child: ListTile(
          title: Text(
            'id${workplace.id}',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          tileColor: !workplace.isFree ? Colors.grey.shade400 : null,
          onTap: () {
            !workplace.isFree? null
                : workplace.typeName == 'Одиночное место'
                    ? showDialog(
                        context: context,
                        builder: (BuildContext context) {
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
                                  onApprove.add(BookingCreate3WorkplaceSelected(
                                      booking: BookingModel(
                                        id: -1,
                                        holder: 1,
                                        maker: -1,
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
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                              ),
                              MaterialButton(
                                onPressed: () {},
                                child: Text('Нет',
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
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
                                  onApprove.add(BookingCreate3WorkplaceSelected(
                                      booking: BookingModel(
                                    id: -1,
                                    holder: 1,
                                    maker: -1,
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
                                child: Text('Подтвердить',
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                              ),
                              MaterialButton(
                                onPressed: () {},
                                child: Text('Отмена',
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                              ),
                            ],
                          );
                        });
          },
          trailing: const DecoratedIcon(
            icon: Icon(Icons.star, color: MyColors.kSecondary),
            decoration: IconDecoration(
                border: IconBorder(color: MyColors.kPrimaryText, width: 2)),
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
  }
}
