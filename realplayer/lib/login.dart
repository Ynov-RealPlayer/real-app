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
                    top: 100,
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
                                      'SE CONNECTER',
                                      style: GoogleFonts.unicaOne(
                                        fontSize: 22,
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
                          Icon(
                            FontAwesomeIcons.envelope,
                            color: Color(0xff0272cd),
                            size: 36,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  fontSize: 18,
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
                    top: 450,
                    child: SizedBox(
                      width: 255,
                      height: 52,
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.lock,
                            color: Color(0xff0272cd),
                            size: 36,
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
                    top: 600,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/RegisterPage');
                      },
                      child: Text(
                        "Pas encore de compte ? Cliquez ici",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 90,
                    child: Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Text(
                        'CONNEXION',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
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
