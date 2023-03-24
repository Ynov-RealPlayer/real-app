import 'package:flutter/material.dart';
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
                    top: 100 * fem,
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
                            top: 428 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 255 * fem,
                                height: 52 * fem,
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
                                          final user = await AuthService.login(
                                              _emailController.text,
                                              _passwordController.text);
                                          print(user);
                                          // La connexion a réussi, effectuez une action en conséquence, comme naviguer vers une autre page
                                        } catch (e) {
                                          // La connexion a échoué, afficher une erreur à l'utilisateur
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
                                    'SE CONNECTER',
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
                    // emailfield
                    left: 53 * fem,
                    top: 380 * fem,
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
                                  borderSide: BorderSide(color: Color(0xff0272cd)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff0272cd)),
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
                    top: 450 * fem,
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
                                  borderSide: BorderSide(color: Color(0xff0272cd)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff0272cd)),
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
                    // Texte "Pas encore de compte ? Cliquez ici"
                    left: 0,
                    right: 0,
                    top: 600 * fem,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/RegisterPage');
                      },
                      child: Text(
                        "Pas encore de compte ? Cliquez ici",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16 * ffem,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 90,
                    left: 95,
                    right: 100,
                    child: Padding(
                      padding: EdgeInsets.only(top: 200 * fem),
                      child: Text(
                        'CONNEXION',
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
