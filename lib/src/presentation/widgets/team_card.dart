import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class TeamCard extends StatelessWidget {

  TeamCard(this.teamName, this.userName, this.userTeamRole, {super.key});
  String teamName = '';
  String userName = '';
  String userTeamRole = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 14.5, right: 14.5),
      child: Column(
        children: <Widget>[
          Container(
              height: 135,
              decoration: BoxDecoration(
                boxShadow: const <BoxShadow> [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 9, bottom: 6),
                        child: Text(
                          teamName,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(bottom: 11),
                        child: Text(
                          userName,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    ],
                  ),
                  Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 117),
                      height: 58,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4)),
                        color: MyColors.kSecondary,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            height: 37,
                            width: 130,
                            decoration: BoxDecoration(
                                border: Border.all(color: MyColors.kWhite, width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              color: MyColors.kSecondary,
                            ),
                            child: Text(
                              userTeamRole,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                        ],
                      )),
                ],
              ))
        ],
      ),
    );
  }
}
