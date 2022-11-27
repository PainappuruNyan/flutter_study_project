import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_decoration/icon_decoration.dart';

import '../../bloc/booking_create_3/booking_create3_bloc.dart';
import '../../core/constants/colors.dart';
import '../../data/models/booking_model.dart';
import '../../domain/entities/workplace.dart';

class WorkplaceCard extends StatelessWidget {
  const WorkplaceCard({super.key, required this.workplace});

  final Workplace workplace;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        child: ListTile(
          title: Text(
            'id${workplace.id}',
            style:
            Theme.of(context).textTheme.subtitle2,
          ),
          tileColor: workplace.isFree! ? Colors.grey.shade400 : null,
          onTap: () {
            context.read<BookingCreate3Bloc>().add(BookingCreate3WorkplaceSelected(booking: BookingModel(id: -1, holder: 1, maker: -1, workplace: workplace.id, start: DateTime(2022, 11, 27, 10), end: DateTime(2022, 11, 27, 20), guests: 0,)));
          },
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
  }
}
