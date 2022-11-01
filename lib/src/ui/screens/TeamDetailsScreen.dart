import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.deepOrange),
          leading: const Icon(Icons.arrow_back_ios_new),
          backgroundColor: Colors.deepOrange,
          title: Center(
              child: Container(
                  padding: const EdgeInsets.only(right: 40),
                  child: const Text(
                    'Детали команды',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                    ),
                  )))),
      body: Center(
          child: Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 35, bottom: 40),
          height: 35,
          width: 227,
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 5),
            child: const Text(
              'Название команды',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Inter', fontSize: 20),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 30),
          decoration: const BoxDecoration(
              border: Border(
                  left: BorderSide(
            color: Colors.deepOrange,
            width: 1.2,
          ))),
          child: Column(
            children: [
              Container(
                  width: 300,
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1,
                  ))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text.rich(
                        TextSpan(
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontFamily: 'Inter',
                              fontSize: 18,
                            ),
                            text: 'Лидер: ',
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Какое-то имя',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.black,
                                    fontSize: 18,
                                  )),
                            ]),
                      ),
                      Text(
                        'id0000001',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.grey,
                            fontSize: 12),
                      )
                    ],
                  )),
              Container(
                  width: 300,
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey.shade400,
                    width: 0.5,
                  ))),
                  child: const Text.rich(
                    TextSpan(
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 18,
                        ),
                        text: 'Id: ',
                        children: <TextSpan>[
                          TextSpan(
                              text: 'id00000001',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              )),
                        ]),
                  )),
              SizedBox(
                height: 14,
              )
            ],
          ),
        ),
        Container(
            padding: const EdgeInsets.only(top: 54),
            width: 286,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 9.5),
                backgroundColor: Colors.deepOrange,
              ),
              child: const Text('Забронировать на команду',
                  style: TextStyle(
                      fontSize: 16, fontFamily: 'Inter', color: Colors.white)),
            )),
        Container(
            padding: const EdgeInsets.only(top: 10),
            width: 286,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 9.5),
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.deepOrange, width: 2),
              ),
              child: const Text('Выйти из команды',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      color: Colors.deepOrange)),
            )),
        Container(
            padding: const EdgeInsets.only(top: 10),
            width: 286,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 9.5),
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.deepOrange, width: 2),
              ),
              child: const Text('Удалить команду',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      color: Colors.deepOrange)),
            ))
      ])),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {},
        child: const Icon(
          Icons.edit,
        ),
      ),
    );
  }
}
