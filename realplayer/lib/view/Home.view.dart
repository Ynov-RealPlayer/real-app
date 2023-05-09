import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realplayer/services/auth_service.dart';
import 'package:realplayer/themes/color.dart';
import 'components/NavBar.View.dart';
import 'package:http/http.dart' as http;
import 'package:realplayer/services/category_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentSliderIndex = 0;
  List<dynamic> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    _categories = await CategoryService.fetchCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/rating.svg",
            ),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/notif.svg",
            ),
            color: Colors.white,
          ),
        ],
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
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
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: ColorTheme.backgroundColor,
            height: 70.0,
            padding: const EdgeInsets.only(left: 10.0, right: 8.0, top: 15.0),
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
                          style: TextStyle(fontSize: 22.0),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          category['name'],
                          style: GoogleFonts.unicaOne(
                            color: _currentSliderIndex == index
                                ? Colors.white
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Expanded(
            child: NavBar(),
          ),
        ],
      ),
    );
  }
}

