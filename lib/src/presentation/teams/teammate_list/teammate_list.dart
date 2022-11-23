import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared_widgets//teammate_card.dart';

class TeamMateList extends StatelessWidget {
  const TeamMateList({super.key});

  final String teamName = 'Drekk or kek';

  static const String routeName = '/teammate_list';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            title: const Text(
          'Список участников',
        )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30.sp, bottom: 20.sp),
                child: Text(
                  teamName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              TeammateCard('Mashiro Yuki', 'Developer', '01'),
              TeammateCard('Okada Kaori', 'Developer', '02'),
              TeammateCard('Watanabe Mayu', 'Developer', '03'),
              TeammateCard('Nakano Azusa', 'Developer', '04')
            ],
          ),
        ));
  }
}
