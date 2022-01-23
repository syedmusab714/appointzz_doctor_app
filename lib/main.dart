import 'dart:async';

import 'package:doctor_appointzz/Views/Login/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Services/internet.dart';

void main() {
  runApp(const DoctorAppointzz());
}

class DoctorAppointzz extends StatelessWidget {
  const DoctorAppointzz({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final InternetChecker _internetChecker = InternetChecker();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => const Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(7, 78, 99, 0.8),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it in the middle of the parent.

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assests/logo.png',
              color: const Color.fromRGBO(231, 232, 225, 1),
              // color: Colors.black,
              scale: 1.7,
            ),
            const Text(
              'A One Click Hospital',
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(231, 232, 225, 1),
                letterSpacing: 1.0,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
