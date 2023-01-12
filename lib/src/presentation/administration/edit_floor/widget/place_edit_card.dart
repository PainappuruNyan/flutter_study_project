import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../domain/entities/workplace.dart';

class PlaceEditCard extends StatefulWidget {
  const PlaceEditCard({super.key, required this.place, this.onDelete, this.onSave});

  final Workplace place;
  final dynamic onDelete;
  final dynamic onSave;


  @override
  State<PlaceEditCard> createState() => _PlaceEditCardState();
}

class _PlaceEditCardState extends State<PlaceEditCard> {
  TextEditingController capacityInput = TextEditingController();
  TextEditingController nameInput = TextEditingController();

  @override
  void initState() {
    capacityInput.text = widget.place.capacity.toString();
    nameInput.text = widget.place.placeName!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300.w, maxHeight: 200.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Место ${widget.place.placeName}'),
                  TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: nameInput,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 18.sp),
                    decoration: InputDecoration(
                      label: const Text('Номер'),
                        constraints: BoxConstraints(maxWidth: 62.w)),
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: capacityInput,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 18.sp),
                    decoration: InputDecoration(
                        label: const Text('Вместимость'),
                        constraints: BoxConstraints(maxWidth: 62.w)),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      widget.onDelete(widget.place.id);
                    },
                    color: MyColors.kPrimary,
                    height: 30.h,
                    child: Text(
                      'Удалить',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      widget.onSave(widget.place.id, int.parse(capacityInput.text), nameInput.text);
                    },
                    color: MyColors.kPrimary,
                    height: 30.h,
                    child: Text(
                      'Сохранить',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
