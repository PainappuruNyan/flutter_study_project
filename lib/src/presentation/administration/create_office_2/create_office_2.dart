import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/office_create_2/office_create_2_bloc.dart';
import '../../../domain/entities/office.dart';
import '../../shared_widgets/bottom_app_bar.dart';
import '../create_office_3/create_office_3.dart';
import 'widgets/floor_expandable.dart';

class CreateOffice2 extends StatefulWidget {
  const CreateOffice2(
      {super.key, required this.floorCount, required this.nOffice, required this.officeId});

  final int floorCount;
  final Office? nOffice;
  final int officeId;

  @override
  State<CreateOffice2> createState() => _CreateOffice2State();
}

class _CreateOffice2State extends State<CreateOffice2> {

  void nextRoute(int officeId) {
    Navigator.of(context).push(MaterialPageRoute<CreateOffice2>(
        builder: (_) =>
            CreateOffice3(
              officeId: officeId,
            )));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.nOffice);
    return BlocProvider<OfficeCreate2Bloc>(
      create: (BuildContext context) =>
      OfficeCreate2Bloc(officeId: widget.officeId)
        ..add(EnterFloorCount(floorCount: widget.floorCount)),
      child: BlocBuilder<OfficeCreate2Bloc, OfficeCreate2State>(
        builder: (BuildContext context, OfficeCreate2State state) {
          return Scaffold(
            appBar: AppBar(
                title: const Text(
                  'Новый офис',
                )),
            bottomNavigationBar: BlocListener<OfficeCreate2Bloc, OfficeCreate2State>(
              listener: (BuildContext context, OfficeCreate2State state) {
                if(state is FloorsLoaded){
                  nextRoute(widget.officeId);
                }
              },
              child: CustomBottomAppBar(
                pageCount: '3',
                pageNum: '2',
                dateValid: true,
                nextRoute: () {
                  if (state is FloorEntered) {
                    context.read<OfficeCreate2Bloc>().add(ConfirmCreation());
                  }
                },
                nextPageButton: true,
              ),
            ),
            body: Builder(
              builder: (BuildContext context) {
                if (state is FloorEntered) {
                  return SingleChildScrollView(
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding:
                                EdgeInsets.only(top: 31.h, bottom: 45.h),
                                child: Text(
                                  'Введите информацию об этажах',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              ListView.builder(
                                  reverse: true,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: widget.floorCount,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return FloorExpandable(
                                      floor: state.floorList[index],
                                      floorIndex: index,
                                    );
                                  }),
                            ],
                          )));
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
