import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realplayer/themes/color.dart';
import 'package:realplayer/upload_post.dart';
import 'package:realplayer/view/Boutique.View.dart';
import 'package:realplayer/view/CoinShop.View.dart';
import 'package:realplayer/view/Home.view.dart';
import 'package:realplayer/view/Profile.View.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  List<Widget> _screens = [
    HomePage(),
    CoinShopView(),
    UploadPost(),
    BoutiqueView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(height: 120, color: ColorTheme.backgroundColor),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: CustomNavigationBar(
              isFloating: true,
              borderRadius: Radius.circular(10),
              selectedColor: Colors.white,
              unSelectedColor: Colors.grey[600],
              backgroundColor: ColorTheme.buttonColor,
              scaleFactor: 0.1,
              iconSize: 40,
              items: [
                CustomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/home.svg'),
                ),
                CustomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/bitcoin.svg'),
                ),
                CustomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/camera.svg'),
                ),
                CustomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/shopping-cart.svg'),
                ),
                CustomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/account.svg'),
                ),
              ],
              onTap: (i) {
                setState(() {
                  _selectedIndex = i;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
