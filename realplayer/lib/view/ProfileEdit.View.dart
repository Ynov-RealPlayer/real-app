import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realplayer/services/profile_service.dart';
import 'package:realplayer/themes/color.dart';
import 'package:realplayer/view/Profile.View.dart';

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
  TextEditingController? _pseudoController;
  TextEditingController? _descriptionController;

  @override
  void initState() {
    super.initState();
    widget.userData.then((data) {
      setState(() {
        _pseudoController = TextEditingController(text: data['pseudo']);
        _descriptionController =
            TextEditingController(text: data['description']);
      });
    });
  }

  @override
  void dispose() {
    _pseudoController?.dispose();
    _descriptionController?.dispose();
    super.dispose();
  }

  void _saveProfileData() async {
    final pseudo = _pseudoController!.text;
    final description = _descriptionController!.text;

    try {
      // Récupérer les données utilisateur
      final userData = await widget.userData;

      // Extraire l'ID utilisateur
      final userId = userData['id'];

      // Créer un objet avec les nouvelles informations
      final updatedData = {
        'pseudo': pseudo,
        'description': description,
      };

      // Enregistrer les données du profil
      await ProfileService.saveUserData(userId, updatedData);

      // Call the optional callback if provided
      if (widget.onSave != null) {
        widget.onSave!(updatedData);
      }

      // Naviguer vers la page du profil
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileView()),
      );
    } catch (e) {
      print('Erreur lors de la sauvegarde des données : $e');
    }
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
            _pseudoController == null || _descriptionController == null
                ? CircularProgressIndicator() // Show loading indicator while waiting for data
                : Column(
                    children: [
                      SizedBox(
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
                                controller: _pseudoController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
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
                                controller: _descriptionController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _saveProfileData,
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
