import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:realplayer/view/Boutique.View.dart';
import 'package:realplayer/view/CoinShop.View.dart';
import 'package:realplayer/view/Home.view.dart';
import 'package:realplayer/view/Profile.View.dart';
import '../Post.View.dart';
import 'NavBar.ViewModel.dart';


import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomNavBar({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7), // Transparence de 70%
        borderRadius: BorderRadius.circular(20), // Bords arrondis de 20 pixels
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            color: selectedIndex == 0 ? Colors.blue : Colors.grey,
            onPressed: () => onTap(0),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: selectedIndex == 1 ? Colors.blue : Colors.grey,
            onPressed: () => onTap(1),
          ),
          IconButton(
            icon: const Icon(Icons.post_add),
            color: selectedIndex == 2 ? Colors.blue : Colors.grey,
            onPressed: () => onTap(2),
          ),
          IconButton(
            icon: const Icon(Icons.monetization_on),
            color: selectedIndex == 3 ? Colors.blue : Colors.grey,
            onPressed: () => onTap(3),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            color: selectedIndex == 4 ? Colors.blue : Colors.grey,
            onPressed: () => onTap(4),
          ),
        ],
      ),
    );
  }
}
