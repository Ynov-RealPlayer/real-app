import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realplayer/services/auth_service.dart';
import 'package:realplayer/services/profile_service.dart';
import 'package:realplayer/services/user_service.dart';
import 'package:realplayer/themes/color.dart';
import 'package:realplayer/view/login.View.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

void main() {
  runApp(MaterialApp(home: ProfileOtherUserView(idUser: 3)));
}

class ProfileOtherUserView extends StatefulWidget {
  final int idUser;
  ProfileOtherUserView({required this.idUser});

  @override
  State<ProfileOtherUserView> createState() => _ProfileOtherUserViewState();
}

class _ProfileOtherUserViewState extends State<ProfileOtherUserView> {
  final userService = UserService();
  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = _fetchOtherUserData();
  }

  void _navigateToHome() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/MainNavigator', (Route<dynamic> route) => false);
  }

  Future<Map<String, dynamic>> _fetchOtherUserData() async {
    final userData = await userService.fetchOtherUserData(widget.idUser);
    print('object : ' + userData.toString());
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
          final String description = userData['description'] ?? '';
          final String picture = userData['picture'];
          final String banner = userData['banner'];
          final int experience = userData['experience'];
          final int colorR = userData['bar_colors'][0];
          final int colorG = userData['bar_colors'][1];
          final int colorB = userData['bar_colors'][2];
          final double percent = userData['xp_progress'];
          final String rank = userData['rank']['name'];
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
                          image: CachedNetworkImageProvider(banner),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: banner,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
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
                            _navigateToHome();
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
                  left: 16,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: picture,
                              width: 128,
                              height: 128,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            "@$pseudo",
                            style: GoogleFonts.unicaOne(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "XP : $experience",
                            style: GoogleFonts.unicaOne(
                              fontSize: 15,
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
                                rank,
                                style: GoogleFonts.unicaOne(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.18,
                              ),
                              Text(
                                (percent*100).toString() + "%",
                                style: GoogleFonts.unicaOne(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.18,
                              ),
                            ],
                          ),
                          SimpleAnimationProgressBar(
                            height: 10,
                            width: 230,
                            backgroundColor: Colors.grey.shade800,
                            foregrondColor: ColorTheme.progresshBarColor,
                            ratio: percent,
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
                  left: 16,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 32,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.unicaOne(
                              fontSize: 18,
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
                    height: 5,
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
                            mediaCount.toString(),
                            style: GoogleFonts.unicaOne(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Medias",
                            style: GoogleFonts.unicaOne(
                              fontSize: 20,
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
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Comments",
                            style: GoogleFonts.unicaOne(
                              fontSize: 20,
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
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Likes",
                            style: GoogleFonts.unicaOne(
                              fontSize: 20,
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
                          onPressed: () {},
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
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
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
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            height: 5,
                            width: 120,
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
                      padding: EdgeInsets.all(16),
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
            strokeWidth: 2,
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
      padding: const EdgeInsets.all(2),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            width: 150,
            height: 150,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.comment, color: Colors.white),
              Text(
                comments.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 5),
              Icon(
                has_liked ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              SizedBox(width: 4),
              Text(
                likes.toString(),
                style: TextStyle(
                  fontSize: 14,
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
