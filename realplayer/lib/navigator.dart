import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realplayer/themes/color.dart';
import 'package:realplayer/view/UploadPost.view.dart';
import 'package:realplayer/view/Boutique.View.dart';
import 'package:realplayer/view/CoinShop.View.dart';
import 'package:realplayer/view/Home.view.dart';
import 'package:realplayer/view/Profile.View.dart';
import 'package:badges/badges.dart' as badges;

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  final List<Widget> routes = [
    HomePage(),
    CoinShopView(),
    UploadPost(),
    BoutiqueView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: routes[_selectedIndex],
      bottomNavigationBar: _selectedIndex != 4
          ? Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 120,
                    color: ColorTheme.backgroundColor,
                  ),
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
                        icon:
                            SvgPicture.asset('assets/icons/shopping-cart.svg'),
                      ),
                      CustomNavigationBarItem(
                        icon: SvgPicture.asset('assets/icons/account.svg'),
                      ),
                    ],
                    onTap: (int index) {
                      if (index == 4) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileView()),
                        );
                      } else {
                        setState(() {
                          _selectedIndex = index;
                        });
                      }
                    },
                  ),
                ),
                Positioned(
                  top: 21,
                  right: 105,
                  child: badges.Badge(
                    badgeContent: Text(
                      '3',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          : null, // Ne pas afficher la bottomNavigationBar sur la page de profil
    );
  }
}
