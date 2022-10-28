import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingDetailScreen extends StatelessWidget {
  const BookingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
              systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.deepOrange),
              leading: const Icon(Icons.arrow_back_ios_new),
              backgroundColor: Colors.deepOrange,
              title: Center(
                  child: Container(
                      padding: const EdgeInsets.only(right: 40),
                      child: const Text(
                        'Детали брони',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Roboto',
                        ),
                      )))),
          body: Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Column(
              children: [
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
                      'Бронь 00000001',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 30, left: 10),
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
                                    ),
                                    text: 'Этаж: ',
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '2',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Colors.black,
                                          )),
                                    ]),
                              ),
                              Text(
                                'id0000001',
                                style: TextStyle(
                                    fontFamily: 'Inter', color: Colors.grey),
                              )
                            ],
                          )),
                      Container(
                          width: 300,
                          padding: const EdgeInsets.only(left: 10, top: 10),

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
                                ),
                                text: 'Место: ',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'id00000001',
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                ]),
                          )),
                      Container(
                          width: 300,
                          padding: const EdgeInsets.only(left: 10, top: 10),

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
                                ),
                                text: 'Офис: ',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Окатовая 12',
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                ]),
                          )),
                      Container(
                          width: 300,
                          padding: const EdgeInsets.only(left: 10, top: 10),

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
                                ),
                                text: 'Город: ',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Владивосток',
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                ]),
                          )),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        //
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 0.5,
                                ))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 103,
                              child: Column(
                                children: const [
                                  Text(
                                    'Дата начала:',
                                    style: TextStyle(
                                        color: Colors.deepOrange, fontSize: 16),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    '01.01.2022 (пн)',
                                    style: TextStyle(fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 153,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    'Дата окончания:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  SizedBox(
                                    width: 125,
                                    child: Text(
                                      '01.01.2022 (пн)',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        //
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 0.5,
                                ))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 115,
                              child: Column(
                                children: const [
                                  Text(
                                    'Время начала:',
                                    style: TextStyle(
                                        color: Colors.deepOrange, fontSize: 16),
                                  ),
                                  SizedBox(height: 6),
                                  SizedBox(
                                    width: 110,
                                    child: Text(
                                      '11:00',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 142,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    'Время окончания:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  SizedBox(
                                    width: 136,
                                    child: Text(
                                      '17:00',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
                      child: const Text('Удалить бронь',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              color: Colors.white)),
                    )),
                Container(
                    padding: const EdgeInsets.only(top: 15),
                    width: 286,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 9.5),
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                            color: Colors.deepOrange, width: 2),
                      ),
                      child: const Text('Скопировать адрес',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              color: Colors.deepOrange)),
                    )),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepOrange,
            onPressed: () {},
            child: const Icon(
              Icons.edit,
            ),
          ),
        ));
  }
}
