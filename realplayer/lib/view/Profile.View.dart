import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realplayer/themes/color.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.backgroundColor,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: 16.0,
            child: Row(
              children: [
                Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/profil_image.jpg',
                        width: 128,
                        height: 128,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50.0,
                    ),
                    Text(
                      '@irksome_beets_81',
                      style: GoogleFonts.unicaOne(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(Icons.home, color: Colors.white),
                        Icon(Icons.search, color: Colors.white),
                        Icon(Icons.notifications, color: Colors.white),
                        Icon(Icons.person, color: Colors.white),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    Row(
                      children: [
                        Text(
                          "Silver",
                          style: GoogleFonts.unicaOne(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.18,
                        ),
                        Text(
                          "50%",
                          style: GoogleFonts.unicaOne(
                            fontSize: 13.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.18,
                        ),
                        Text(
                          "Gold",
                          style: GoogleFonts.unicaOne(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SimpleAnimationProgressBar(
                      height: 10,
                      width: 250,
                      backgroundColor: Colors.grey.shade800,
                      foregrondColor: ColorTheme.progresshBarColor,
                      ratio: 0.5,
                      direction: Axis.horizontal,
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: const Duration(seconds: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.36,
            left: 16.0,
            child: Text(
              "ON est mal payé, mais qu’est ce qu’on rigole...",
              style: GoogleFonts.unicaOne(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 380,
            left: 160,
            right: 160,
            child: Container(
              height: 5.0,
              color: Colors.blue,
            ),
          ),
          Positioned(
            top: 430,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "123",
                      style: GoogleFonts.unicaOne(
                        fontSize: 24.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Following",
                      style: GoogleFonts.unicaOne(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "1OM",
                      style: GoogleFonts.unicaOne(
                        fontSize: 24.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "likes",
                      style: GoogleFonts.unicaOne(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "145",
                      style: GoogleFonts.unicaOne(
                        fontSize: 24.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Videos",
                      style: GoogleFonts.unicaOne(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 540,
            left: 100,
            right: 0,
            child: Center(
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Button click logic
                    },
                    style: ElevatedButton.styleFrom(
                      primary: ColorTheme.buttonColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Following",
                      style: GoogleFonts.unicaOne(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SvgPicture.asset("assets/icons/iconForbidden.svg"),
                ],
              ),
            ),
          ),
          Positioned(
              top: 640,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Lasted posts",
                      style: GoogleFonts.unicaOne(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      height: 5.0,
                      width: 120.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              )),
          Positioned(
            top: 670,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: GridView.count(
                crossAxisCount: 2,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(16.0),
                children: [
                  PostItem(
                    imageUrl: 'https://picsum.photos/250?image=9',
                    comments: 12,
                    likes: 10,
                  ),
                  PostItem(
                    imageUrl: 'https://picsum.photos/250?image=10',
                    comments: 15,
                    likes: 5,
                  ),
                  PostItem(
                    imageUrl: 'https://picsum.photos/250?image=11',
                    comments: 20,
                    likes: 2,
                  ),
                  PostItem(
                    imageUrl: 'https://picsum.photos/250?image=12',
                    comments: 2,
                    likes: 8,
                  ),
                  PostItem(
                    imageUrl: 'https://picsum.photos/250?image=13',
                    comments: 21,
                    likes: 3,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 1),
          ),
        ],
      ),
    );
  }
}

// class PostItem extends StatelessWidget {
//   final String imageUrl;
//   final String name;
//   final int likes;

//   const PostItem({
//     Key? key,
//     required this.imageUrl,
//     required this.name,
//     required this.likes,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: ColorTheme.buttonColor,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(
//                 imageUrl,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               name,
//               style: GoogleFonts.unicaOne(
//                 fontSize: 20.0,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.favorite,
//                   color: Colors.red,
//                 ),
//                 SizedBox(width: 5),
//                 Text(
//                   likes.toString(),
//                   style: GoogleFonts.unicaOne(
//                     fontSize: 20.0,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class PostItem extends StatelessWidget {
  final String imageUrl;
  final int comments;
  final int likes;

  const PostItem({
    required this.imageUrl,
    required this.comments,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: 150,
            height: 150,
          ),
          // SizedBox(height: 1.0),
          // SizedBox(height: 1.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.comment, color: Colors.white),
              Text(
                comments.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 5.0),
              Icon(Icons.favorite, color: Colors.red),
              SizedBox(width: 4.0),
              Text(
                likes.toString(),
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
