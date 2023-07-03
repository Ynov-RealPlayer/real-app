import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/media_service.dart';
import '../services/category_service.dart';

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
  final TextEditingController _categoryIDController = TextEditingController();

  List<dynamic> _categories = [];
  List<DropdownMenuItem<int>> _dropdownMenuItems = [];

  Future getImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey[900],
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

  Future<void> uploadPost() async {
    if (_image != null) {
      try {
        final bool postCreated = await MediaService.PostMedia(
          title: _titreController.text,
          description: _descriptionController.text,
          categoryID: _categoryIDController.text,
          media: _image!,
        );
        if (postCreated) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            SnackBar(
                content: Text(
                    "Votre post a bien été créé")),
          );
          Navigator.pushNamed(context, '/HomePage');
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            SnackBar(
                content: Text(
                    "Une erreur est survenue. Veuillez réessayer.")),
          );
        }
      } catch (e) {
        print(e);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
            content: Text(
                "Veuillez sélectionner une image avant de poster")),
      );
    }
  }

  Future<void> _fetchCategories() async {
    _categories = await CategoryService.fetchCategories();
    _dropdownMenuItems = _categories
        .map((category) => DropdownMenuItem<int>(
      value: category['id'],
      child: Text(category['name'] + ' ' + category['symbol']),
    ))
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fetchCategories();
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
                            color: Colors.blue,
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
                    'Titre du post :',
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
                    'Description :',
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Catégorie :',
                    style: GoogleFonts.unicaOne(
                      fontSize: 18,
                      color: Colors.white, 
                    ),
                  ),
                ),
                SizedBox(height: 16),
                if (_dropdownMenuItems != null)
                  Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Color(0xff1d2b34),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<int>(
                        value: _categoryIDController.text.isNotEmpty ? int.parse(_categoryIDController.text) : null,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          hintText: 'Choisissez une catégorie',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff0272cd)),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff0272cd)),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Colors.white,
                        ),
                        items: _dropdownMenuItems,
                        onChanged: (value) {
                          setState(() {
                            _categoryIDController.text = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    onPressed: uploadPost,
                    child: Text(
                      'Upload',
                      style: GoogleFonts.unicaOne(
                        fontSize: 26, 
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      padding:
                      EdgeInsets.symmetric(horizontal: 50, vertical: 20),
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
