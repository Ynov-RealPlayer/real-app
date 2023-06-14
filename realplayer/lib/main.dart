import 'package:flutter/material.dart';
import 'package:realplayer/view/OnBoarding.view.dart';
import 'register.dart';
import 'login.dart';
import 'post.dart';
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
      home: const OnBoardingView(),
      routes: {
        '/UploadPost': (context) => UploadPost(),
        '/RegisterPage': (context) => RegisterPage(),
        '/LoginPage': (context) => LoginPage(),
        '/PostPage': (context) => PostPage(postId: 22),
      },
    );
  }

}
