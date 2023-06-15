import 'package:flutter/material.dart';
import 'package:realplayer/themes/color.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.backgroundColor,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.07),
          Center(
            child: Text(
              'Classement',
              style: GoogleFonts.unicaOne(
                color: Colors.white,
                fontSize: 50.0,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.005), // adjust this for desired spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Icon(Icons.arrow_downward, color: Colors.red, size: 24.0),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 92,
                            height: 92,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: ColorTheme.buttonColor),
                            ),
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQapqOHUZA27CC1e-G6zv7aFoUL1LSCcKjaMw&usqp=CAU"),
                            radius: 45,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'The second',
                        style: GoogleFonts.unicaOne(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 30,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "2",
                        style: GoogleFonts.unicaOne(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 24.0),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 124,
                            height: 124,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: ColorTheme.buttonColor),
                            ),
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQapqOHUZA27CC1e-G6zv7aFoUL1LSCcKjaMw&usqp=CAU"),
                            radius: 60,
                          ),
                        ],
                      ),
                      SizedBox(height: 20), // increase this to give more space for the number
                      Text(
                        'The boss',
                        style: GoogleFonts.unicaOne(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                  Positioned(
                    top: 135,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "1",
                        style: GoogleFonts.unicaOne(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Icon(Icons.arrow_upward, color: Colors.green, size: 24.0),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 92,
                            height: 92,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: ColorTheme.buttonColor),
                            ),
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQapqOHUZA27CC1e-G6zv7aFoUL1LSCcKjaMw&usqp=CAU"),
                            radius: 45,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'The second',
                        style: GoogleFonts.unicaOne(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 30,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "2",
                        style: GoogleFonts.unicaOne(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
