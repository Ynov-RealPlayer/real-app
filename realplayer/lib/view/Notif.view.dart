import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../themes/color.dart';

class NotifPage extends StatelessWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.backgroundColor,
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 400)),
            Center(
              child: Text(
                'La page Notif est en cours de développement',
                style: GoogleFonts.unicaOne(fontSize: 30, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorTheme.buttonColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/arrow_back.svg",
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
