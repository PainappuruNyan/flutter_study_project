import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/office_create_2/office_create_2_bloc.dart';
import '../../profile/profile_screen.dart';
import '../../shared_widgets/bottom_app_bar.dart';
import 'widgets/floor_accordion.dart';

class CreateOffice3 extends StatefulWidget {
  const CreateOffice3({super.key, required this.floors});

  final List<MiniFloor> floors;

  @override
  State<CreateOffice3> createState() => _CreateOffice3State();
}

class _CreateOffice3State extends State<CreateOffice3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Новый офис',
          )),
      body: SingleChildScrollView(
        primary: true,
        physics: const ScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 30.w, vertical: 28.h),
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.floors.length,
              itemBuilder: (BuildContext context, int index) {
                return FloorAccordion(
                  floor: widget.floors[index],
                );
              }),
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(
        dateValid: true,
        nextRoute: ProfileScreen(),
        pageCount: '3',
        pageNum: '3',
        nextPageButton: true,
      ),
    );
  }
}
