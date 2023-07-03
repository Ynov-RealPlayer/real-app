import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realplayer/themes/color.dart';

class BoutiqueView extends StatelessWidget {
  const BoutiqueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.backgroundColor,
      body: Center(
        child: Text(
          'La page boutique est en cours de developpement',
          style: GoogleFonts.unicaOne(fontSize: 29, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
