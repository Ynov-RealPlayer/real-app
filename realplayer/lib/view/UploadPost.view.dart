import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realplayer/themes/color.dart';
import '../services/media_service.dart';
import '../services/auth_service.dart';

void main() {
  runApp(MaterialApp(home: UploadPost()));
}

class UploadPost extends StatefulWidget {
  @override
  _UploadPostState createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future getImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choisir une source',
            style: GoogleFonts.unicaOne(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
              child: Text('Caméra',
                  style: GoogleFonts.unicaOne(
                    fontSize: 20,
                    color: Colors.white,
                  )),
              onPressed: () {
                Navigator.pop(context);
                _picker.getImage(source: ImageSource.camera).then((pickedFile) {
                  setState(() {
                    if (pickedFile != null) {
                      _image = File(pickedFile.path);
                    } else {
                      print('Aucune image sélectionnée.');
                    }
                  });
                });
              },
            ),
            TextButton(
              child: Text('Galerie',
                  style: GoogleFonts.unicaOne(
                    fontSize: 20,
                    color: Colors.white,
                  )),
              onPressed: () {
                Navigator.pop(context);
                _picker
                    .getImage(source: ImageSource.gallery)
                    .then((pickedFile) {
                  setState(() {
                    if (pickedFile != null) {
                      _image = File(pickedFile.path);
                    } else {
                      print('Aucune image sélectionnée.');
                    }
                  });
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff1d2b34),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Center(
                  child: Text(
                    'Nouveau Post',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.unicaOne(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Center(
                  child: GestureDetector(
                    onTap: getImage,
                    child: Container(
                      width: 150,
                      height: 150,
                      color: Colors.grey[200],
                      child: Stack(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            color: ColorTheme.buttonColor,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: getImage,
                              child: Container(
                                width: 150,
                                height: 150,
                                child: _image == null
                                    ? Icon(
                                        Icons.add,
                                        size: 30,
                                        color: Colors.white,
                                      )
                                    : Image.file(_image!, fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Titre du post:',
                    style: GoogleFonts.unicaOne(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextField(
                  controller: _titreController,
                  decoration: InputDecoration(
                    hintText: 'Entrez le titre ici',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Color(0x99ffffff),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff0272cd)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff0272cd)),
                    ),
                  ),
                  style: GoogleFonts.unicaOne(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Description:',
                    style: GoogleFonts.unicaOne(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Entrez la description ici',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Color(0x99ffffff),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff0272cd)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff0272cd)),
                    ),
                  ),
                  style: GoogleFonts.unicaOne(
                    color: Colors.white,
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        final response = await MediaService.postMedia(
                          name: _titreController.text,
                          description: _descriptionController.text,
                          mediaType: "SCREEN",
                          url:
                              "https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExZjdhZWY1ZWU0ZGFhMmQ2MmMzNzRjM2M5NTc0NWRmZjIzZWIzMGM4OSZlcD12MV9pbnRlcm5hbF9naWZzX2dpZklkJmN0PWc/Wvh1de6cFXcWc/giphy.gif",
                          duration: 0,
                          categoryId: 1,
                          userId: 1,
                        );
                        print("Réponse de l'API: $response");
                      } catch (e) {
                        print("Erreur lors de l'envoi du post: $e");
                      }
                    },
                    icon: Icon(Icons.post_add),
                    label: Text(
                      'Créer le post',
                      style: GoogleFonts.unicaOne(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffffffff),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff0272cd),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 8,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
