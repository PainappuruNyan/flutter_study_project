import 'package:dartz/dartz.dart' as fun;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/colors.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../../data/datasources/remote_data_source.dart';
import '../../../data/repositories/employee_repository_impl.dart';
import '../../../domain/entities/employee.dart';
import '../../../domain/usecases/get_employee_by_id.dart';
import '../../routes/routes.dart';
import '../../widgets/booking_card.dart';
import '../../../core/constants/colors.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../../data/datasources/remote_data_source.dart';
import '../../../data/repositories/employee_repository_impl.dart';
import '../../../domain/entities/employee.dart';
import '../../../domain/usecases/get_employee_by_id.dart';
import '../../routes/routes.dart';
import '../../widgets/booking_card.dart';
import '../widgets/id_card.dart';
import '../../widgets/navigation_drawer.dart' as NavigationDrawer;
import '../widgets/user_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Employee employee = Employee(id: 0, name: 'name', login: 'login', password: 'password', role: 'role');
  late SharedPreferences sharedPreferences;


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColors.kPrimary,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      backgroundColor: MyColors.kFrameBackground,
      drawer:  const NavigationDrawer.NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: MyColors.kPrimary,
        elevation: 0,
        title: const Center(
          child: Text('Профиль сотрудника'),
        ),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 19.5),
            child: InkWell(
              onTap: () {},
              child: const Icon(Icons.search_rounded),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: MyColors.kPrimary,
        child: const Icon(Icons.chat_outlined),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.only(top: 14.h, left: 13.w, right: 13.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  <Widget>[
                  Flexible(
                    flex: 57,
                    child: UserCard(employee.name, 'roman_mal@empl.atb.ru'),
                  ),
                  Flexible(
                    flex: 43,
                    child: IdCard(employee.id, employee.role),
                  )
                ],
              ),
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: Container(
                padding: EdgeInsets.all(9.sp),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 122.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.only(top: 5.h, left: 4.w, right: 4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Ближайшее бронирование', style: Theme.of(context).textTheme.subtitle2,),
                            Image(image: AssetImage('assets/images/Union.png'))
                          ],
                        ),
                      ),
                      const BookingCard('Окатовая 12', 'Рабочее место', 1, 1),
                      Container(
                        margin: const EdgeInsets.only(top: 11),
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(color: Colors.grey))),
                        child: InkWell(
                          child: Text('Посмотреть полный список'),
                          onTap: (){Navigator.pushNamed(context, Routes.booking_list);},
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: Container(
                padding: EdgeInsets.all(9.sp),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 122.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 5.h, left: 6.w, right: 6.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Команды', style: Theme.of(context).textTheme.subtitle2,),
                            Image(image: AssetImage('assets/images/Union.png'))
                          ],
                        ),
                      ),
                      Text('Здесь пока пусто', style: Theme.of(context).textTheme.caption,),
                      Container(
                        margin: const EdgeInsets.only(top: 11),
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(color: Colors.grey))),
                        child:  InkWell(
                          child: Text('Посмотреть полный список'),
                          onTap: (){Navigator.pushNamed(context, Routes.team_list);},
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    setupResources();
  }

  void setupResources() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var repository = EmployeeRepositoryImpl(
        networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
        remoteDataSource: RemoteImplWithHttp(client: Client()),
        localDataSource: LocalDataSourceImpl(sharedPreferences: sharedPreferences));
    final Future<fun.Either<Failure, Employee>> answer = GetEmployeeById(repository).execute(id: 1);
    answer.then((value) {
      value.fold((Failure l) => null, (Employee r) {
        print(r);
        setState(() {
          employee = r;
        });
      }
      );

    });
  }
}
