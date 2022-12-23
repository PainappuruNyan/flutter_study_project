import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/office_create_3/office_create_3_bloc.dart';
import '../../profile/profile_screen.dart';
import '../../shared_widgets/bottom_app_bar.dart';
import 'widgets/floor_accordion.dart';

class CreateOffice3 extends StatefulWidget {
  const CreateOffice3({super.key, required this.officeId});

  final int officeId;

  @override
  State<CreateOffice3> createState() => _CreateOffice3State();
}

class _CreateOffice3State extends State<CreateOffice3> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OfficeCreate3Bloc>(
      create: (BuildContext context) => OfficeCreate3Bloc(widget.officeId)..add(LoadScreen()),
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
              'Новый офис',
            )),
        body: BlocBuilder<OfficeCreate3Bloc, OfficeCreate3State>(
          builder: (BuildContext context, OfficeCreate3State state) {

            if(state is ScreenLoaded){
              return SingleChildScrollView(
                primary: true,
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 28.h),
                      child: Text('Этажи вашего офиса', style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 28.h),
                      child: ListView.builder(
                        reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.floors.length,
                          itemBuilder: (BuildContext context, int index) {
                            return FloorAccordion(
                              floor: state.floors[index],
                            );
                          }),
                    ),
                  ],
                ),
              );
            }
            if(state is OfficeCreate3Initial){
              return const Center(child: CircularProgressIndicator(),);
            }
            return const Center(child: Text('Возникла ошибка'));


          },
        ),
        bottomNavigationBar: const CustomBottomAppBar(
          dateValid: true,
          nextRoute: ProfileScreen(),
          pageCount: '3',
          pageNum: '3',
          nextPageButton: true,
        ),
      ),
    );
  }
}
