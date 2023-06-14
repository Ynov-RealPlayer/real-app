import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Form(
            key: _formKey,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff1d2b34),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 180,
                    child: Container(
                      width: 319,
                      height: 480,
                      child: Stack(
                        children: [
                          Positioned(
                            child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 319,
                                height: 469,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(27),
                                    color: Color(0xff1d2b34),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 420,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.center,
                              child: FractionallySizedBox(
                                widthFactor: 0.8,
                                child: SizedBox(
                                  height: 52,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (_emailController.text.isEmpty ||
                                          _passwordController.text.isEmpty) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text('Erreur'),
                                            content: Text(
                                                'Il faut rentrer un email et un mot de passe'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        if (_formKey.currentState!.validate()) {

                                          try {
                                            await AuthService.login(
                                                _emailController.text,
                                                _passwordController.text);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      "Bravo, vous êtes connecté !")),
                                            );
                                            print(await AuthService.getToken());
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Erreur de connexion, vérifiez vos identifiants"),
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    },
                                    child: Text(
                                      'se connecter',
                                      style: GoogleFonts.unicaOne(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                    color: Color(0xff0272cd),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 380,
                    child: SizedBox(
                      width: 255,
                      height: 52,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/mail.svg',
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: GoogleFonts.unicaOne(
                                  fontSize: 18,
                                  color: Color(0x99ffffff),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff0272cd), width: 3),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff0272cd), width: 3),
                                ),
                              ),
                              style: GoogleFonts.unicaOne(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 450,
                    child: SizedBox(
                      width: 255,
                      height: 52,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/password.svg',
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Mot de passe',
                                hintStyle: GoogleFonts.unicaOne(
                                  fontSize: 18,
                                  color: Color(0x99ffffff),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff0272cd), width: 3),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff0272cd), width: 3),
                                ),
                              ),
                              style: GoogleFonts.unicaOne(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 670,
                    child: RichText(
                      text: TextSpan(
                        text: "vous n'avez pas de compte ? ",
                        style: GoogleFonts.unicaOne(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "s'inscrire",
                            style: GoogleFonts.unicaOne(
                              color: Colors.blue,
                              fontSize: 16.0,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/RegisterPage');
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 200,
                    child: Text(
                      'CONNEXION',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.unicaOne(
                        fontSize: 64,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
