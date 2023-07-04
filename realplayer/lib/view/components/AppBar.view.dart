import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realplayer/services/user_service.dart';
import 'package:realplayer/themes/color.dart';
import 'package:badges/badges.dart' as badges;

class appBarHome extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(160); // Change height here

  @override
  _appBarHomeState createState() => _appBarHomeState();
}

class _appBarHomeState extends State<appBarHome> {
  final _userService = UserService();
  bool _isSearchBarEmpty = true;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _userService.searchUser(_searchController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _userService.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isSearchBarEmpty = _searchController.text.isEmpty;
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
              onPressed: () {},
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
          padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
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
              Expanded(
                child: StreamBuilder<List<dynamic>>(
                  stream: _userService.searchResults,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty && _searchController.text.isNotEmpty) {
                      return ListView.separated(
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (BuildContext context, int index) => Divider(height: 1, color: Colors.grey),
                        itemBuilder: (context, index) {
                          final user = snapshot.data![index];
                          return ListTile(
                            leading: Image.network(user['picture']),
                            title: Text(
                              user['pseudo'],
                              style: GoogleFonts.unicaOne(
                                color: ColorTheme.textColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onTap: () {
                              //Navigator.push(
                              //  context,
                              //  MaterialPageRoute(
                              // plus tard tartine
                              //  ),
                              //);
                            },
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}