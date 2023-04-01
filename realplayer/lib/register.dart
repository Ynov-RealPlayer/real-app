import 'package:flutter/material.dart';
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

  final double ffem = 1.0;
  final double fem = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Form(
            key: _formKey,
            child: Container(
              // connexionRPx (52:142)
              width: double.infinity,
              height: 932 * fem,
              decoration: BoxDecoration(
                color: Color(0xff1d2b34),
              ),
              child: Stack(
                children: [
                  Positioned(
                    // bouton
                    left: 33 * fem,
                    top: 230 * fem,
                    child: Container(
                      width: 319 * fem,
                      height: 480 * fem,
                      child: Stack(
                        children: [
                          Positioned(
                            // rectangle4EsC (52:143)
                            left: 0 * fem,
                            top: 0 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 319 * fem,
                                height: 469 * fem,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(27 * fem),
                                    color: Color(0xff1d2b34),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // Bouton de connexion
                            left: 32 * fem,
                            top: 400 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 255 * fem,
                                height: 52 * fem,
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
                                          final user = await AuthService.register(
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
                                    "VALIDER",
                                    style: GoogleFonts.unicaOne(
                                      fontSize: 22 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.1825 * ffem / fem,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                  color: Color(0xff0272cd),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10 * fem),
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
                    // pseudo
                    left: 53 * fem,
                    top: 350 * fem,
                    child: SizedBox(
                      width: 255 * fem,
                      height: 52 * fem,
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.user,
                            color: Color(0xff0272cd),
                            size: 36 * fem,
                          ),
                          SizedBox(width: 10 * fem),
                          Expanded(
                            child: TextField(
                              controller: _pseudoController,
                              decoration: InputDecoration(
                                hintText: 'Pseudo',
                                hintStyle: TextStyle(
                                  fontSize: 18 * ffem,
                                  color: Color(0x99ffffff),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff0272cd)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff0272cd)),
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
                    // emailfield
                    left: 53 * fem,
                    top: 410 * fem,
                    child: SizedBox(
                      width: 255 * fem,
                      height: 52 * fem,
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.envelope,
                            color: Color(0xff0272cd),
                            size: 36 * fem,
                          ),
                          SizedBox(width: 10 * fem),
                          Expanded(
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  fontSize: 18 * ffem,
                                  color: Color(0x99ffffff),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff0272cd)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff0272cd)),
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
                    // passwordfield (52:185)
                    left: 53 * fem,
                    top: 470 * fem,
                    child: SizedBox(
                      width: 255 * fem,
                      height: 52 * fem,
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.lock,
                            color: Color(0xff0272cd),
                            size: 36 * fem,
                          ),
                          SizedBox(width: 10 * fem),
                          Expanded(
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Mot de passe',
                                hintStyle: TextStyle(
                                  fontSize: 18 * ffem,
                                  color: Color(0x99ffffff),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff0272cd)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff0272cd)),
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
                    // passwordfield (52:185)
                    left: 53 * fem,
                    top: 530 * fem,
                    child: SizedBox(
                      width: 255 * fem,
                      height: 52 * fem,
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.lock,
                            color: Color(0xff0272cd),
                            size: 36 * fem,
                          ),
                          SizedBox(width: 10 * fem),
                          Expanded(
                            child: TextField(
                              controller: _password2Controller,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Vérification mot de passe',
                                hintStyle: TextStyle(
                                  fontSize: 18 * ffem,
                                  color: Color(0x99ffffff),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff0272cd)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff0272cd)),
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
                    left: 0,
                    right: 0,
                    top: 700 * fem,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/LoginPage');
                      },
                      child: Text(
                        "Déjà un compte ? Cliquez ici",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16 * ffem,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 95,
                    right: 100,
                    child: Padding(
                      padding: EdgeInsets.only(top: 200 * fem),
                      child: Text(
                        'INSCRIPTION',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32 * ffem,
                          fontWeight: FontWeight.bold,
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
