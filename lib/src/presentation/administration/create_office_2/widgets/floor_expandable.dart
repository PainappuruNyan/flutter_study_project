import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../bloc/office_create_2/office_create_2_bloc.dart';
import '../../../../core/constants/colors.dart';

class FloorExpandable extends StatelessWidget {
  FloorExpandable({super.key, required this.floor, required this.floorIndex});

  MiniFloor floor;
  int floorIndex;
  TextEditingController floorNumberController = TextEditingController();
  TextEditingController workplaceCounterController = TextEditingController();
  TextEditingController meetingCounterController = TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {
    if (context.read<OfficeCreate2Bloc>().state is FloorEntered) {
      floorNumberController.text = floor.floorNumber.toString();
      workplaceCounterController.text = floor.workplaceCount.toString();
      meetingCounterController.text = floor.meetingRoomCount.toString();
      return ExpansionTile(
        title: Text(
          'Этаж ${floor.floorNumber.toString()}',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: MyColors.kPrimaryText),
        ),
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: meetingCounterController,
                        decoration: const InputDecoration(label: Text('Переговорок')),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Flexible(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: workplaceCounterController,
                        decoration: const InputDecoration(label: Text('Рабочих мест')),
                      ),
                    ),
                  ],
                ),

                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: floorNumberController,
                  decoration: const InputDecoration(label: Text('Номер этажа')),
                ),
                MaterialButton(
                  onPressed: (){
                    final MiniFloor newFloor = MiniFloor(floorNumber: int.parse(floorNumberController.text));
                    newFloor.meetingRoomCount = int.parse(meetingCounterController.text);
                    newFloor.workplaceCount = int.parse(workplaceCounterController.text);
                    context.read<OfficeCreate2Bloc>().add(ChangeOneFloor(floorIndex: floorIndex, floorInstance: newFloor));

                  },
                  minWidth: 264.w,
                  height: 37.h,
                  color: MyColors.kPrimary,
                  textColor: MyColors.kPrimary,
                  child: Text(
                    'Сохранить этаж',
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }
    return const Center(child: Text('Что-то не так'),);
  }
}
