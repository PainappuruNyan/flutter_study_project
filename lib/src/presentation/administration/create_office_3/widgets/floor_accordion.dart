import 'dart:io';

import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../bloc/office_create_2/office_create_2_bloc.dart';
import '../../../../bloc/office_create_3/office_create_3_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../edit_floor/edit_floor.dart';

class FloorAccordion extends StatefulWidget {
  const FloorAccordion({super.key, required this.floor});

  final MiniFloor floor;

  @override
  FloorAccordionState createState() => FloorAccordionState();
}

class FloorAccordionState extends State<FloorAccordion> {
  Future<File?> _getFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final File imageFile = File(image.path);
      return imageFile;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Accordion(
        contentBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        disableScrolling: true,
        headerBorderRadius: 4,
        paddingListTop: 0,
        paddingListBottom: 0,
        contentBorderRadius: 4,
        contentBorderWidth: 0,
        children: <AccordionSection>[
          AccordionSection(
            contentBorderRadius: 4,
            headerBackgroundColor: MyColors.kPrimary,
            header: Text(
              '${widget.floor.floorNumber} Этаж',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
            contentHorizontalPadding: 20,
            contentBorderWidth: 1,
            content: Column(
              children: <Widget>[
                WorkplacesCard(
                  workplaceCount: widget.floor.workplaceCount,
                  type: true,
                  floorId: widget.floor.floorId!,
                ),
                WorkplacesCard(
                  workplaceCount: widget.floor.meetingRoomCount,
                  type: false,
                  floorId: widget.floor.floorId!,
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: MaterialButton(
                    onPressed: () async {
                      await _getFromGallery().then((File? value) {
                        if (value != null) {
                          context.read<OfficeCreate3Bloc>().add(LoadMap(
                              filePath: value.path,
                              floorId: widget.floor.floorId!));
                        }
                      });
                    },
                    minWidth: 112.w,
                    height: 30.h,
                    color: MyColors.kPrimary,
                    textColor: MyColors.kPrimary,
                    child: Text(
                      'Загрузить карту',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}

class WorkplacesCard extends StatelessWidget {
  const WorkplacesCard(
      {super.key,
      required this.workplaceCount,
      required this.type,
      required this.floorId});

  final bool type;
  final int workplaceCount;
  final int floorId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Container(
            padding:
                EdgeInsets.only(top: 4.h, bottom: 4.h, right: 4.w, left: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  type
                      ? 'Рабочие места : $workplaceCount'
                      : 'Переговорки : $workplaceCount',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                InkWell(
                  child: Ink(
                    decoration: const ShapeDecoration(
                        color: MyColors.kPrimary, shape: CircleBorder()),
                    child: const Icon(
                      Icons.list,
                      color: MyColors.kWhite,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => EditFloor(
                          floorId: floorId,
                          workplaceType: type ? 1 : 2,
                        ),
                      ),
                    ).then((dynamic value) {
                      context.read<OfficeCreate3Bloc>().add(LoadScreen());
                    });
                  },
                )
              ],
            )),
      ),
      onTap: () {},
    );
  }
}
