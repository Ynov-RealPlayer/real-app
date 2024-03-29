import 'package:flutter/material.dart';
import 'package:realplayer/navigator.dart';
import 'package:realplayer/services/profile_service.dart';
import 'package:realplayer/view/Boutique.View.dart';
import 'package:realplayer/view/Home.view.dart';
import 'package:realplayer/view/Notif.view.dart';
import 'package:realplayer/view/OnBoarding.view.dart';
import 'package:realplayer/view/Profile.View.dart';
import 'package:realplayer/view/ProfileEdit.View.dart';
import 'package:realplayer/view/Rating.view.dart';
import 'package:realplayer/view/login.View.dart';
import 'view/Register.view.dart';
import 'view/UploadPost.view.dart';
import 'services/auth_service.dart';

void main() async {
  Map<String, dynamic> userData = {};
  WidgetsFlutterBinding.ensureInitialized();
  final isLoggedIn = await AuthService.isLoggedIn();
  if (isLoggedIn == true) {
    userData = await ProfileService().fetchUserData();
  }
  runApp(MyApp(isLoggedIn: isLoggedIn, userData: userData));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final Map<String, dynamic> userData;

  MyApp({required this.isLoggedIn, required this.userData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? MainNavigator() : OnBoardingView(),
      routes: {
        '/UploadPost': (context) => UploadPost(),
        '/RegisterPage': (context) => RegisterPage(),
        '/LoginPage': (context) => LoginPage(),
        '/HomePage': (context) => const HomePage(),
        '/ProfilePage': (context) => ProfileView(),
        '/MainNavigator': (context) => const MainNavigator(),
        '/ProfileEdit': (context) =>
            ProfileEdit(userData: Future.value(userData)),
        '/RatingPage': (context) => const RatingPage(),
        '/NotifPage': (context) => const NotifPage(),
        '/BoutiquePage': (context) => const BoutiquePage(),
      },
    );
  }
}
