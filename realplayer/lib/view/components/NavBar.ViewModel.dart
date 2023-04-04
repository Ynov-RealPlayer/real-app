import 'package:flutter/material.dart';

class NavBarViewModel extends ChangeNotifier {
  int currentIndex = 1;

  void onTabTapped(int index) {
    currentIndex = index;
    notifyListeners();
  }
}