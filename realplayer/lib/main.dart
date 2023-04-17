import 'package:flutter/material.dart';
import 'package:realplayer/view/OnBoarding.view.dart';
import 'register.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnBoardingView(),
      routes: {
        '/RegisterPage': (context) => RegisterPage(),
        '/LoginPage': (context) => LoginPage(),
      },
    );
  }
}
