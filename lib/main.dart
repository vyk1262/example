import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'teachable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.microphone.request();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String score = '';
  String score2 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Audio New Classifier")),
        body: Stack(
          children: [
            Container(
                child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  child: Teachable(
                    path: "assets/index.html",
                    results: (res) {
                      var resp = jsonDecode(res);
                      setState(() {
                        score = (resp['Background Noise'] * 100.0).toString();
                        score2 = (resp['CLUTCH BELL'] * 100.0).toString();
                      });
                    },
                  ),
                ),
              ),
            ])),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Background noise",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            score,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "CLUTCH BELL",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            score2,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            )
          ],
        ));
  }
}
