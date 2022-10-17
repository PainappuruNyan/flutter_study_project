import 'package:atb_first_project/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:material_color_gen/material_color_gen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("АТБ \nТЕРРИТОРИЯ"),
              ],
            ),
            TextField(),
            TextField(),
            ElevatedButton(
                onPressed: null,
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(myColors.kPrimary)),
                child: Text("Войти")
            ),
            OutlinedButton(
                onPressed: (){},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 2.0, color: myColors.kPrimary),
                ),
                child: Text(
                    "Регистрация",
                  style: TextStyle(color: myColors.kPrimary),
                ))
          ],
        ),
      ),
      );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});
  final String? title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColors.kPrimary,
        title: Text(widget.title!!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Labadabadabdaaaaaa',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
