import 'dart:convert';
import 'dart:io';

import 'package:atb_first_project/src/presentation/administration/edit_floor/widget/place_edit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bloc/edit_floor/edit_floor_bloc.dart';
import '../../../core/constants/colors.dart';
import 'package:atb_first_project/dependency_injection_container.dart' as di;

class EditFloor extends StatefulWidget {
  const EditFloor(
      {super.key, required this.floorId, required this.workplaceType});

  final int floorId;
  final int workplaceType;

  @override
  State<EditFloor> createState() => _EditFloorState();
}

class _EditFloorState extends State<EditFloor> {
  @override
  Widget build(BuildContext context) {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    return BlocProvider<EditFloorBloc>(
      create: (BuildContext context) => EditFloorBloc(
        floorId: widget.floorId,
        workplaceType: widget.workplaceType,
      )..add(EditFloorStart(
          floorId: widget.floorId, workplaceType: widget.workplaceType)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Редактирование'),
        ),
        body: BlocBuilder<EditFloorBloc, EditFloorState>(
          builder: (BuildContext context, EditFloorState state) {
            if (state is EditFloorLoaded) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 2,
                    child: SizedBox(
                        width: 360.w,
                        height: 325.h,
                        child: ClipRect(
                          child: PhotoView(
                            backgroundDecoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            imageProvider: state.floor.mapFloor != null
                                ? NetworkImage(
                                    'http://10.0.2.2:8080/image/${state.floor.mapFloor}',
                                    headers: <String, String>{
                                        HttpHeaders.authorizationHeader:
                                            'Basic ${base64.encode(utf8.encode('$username:$password'))}'
                                      })
                                : const AssetImage(
                                        'assets/images/Default_image.png')
                                    as ImageProvider,
                          ),
                        )),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey),
                              bottom: BorderSide(color: Colors.grey))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Этаж №${state.floor.floorNumber}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600),
                          ),
                          MaterialButton(
                            color: MyColors.kPrimary,
                            onPressed: () {
                              context.read<EditFloorBloc>().add(
                                  EditFloorPlaceCreate(
                                      floorId: widget.floorId, capacity: 1));
                            },
                            child: Text(
                              'Добавить место',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      child: ListView.builder(
                        primary: true,
                        itemCount: state.places.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              alignment: Alignment.center,
                              child: PlaceEditCard(
                                place: state.places[index],
                                onSave: (int placeId, int nCapacity,
                                    String? nName) {
                                  context
                                      .read<EditFloorBloc>()
                                      .add(EditFloorPlaceChanged(
                                        workplaceId: placeId,
                                        nCapacity: nCapacity,
                                        nName: nName,
                                      ));
                                },
                                onDelete: (int placeId) {
                                  context.read<EditFloorBloc>().add(
                                      EditFloorPlaceDelete(
                                          workplaceId: placeId));
                                },
                              ));
                        },
                      ),
                    ),
                  ),
                  MaterialButton(
                    color: MyColors.kPrimary,
                    onPressed: () {},
                    child: Text(
                      'Закончить',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              );
            }
            if (state is EditFloorLoading || state is EditFloorInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const Center(
              child: Text('Возникла ошибка'),
            );
          },
        ),
      ),
    );
  }
}
