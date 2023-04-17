import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realplayer/themes/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realplayer/themes/string.dart';
import 'package:realplayer/view/Login.view.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late PageController _pageController;

  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }
  @override
void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.backgroundColor,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: demo_data.length,
                onPageChanged: (int index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 80, left: 10, right: 10),
                    child: Column(
                      children: [
                        Image.asset(
                          demo_data[i].image,
                          height: 300,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            demo_data.length,
                                (index) => buildDot(index, context),
                          ),
                        ),
                        const SizedBox(height: 45),
                        Text(
                          demo_data[i].title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.unicaOne(
                            fontSize: 35,
                            color: ColorTheme.textColor,
                          )
                        ),
                        const SizedBox(height: 20),
                        Text(
                          demo_data[i].description,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.unicaOne(
                            fontSize: 18,
                            color: ColorTheme.textColor,
                          )
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            Container(
              height: 60,
              margin: const EdgeInsets.all(40),
              width: double.infinity,
              child:IconButton(
                onPressed: () {
                  if (_pageIndex == demo_data.length - 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginView(),
                      ),
                    );
                  }
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease,
                  );
                },
                icon: SvgPicture.asset(
                  "assets/icons/arrow.svg",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: _pageIndex == index ? 20 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class OnBoard  {
 final String image, title, description;

  OnBoard({required this.image, required this.title, required this.description});
}

final List<OnBoard> demo_data = [
  OnBoard(
    image: "assets/images/logo-real.png",
    title: "Bienvenue sur ${StringConstants.appName}",
    description: "Le but de cette application est de créer une plateforme pour les gamers afin qu’ils puissent partager leurs expériences "
        "de jeu sous la forme de screens ou de clips. Nous cherchons "
        "à offrir une expérience personnalisée pour chaque utilisateur, en fonction de leur préférence et de leurs jeux.",
  ),
  OnBoard(
    image: 'assets/images/logo-real.png',
    title: "Description de l'application",
    description: "L'application ${StringConstants.appName} consiste à partager des screenshots ou des clips de vos meilleurs moments de jeux. "
        "Vous pouvez également suivre vos amis et ainsi voir leurs meilleurs moments de jeux.",
  ),
  OnBoard(
    image: 'assets/images/logo-real.png',
    title: "A vos partages",
    description: "Vous pouvez des à présent vous connecter pour profiter de toutes les fonctionnalités de l'application et ainsi postez vos meilleurs gameplay ! Bon jeux à toutes et à tous !",
  ),
];


class OnBoardContent extends StatelessWidget {
  const OnBoardContent({
    super.key, required this.image, required this.title, required this.description,
  });

  final String image, title, description;
  @override
  Widget build(BuildContext context) {
    return Column (
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Image.asset(image, height: 300),
        Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: ColorTheme.textColor)),
        const SizedBox(height: 16),
        Text(description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, color: ColorTheme.textColor)),
        const Spacer(flex: 2),
      ],
    );
  }
}