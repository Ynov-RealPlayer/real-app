import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realplayer/services/auth_service.dart';
import 'package:realplayer/services/media_service.dart';
import 'package:realplayer/themes/color.dart';
import 'package:realplayer/view/Boutique.View.dart';
import 'package:realplayer/view/CoinShop.View.dart';
import 'package:realplayer/view/Media.view.dart';
import 'package:realplayer/view/Profile.View.dart';
import 'package:http/http.dart' as http;
import 'package:realplayer/services/category_service.dart';
import 'package:realplayer/view/components/AppBar.view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentSliderIndex = 0;
  List<dynamic> _categories = [];
  late Future<List<dynamic>> _data;
  int _currentIndex = 0;
  int? _selectedCategoryId;
  String? _selectedCategoryName;

  Future<void> _fetchCategories() async {
    _categories = await CategoryService.fetchCategories();
    if (_categories.isNotEmpty) {
      setState(() {
        _data = fetchMediaCategData(_categories[_currentIndex]['id']);
      });
    }
  }

  Future<List<dynamic>> fetchMediaCategData(int categoryId) async {
    try {
      if (_categories.isNotEmpty) {
        final mediaCategData =
            await MediaService.getMediaByCategorie(categoryId);
        final mediaList = mediaCategData;
        return mediaList;
      } else {
        return [];
      }
    } catch (e) {
      print('Erreur lors de la récupération du categmédia: $e');
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _data = _categories.isNotEmpty
        ? fetchMediaCategData(_categories[_currentIndex]['id'])
        : Future.value([]);
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
                    // print(category);
                    return GestureDetector(
                      onTap: () {
                        if (_categories.isNotEmpty) {
                          setState(() {
                            _selectedCategoryId = category['id'];
                            _selectedCategoryName = category['name'];
                            _currentSliderIndex = index;
                            _currentIndex = index;
                            _data = fetchMediaCategData(
                                _categories[_currentIndex]['id']);
                          });
                        }
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
                  child: FutureBuilder<List<dynamic>>(
                    future: _data,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final mediaList = snapshot.data!;
                        // print(mediaList);
                        return GridView.builder(
                          itemCount: mediaList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) {
                            final mediaItem = mediaList[index];
                            final imageUrl = mediaItem['url'];
                            // print(mediaItem);
                            // print(imageUrl);
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MediaPage(
                                      postId: mediaItem['id'],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 10.0,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
        ],
      ),
    );
  }
}
