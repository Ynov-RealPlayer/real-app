import 'package:flutter/material.dart';
import 'package:realplayer/navigator.dart';
import 'package:realplayer/view/Home.view.dart';
import 'package:realplayer/view/OnBoarding.view.dart';
import 'package:realplayer/view/Profile.View.dart';
import 'package:realplayer/view/login.View.dart';
import 'view/Register.view.dart';
import 'view/UploadPost.view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OnBoardingView(),
      routes: {
        '/UploadPost': (context) => UploadPost(),
        '/RegisterPage': (context) => RegisterPage(),
        '/LoginPage': (context) => LoginPage(),
        '/HomePage': (context) => const HomePage(),
        '/ProfilePage': (context) => ProfileView(),
        '/MainNavigator': (context) => const MainNavigator(),
      },
    );
  }

}
