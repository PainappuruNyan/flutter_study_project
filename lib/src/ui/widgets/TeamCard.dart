import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TeamCard extends StatelessWidget {
  String teamName = '';
  String userName = '';
  String userTeamRole = '';

  TeamCard(String teamName, String userName, String userTeamRole) {
    this.teamName = teamName;
    this.userName = userName;
    this.userTeamRole = userTeamRole;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 14.5, right: 14.5),
      child: Column(
        children: <Widget>[
          Container(
              height: 135,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 9, bottom: 6),
                        child: Text(
                          teamName,
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 24,
                              color: Colors.deepOrange),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(bottom: 11),
                        child: Text(
                          userName,
                          style: const TextStyle(
                              fontFamily: 'Roboto', fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 117),
                      height: 58,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4)),
                        color: Colors.deepOrange,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            height: 37,
                            width: 130,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Colors.white,
                            ),
                            child: Text(
                              userTeamRole,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ))
        ],
      ),
    );
  }
}
