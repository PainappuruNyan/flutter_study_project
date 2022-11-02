import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/navigation_drawer.dart' as NavigationDrawer;

class TeamCreateScreen extends StatelessWidget {
  const TeamCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarColor: Colors.deepOrange),
        backgroundColor: Colors.deepOrange,
        title: const Center(child: Text('Создание команды')),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 19.5),
            child: const Icon(Icons.search_rounded),
          )
        ],
      ),
      drawer: const NavigationDrawer.NavigationDrawer(),
      body: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                    left: 36.5, right: 36.5, top: 70, bottom: 35),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepOrange,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepOrange,
                        ),
                      ),
                      labelText: 'Название команды',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      prefixIcon: Icon(
                        Icons.group,
                        color: Colors.deepOrange,
                      )),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 36.5, right: 36.5),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepOrange,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepOrange,
                        ),
                      ),
                      labelText: 'Телефон лидера',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.deepOrange,
                      )),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 76),
                width: 286,
                child: MaterialButton(
                  onPressed: () {},
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  elevation: 5.0,
                  minWidth: 200.0,
                  height: 35,
                  color: Colors.deepOrange,
                  child: const Text('Создать команду',
                      style:
                      TextStyle(fontSize: 16.0, color: Colors.white)),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 29, right: 15),
                width: 286,
                child: TextButton.icon(
                  // <-- TextButton
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                    size: 24.0,
                    color: Colors.deepOrange,
                  ),
                  label: const Text(
                    'Отмена',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
