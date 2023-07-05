import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/color.dart';

class BoutiquePage extends StatefulWidget {
  const BoutiquePage({Key? key}) : super(key: key);

  @override
  _BoutiquePageState createState() => _BoutiquePageState();
}
class _BoutiquePageState extends State<BoutiquePage> {
  List<String> boutiqueItems = [
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=10',
    'https://picsum.photos/250?image=11',
    'https://picsum.photos/250?image=12',
    'https://picsum.photos/250?image=13',
    'https://picsum.photos/250?image=14',
    'https://picsum.photos/250?image=15',
    'https://picsum.photos/250?image=16',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'Boutique',
          style: GoogleFonts.unicaOne(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: ColorTheme.backgroundColor,
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 2,
          crossAxisSpacing: 15,
          crossAxisCount: 2,
          childAspectRatio: 0.70,
        ),
        itemCount: boutiqueItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
            },
            child: Stack(
              children: [
              Positioned(
              top: 0,
              left: 10,
              right: 10,
              bottom: 70,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorTheme.cardColor.withOpacity(0.2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      boutiqueItems[index],
                      width: 150.0,
                      height: 150.0,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Titre de l\'élément',
                      style: GoogleFonts.unicaOne(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              right: 60,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                ),
                primary: ColorTheme.buttonColor,
              ),
              child: Text(
                '10 Exp',
                style: GoogleFonts.unicaOne(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          ],
          ),
          );
        },
      ),
    );
  }
}
