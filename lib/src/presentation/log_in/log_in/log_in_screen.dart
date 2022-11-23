import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../profile/profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController login = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: MyColors.kWhite,
      resizeToAvoidBottomInset: false,
      body:
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(50.0.sp),
              child: Column(
                children: <Widget> [
                  Container(
                    padding: EdgeInsets.only(top: 46.sp),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  <Widget> [
                        const Image(image: AssetImage('assets/images/image 8.png')),
                        Container(
                            margin: EdgeInsets.only(left: 14.0.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  <Widget> [
                                Text('АТБ', style: TextStyle(
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.bold
                                ),),
                                Text('ТЕРРИТОРИЯ', style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 120),
                    child: TextFormField(
                      controller: login,
                      cursorColor: MyColors.kPrimary,
                      style: const TextStyle(fontSize: 14, fontFamily: 'Robot'),
                      decoration: const InputDecoration(
                          floatingLabelStyle: TextStyle(color: MyColors.kTextSecondary),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: MyColors.kPrimary
                              )
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: MyColors.kPrimary
                              )
                          ),
                          labelText: 'Логин',
                          prefixIcon: Icon(Icons.local_post_office_outlined, color: MyColors.kTextSecondary,)
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: password,
                      cursorColor: MyColors.kPrimary,
                      style: const TextStyle(fontSize: 14, fontFamily: 'Robot'),
                      obscureText: true,
                      decoration: const InputDecoration(
                          floatingLabelStyle: TextStyle(color: MyColors.kTextSecondary),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: MyColors.kPrimary
                              )
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: MyColors.kPrimary
                              )
                          ),
                          labelText: 'Пароль',
                          prefixIcon: Icon(Icons.lock_outline, color: MyColors.kTextSecondary,)
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 50.0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (BuildContext context) => ProfileScreen(login: login.text,),
                        ));
                      },
                      minWidth: 250,
                      height: 40,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      ),
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                      child:
                      const Text('Войти',
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 30.0),
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 250.w,
                      height: 40.h,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: MyColors.kPrimary,width: 2.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textColor: MyColors.kPrimary,
                      child: const Text('Регистрация',
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
