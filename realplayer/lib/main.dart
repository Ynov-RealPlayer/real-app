import 'package:flutter/material.dart';
import 'package:realplayer/navigator.dart';
import 'package:realplayer/view/Home.view.dart';
import 'package:realplayer/view/OnBoarding.view.dart';
import 'package:realplayer/view/Profile.View.dart';
import 'package:realplayer/view/login.View.dart';
import 'view/Register.view.dart';
import 'view/UploadPost.view.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isLoggedIn = await AuthService.isLoggedIn(); // Vérifiez si l'utilisateur est déjà connecté
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const MainNavigator() : const OnBoardingView(),
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
