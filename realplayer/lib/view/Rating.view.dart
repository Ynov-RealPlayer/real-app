import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realplayer/services/user_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realplayer/themes/color.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingPage extends StatefulWidget {
  const RatingPage();

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  late Future<List<dynamic>> _usersTopData;

  Future<List<dynamic>> fetchUsersTop100() async {
    try {
      final UserTop100 = await UserService.getTop100();
      return UserTop100;
    } catch (e) {
      print('Erreur lors de la récupération du categmédia: $e');
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _usersTopData = fetchUsersTop100();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.backgroundColor,
      body: FutureBuilder<List<dynamic>>(
          future: _usersTopData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No data found'));
            }

            List<dynamic> users = snapshot.data!;
            return Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                Stack(
                  children: [
                    Center(
                      child: Text(
                        'Classement',
                        style: GoogleFonts.unicaOne(
                          color: Colors.white,
                          fontSize: 50.0,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 15,
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
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/MainNavigator',
                                (Route<dynamic> route) => false);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 92,
                                  height: 92,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: ColorTheme.buttonColor),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      users[1]["picture"].toString()),
                                  radius: 45,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              users[1]["pseudo"].toString(),
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
                            Icon(Icons.emoji_events,
                                color: Colors.yellow, size: 45),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 124,
                                  height: 124,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: ColorTheme.buttonColor),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      users[0]["picture"].toString()),
                                  radius: 60,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              users[0]["pseudo"].toString(),
                              style: GoogleFonts.unicaOne(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 40),
                          ],
                        ),
                        Positioned(
                          top: 155,
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
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 92,
                                  height: 92,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: ColorTheme.buttonColor),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      users[2]["picture"].toString()),
                                  radius: 45,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              users[2]["pseudo"].toString(),
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
                              "3",
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length - 3,
                    itemBuilder: (context, index) {
                      index += 3;
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                              users[index]["picture"].toString()),
                        ),
                        title: Text(
                          users[index]["pseudo"].toString(),
                          style: GoogleFonts.unicaOne(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        trailing: Text(
                          users[index]["experience"].toString() + " xp",
                          style: GoogleFonts.unicaOne(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}
