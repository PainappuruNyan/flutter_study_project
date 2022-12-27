import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../shared_widgets/navigation_drawer.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  static const String routeName = '/faq';

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  String path = 'assets/files/faq.pdf';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const Text('FAQ'),
        ),
        body: Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        path = 'assets/files/faq.pdf';
                      });
                    },
                    height: 35,
                    child: const Text('Новый сотрудник'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          path = 'assets/files/winRemote.pdf';
                        });
                      },
                      height: 35,
                      child: const Text('Удаленка Win'),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        path = 'assets/files/macRemote.pdf';
                      });
                    },
                    height: 35,
                    child: const Text('Удаленка Mac'),
                  )
                ],
              ),
            ),
            Expanded(child: SfPdfViewer.asset(path))
          ],
        ));
  }
}
