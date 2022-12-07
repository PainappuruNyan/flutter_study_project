import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../bloc/team_create/team_create_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/team_model.dart';
import '../../shared_widgets/navigation_drawer.dart' as NavigationDrawer;
import '../team_list/team_list_screen.dart';

class TeamCreateScreen extends StatelessWidget {
  TeamCreateScreen({super.key});

  TextEditingController teamName = TextEditingController();

  static const String routeName = '/team_create_screen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TeamCreateBloc>(
      create: (BuildContext context) =>
          TeamCreateBloc()..add(TeamCreateStart()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Создание команды'),
        ),
        drawer: const NavigationDrawer.NavigationDrawer(),
        body: BlocConsumer<TeamCreateBloc, TeamCreateState>(
          listener: (BuildContext context, TeamCreateState state) {
            if (state is TeamCreateSuccess) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const TeamListScreen(),
                  ));
            }
          },
          builder: (BuildContext context, TeamCreateState state) {
            if (state is TeamCreateLoading) {
              const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TeamCreateLoaded) {
              return SingleChildScrollView(
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(
                            left: 36.5.sp,
                            right: 36.5.sp,
                            top: 70.sp,
                            bottom: 35.sp),
                        child: TextFormField(
                          controller: teamName,
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.bodyText2,
                          decoration: const InputDecoration(
                              labelText: 'Название команды',
                              prefixIcon: Icon(
                                Icons.group,
                                color: MyColors.kPrimary,
                              )),
                        )),
                    Container(
                      padding: EdgeInsets.only(left: 36.5.sp, right: 36.5.sp),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: const InputDecoration(
                            labelText: 'Телефон лидера',
                            prefixIcon: Icon(
                              Icons.phone,
                              color: MyColors.kPrimary,
                            )),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 76.sp),
                      width: 286.w,
                      child: MaterialButton(
                        onPressed: () {
                          context.read<TeamCreateBloc>().add(
                              TeamCreateInfoSelected(
                                  team: TeamModel(
                                      id: -1,
                                      leaderId: 1,
                                      name: teamName.text)));
                        },
                        color: MyColors.kPrimary,
                        child: const Text('Принять',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30.sp, right: 15.sp),
                      width: 286.w,
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 24.0,
                          color: MyColors.kPrimary,
                        ),
                        label: const Text(
                          'Отмена',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: MyColors.kPrimary,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              );
            }
            return const Center(
              child: Text('Ошибка'),
            );
          },
        ),
      ),
    );
  }
}
