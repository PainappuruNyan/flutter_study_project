import 'package:atb_first_project/dependency_injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bloc/admin_office_list/admin_office_list_bloc.dart';
import '../../routes/routes.dart';
import '../../shared_widgets/navigation_drawer.dart';
import '../office_details/office_details.dart';
import 'widget/simple_office_widget.dart';

class OfficeListScreen extends StatefulWidget {
  const OfficeListScreen({Key? key}) : super(key: key);

  static const String routeName = 'admin_office_list';

  @override
  State<OfficeListScreen> createState() => _OfficeListScreenState();
}

class _OfficeListScreenState extends State<OfficeListScreen> {
  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs = di.sl();
    int id = prefs.getInt('id')!;
    return BlocProvider<AdminOfficeListBloc>(
      create: (BuildContext context) => AdminOfficeListBloc(id)..add(AdminOfficeListStart()),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {Navigator.pushNamed(context, Routes.create_office_1).then((value) => context.read<AdminOfficeListBloc>().add(AdminOfficeListStart()));},
            child: const Icon(Icons.add),
          ),
        drawer: const NavigationDrawer(),
        appBar: AppBar(
            title: const Text(
          'Ваши офисы',
        )),
        body: BlocBuilder<AdminOfficeListBloc, AdminOfficeListState>(
          builder: (BuildContext context, AdminOfficeListState state) {
            if (state is OfficeListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is OfficeListLoaded) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20.w),
                child: Column(
                  children: <Widget>[
                    Text('Выбирете офис', style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w500),),
                    if(state.offices.isNotEmpty)...<Widget>[
                      Expanded(
                        child: ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.offices.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          OfficeDetailsScreen(
                                            office: state.offices[index],)));
                                },
                                  child: SimpleOffice(office: state.offices[index]));
                            }),
                      ),
                    ]
                    else ...<Widget>[
                      const Center(child: Text('У вас нет администрируемых офисов'),)
                    ],

                  ],
                ),
              );
            }
            return const Center(
              child: Text('Что-то пошло не так'),
            );
          },
        ),
      ),
    );
  }
}
