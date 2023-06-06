import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realplayer/services/auth_service.dart';
import 'package:realplayer/services/media_service.dart';
import 'package:realplayer/themes/color.dart';
import 'package:realplayer/view/Boutique.View.dart';
import 'package:realplayer/view/CoinShop.View.dart';
import 'package:realplayer/view/Profile.View.dart';
import 'components/NavBar.View.dart';
import 'package:http/http.dart' as http;
import 'package:realplayer/services/category_service.dart';
import 'package:realplayer/view/AppBar.view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentSliderIndex = 0;
  List<dynamic> _categories = [];
  late Future<Map<String, dynamic>> _data;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _data = fetchMediaCategData();
  }

  Future<void> _fetchCategories() async {
    _categories = await CategoryService.fetchCategories();
    setState(() {});
  }

  Future<Map<String, dynamic>> fetchMediaCategData() async {
    try {
      final mediaCategData = await MediaService.getMediaByCategorie(2);
      return mediaCategData;
    } catch (e) {
      print('Erreur lors de la récupération du categmédia: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: ColorTheme.backgroundColor,
                height: 70.0,
                padding: const EdgeInsets.only(
                    left: 7.0, right: 2.0, top: 3.0, bottom: 12.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    final category = _categories[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentSliderIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: _currentSliderIndex == index
                              ? ColorTheme.buttonColor
                              : ColorTheme.buttonColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          children: [
                            Text(
                              category['symbol'],
                              style: TextStyle(fontSize: 25.0),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              category['name'],
                              style: GoogleFonts.unicaOne(
                                color: _currentSliderIndex == index
                                    ? Colors.white
                                    : Colors.grey,
                                fontSize: 25.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: ColorTheme.backgroundColor,
                  height: MediaQuery.of(context).size.height - 200,
                  child: FutureBuilder<Map<String, dynamic>>(
                    future: _data,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final mediaCategData = snapshot.data!;
                        final mediaList = mediaCategData['url'];
                        return GridView.builder(
                          itemCount: mediaList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              child: Image.network(
                                mediaList,
                                fit: BoxFit.cover,
                                width: 100.0,
                                height: 100.0,
                                colorBlendMode: BlendMode.darken,
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Erreur lors de la récupération des données',
                            style: GoogleFonts.unicaOne(
                              color: Colors.white,
                              fontSize: 22.0,
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: ColorTheme.buttonColor,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 120,
              color: ColorTheme.backgroundColor,
              child: CustomNavigationBar(
                isFloating: true,
                borderRadius: Radius.circular(10),
                selectedColor: Colors.white,
                unSelectedColor: Colors.grey[600],
                backgroundColor: ColorTheme.buttonColor,
                scaleFactor: 0.1,
                iconSize: 40,
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: [
                  CustomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/home.svg'),
                  ),
                  CustomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/bitcoin.svg'),
                  ),
                  CustomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/camera.svg'),
                  ),
                  CustomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/account.svg'),
                  ),
                  CustomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/shopping-cart.svg'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
