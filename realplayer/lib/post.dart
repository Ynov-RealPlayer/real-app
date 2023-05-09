import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(home: PostPage(userId: 1, postId: 1)));
}

class PostPage extends StatelessWidget {
  final int userId;
  final int postId;
  // Constructeur
  PostPage({required this.userId, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1d2b34),
      body: Stack(
        children: [
          Image.network(
            'https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExZjdhZWY1ZWU0ZGFhMmQ2MmMzNzRjM2M5NTc0NWRmZjIzZWIzMGM4OSZlcD12MV9pbnRlcm5hbF9naWZzX2dpZklkJmN0PWc/Wvh1de6cFXcWc/giphy.gif',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('./assets/images/shrek.jpg'),
                          radius: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'QuentinLeMalin',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.red),
                        SizedBox(width: 5),
                        Text('123', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 16),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Ici, vous pouvez ajouter le contenu du post.
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Votre commentaire...',
                          hintStyle: TextStyle(color: Color(0x99ffffff)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff0272cd)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      iconSize: 32,
                      icon: Icon(Icons.send, color: Color(0xff0272cd)),
                      onPressed: () {
                        print("envoyer un commentaire ici");
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
          Positioned(
            bottom: 80,
            right: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  iconSize: 30,
                  onPressed: () {
                    print("like du post ici");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.comment, color: Color(0xff0272cd)),
                  iconSize: 30,
                  onPressed: () {
                    print(postId);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
