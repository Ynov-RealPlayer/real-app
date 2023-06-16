import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realplayer/services/profile_service.dart';
import 'package:realplayer/themes/color.dart';

class ProfileEdit extends StatefulWidget {
  final Future<Map<String, dynamic>> userData;
  final Function(Map<String, dynamic>)? onSave;

  const ProfileEdit({Key? key, required this.userData, this.onSave})
      : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final profileService = ProfileService();
  late Future<Map<String, dynamic>> _userDataEdit;
  late TextEditingController _pseudoController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _userDataEdit = widget.userData;
    _pseudoController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _pseudoController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Modifier mon profil",
              style: GoogleFonts.unicaOne(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
            SizedBox(height: 40),
            Stack(
                // ...
                ),
            SizedBox(
              height: 20,
            ),
            Stack(
                // ...
                ),
            Positioned(
              top: 380,
              child: SizedBox(
                width: 255,
                height: 52,
                child: Row(
                  children: [
                    const Icon(
                      Icons.mode_edit,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Pseudo',
                          hintStyle: GoogleFonts.unicaOne(
                            fontSize: 18,
                            color: Color(0x99ffffff),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff0272cd), width: 3),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff0272cd), width: 3),
                          ),
                        ),
                        style: GoogleFonts.unicaOne(
                          color: Colors.white,
                        ),
                        controller: _pseudoController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 420,
              child: SizedBox(
                width: 255,
                height: 52,
                child: Row(
                  children: [
                    const Icon(
                      Icons.mode_edit,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Description',
                          hintStyle: GoogleFonts.unicaOne(
                            fontSize: 18,
                            color: Color(0x99ffffff),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff0272cd), width: 3),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff0272cd), width: 3),
                          ),
                        ),
                        style: GoogleFonts.unicaOne(
                          color: Colors.white,
                        ),
                        controller: _descriptionController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                final pseudo = _pseudoController.text;
                final description = _descriptionController.text;
                if (widget.onSave != null) {
                  await widget
                      .onSave!({'pseudo': pseudo, 'description': description});
                }
                Navigator.pop(context);
              },
              child: Text(
                'Sauvegarder mes données',
                style: GoogleFonts.unicaOne(
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
