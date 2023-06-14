import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realplayer/services/profile_service.dart';
import 'package:realplayer/themes/color.dart';
import 'package:realplayer/view/Home.view.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final profileService = ProfileService();
  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = _fetchUserData();
  }

  Future<Map<String, dynamic>> _fetchUserData() async {
    final userData = await profileService.fetchUserData();
    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _userData,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final userData = snapshot.data!;
          final String pseudo = userData['pseudo'];
          final String description = userData['description'];
          final String picture = userData['picture'];
          final String banner = userData['banner'];
          final int experience = userData['experience'];
          final List<dynamic> medias = userData['medias'];
          final int mediaCount = medias.length;
          int totalComments = 0;
          int totalLikes = 0;
          medias.forEach((media) {
            totalComments += (media['nb_comments'] as num).toInt();
          });
          medias.forEach((media) {
            totalLikes += (media['nb_likes'] as num).toInt();
          });
          return Scaffold(
            backgroundColor: ColorTheme.backgroundColor,
            body: Stack(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(banner),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      left: 10,
                      child: Container(
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
                    ),
                    Positioned(
                      top: 70,
                      left: 360,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorTheme.buttonColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.mode_edit,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
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
                            child: Image.network(
                              picture,
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
                            "@$pseudo",
                            style: GoogleFonts.unicaOne(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "XP : $experience",
                            style: GoogleFonts.unicaOne(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: const [
                          //     Icon(Icons.home, color: Colors.white),
                          //     Icon(Icons.search, color: Colors.white),
                          //     Icon(Icons.notifications, color: Colors.white),
                          //     Icon(Icons.person, color: Colors.white),
                          //   ],
                          // ),
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
                  child: Container(
                    width: MediaQuery.of(context).size.width - 32.0,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.unicaOne(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 400,
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
                        //  medias.map((media) {
                        children: [
                          Text(
                            mediaCount.toString(),
                            style: GoogleFonts.unicaOne(
                              fontSize: 24.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            "Medias",
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
                            "$totalComments",
                            style: GoogleFonts.unicaOne(
                              fontSize: 24.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            "Comments",
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
                            "$totalLikes",
                            style: GoogleFonts.unicaOne(
                              fontSize: 24.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            "Likes",
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
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
                      children: medias.map((media) {
                        return PostItem(
                          imageUrl: media['url'].toString(),
                          comments: media['nb_comments'],
                          likes: media['nb_likes'],
                          has_liked: media['has_liked'],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 1),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Failed to load user data');
        }
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            color: ColorTheme.buttonColor,
          ),
        );
      },
    );
  }
}

class PostItem extends StatelessWidget {
  final String imageUrl;
  final int comments;
  final int likes;
  final bool has_liked;

  const PostItem({
    required this.imageUrl,
    required this.comments,
    required this.likes,
    required this.has_liked,
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
              Icon(
                has_liked ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
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
