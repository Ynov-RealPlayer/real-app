import 'package:flutter/material.dart';
import 'package:realplayer/navigator.dart';
import 'package:realplayer/services/profile_service.dart';
import 'package:realplayer/view/Home.view.dart';
import 'package:realplayer/view/OnBoarding.view.dart';
import 'package:realplayer/view/Profile.View.dart';
import 'package:realplayer/view/ProfileEdit.View.dart';
import 'package:realplayer/view/Rating.view.dart';
import 'package:realplayer/view/login.View.dart';
import 'view/Register.view.dart';
import 'view/UploadPost.view.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isLoggedIn = await AuthService.isLoggedIn();
  final userData = await ProfileService()
      .fetchUserData(); // Récupère les données utilisateur à l'aide du service ProfileService
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
        '/HomePage': (context) => HomePage(),
        '/ProfilePage': (context) => ProfileView(),
        '/MainNavigator': (context) => MainNavigator(),
        '/ProfileEdit': (context) =>
            ProfileEdit(userData: Future.value(userData)),
        '/RatingPage': (context) => RatingPage(),
      },
    );
  }
}
