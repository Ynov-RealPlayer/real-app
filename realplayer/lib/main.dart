import 'package:flutter/material.dart';
import 'package:realplayer/view/Home.view.dart';
import 'package:realplayer/view/OnBoarding.view.dart';
import 'register.dart';
import 'login.dart';
import 'upload_post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/UploadPost': (context) => UploadPost(),
        '/RegisterPage': (context) => RegisterPage(),
        '/LoginPage': (context) => LoginPage(),
        '/HomePage': (context) => const HomePage(),
      },
    );
  }
}
