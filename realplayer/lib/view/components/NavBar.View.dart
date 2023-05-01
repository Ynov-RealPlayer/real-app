import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:realplayer/themes/color.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: ColorTheme.backgroundColor,
      bottomNavigationBar: SafeArea(child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
          color: ColorTheme.buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              // icon: const Icon(Icons.home, size: 40),
              icon: SvgPicture.asset(
                  "assets/icons/home.svg",
                ),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                  "assets/icons/bitcoin.svg",
                ),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                  "assets/icons/camera.svg",
                ),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                  "assets/icons/shopping-cart.svg",
                ),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                  "assets/icons/account.svg",
                ),
              color: Colors.white,
            ),
          ],
        )
        ),
      ),
      );
  }
}
