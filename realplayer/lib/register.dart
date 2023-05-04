import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pseudoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Clé pour valider le formulaire

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
              height: 932,
              decoration: BoxDecoration(
                color: Color(0xff1d2b34),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 260,
                    child: Container(
                      width: 319,
                      height: 480,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            child: Align(
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
                            top: 400,
                            child: Align(
                              child: SizedBox(
                                width: 255,
                                height: 52,
                                child: MaterialButton(
                                  onPressed: () async {
                                    if (_emailController.text.isEmpty ||
                                        _passwordController.text.isEmpty ||
                                        _pseudoController.text.isEmpty ||
                                        _password2Controller.text.isEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Erreur'),
                                          content: Text(
                                              'Il faut rentrer un email, un pseudo, un mot de passe et confirmer le mot de passe'),
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
                                          final user =
                                              await AuthService.register(
                                                  _pseudoController.text,
                                                  _emailController.text,
                                                  _passwordController.text,
                                                  _password2Controller.text);
                                          // L'inscription a réussi
                                          print(user);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    "Bravo, vous êtes inscrit !")),
                                          );
                                        } catch (e) {
                                          // L'inscription a échoué
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    "Erreur d'authentification")),
                                          );
                                        }
                                      }
                                    }
                                  },
                                  child: Text(
                                    "s'inscrire",
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
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 350,
                    child: SizedBox(
                      width: 266,
                      height: 52,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/account.svg',
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _pseudoController,
                              decoration: const InputDecoration(
                                hintText: 'Pseudo',
                                hintStyle: TextStyle(
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
                    top: 410,
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
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff0272cd), width: 3),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff0272cd), width: 3),
                                ),
                              ),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 470,
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
                                hintStyle: TextStyle(
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
                    top: 530,
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
                              controller: _password2Controller,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Confirmation mot de passe',
                                hintStyle: TextStyle(
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
                    top: 725,
                    child: RichText(
                      text: TextSpan(
                        text: "Déja un compte ? ",
                        style: GoogleFonts.unicaOne(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Cliquez ici",
                            style: GoogleFonts.unicaOne(
                              color: Colors.blue,
                              fontSize: 17.0,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/LoginPage');
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 730,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/UploadPost');
                      },
                      child: Text(
                        "Déjà un compte ? Cliquez ici",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    right: 10,
                    child: Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Text(
                        'INSCRIPTION',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.unicaOne(
                          fontSize: 64,
                          color: Colors.white,
                        ),
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
