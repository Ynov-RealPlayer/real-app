import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realplayer/themes/color.dart';
import 'package:badges/badges.dart' as badges;

class appBarHome extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(80);

  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorTheme.backgroundColor,
      elevation: 0,
      actions: [
        IconButton(
          iconSize: 35,
          onPressed: () {
            Navigator.pushNamed(context, '/RatingPage');
          },
          icon: SvgPicture.asset(
            "assets/icons/rating.svg",
          ),
          color: Colors.white,
        ),
        Stack(
          children: [
            IconButton(
              iconSize: 40,
              onPressed: () {
                Navigator.pushNamed(context, '/NotifPage');
              },
              icon: SvgPicture.asset(
                "assets/icons/notif.svg",
              ),
              color: Colors.white,
            ),
            const Positioned(
              top: 1,
              left: 29,
              child: badges.Badge(
                badgeContent: Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 6.0),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Recherche',
                    hintStyle: GoogleFonts.unicaOne(
                      color: Colors.grey,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: ColorTheme.buttonColor.withOpacity(0.8),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search,
                        color: Colors.grey, size: 28.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
