import 'package:flutter/material.dart';
import 'package:realplayer/navigator.dart';
import 'package:realplayer/view/Home.view.dart';
import 'package:realplayer/view/OnBoarding.view.dart';
import 'package:realplayer/view/Profile.View.dart';
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
      // home: const MainNavigator(),
      home: const ProfileView(),
      // home: LoginPage(),
      routes: {
        '/UploadPost': (context) => UploadPost(),
        '/RegisterPage': (context) => RegisterPage(),
        '/LoginPage': (context) => LoginPage(),
        '/PostPage': (context) => PostPage(postId: 22),
      },
    );
  }

}
