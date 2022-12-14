import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/office_create_2/office_create_2_bloc.dart';
import 'widgets/floor_expandable.dart';

class CreateOffice2 extends StatefulWidget {
  const CreateOffice2({super.key, required this.floorCount});

  final int floorCount;

  @override
  State<CreateOffice2> createState() => _CreateOffice2State();
}

class _CreateOffice2State extends State<CreateOffice2> {
  TextEditingController floorCountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OfficeCreate2Bloc()..add(EnterFloorCount(floorCount: widget.floorCount)),
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
          'Новый офис',
        )),
        body: BlocBuilder<OfficeCreate2Bloc, OfficeCreate2State>(
          builder: (BuildContext context, OfficeCreate2State state) {
            return SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: widget.floorCount,
                        itemBuilder: (BuildContext context, int index) {
                          return FloorExpandable(
                            floor: (state as FloorEntered).floorList[index],
                            floorIndex: index,
                          );
                        })));
          },
        ),
      ),
    );
  }
}
