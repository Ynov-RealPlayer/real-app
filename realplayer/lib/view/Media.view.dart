import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:realplayer/themes/color.dart';
import '../services/media_service.dart';
import '../services/user_service.dart';

void main() {
  runApp(MaterialApp(home: MediaPage(postId: 3)));
}

class MediaPage extends StatefulWidget {
  final int postId;

  MediaPage({required this.postId});

  @override
  _MediaPageState createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  late Future<Map<String, dynamic>> _mediaData;
  late Future<List<dynamic>?> _commentariesData;
  bool _showCommentaries = false;
  TextEditingController _commentController = TextEditingController();

  late int _likes;
  late bool _hasLiked;

  Map<int, int> _comLikes = Map<int, int>();
  Map<int, bool> _comHasLiked = Map<int, bool>();

  @override
  void initState() {
    super.initState();
    _mediaData = fetchMediaData();
    _commentariesData = getCommentariesData();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> fetchMediaData() async {
    try {
      final mediaData = await MediaService.getMedia(widget.postId);
      _likes = mediaData['nb_likes'] ?? 0;
      _hasLiked = mediaData['has_liked'] ?? false;
      return mediaData;
    } catch (e) {
      log('Erreur lors de la récupération du média: $e');
      return {};
    }
  }

  Future<List<dynamic>?> getCommentariesData() async {
    try {
      final commentariesData =
          await MediaService.getCommentaries(widget.postId);
      for (var comment in commentariesData) {
        _comLikes[comment['id']] = comment['nb_likes'] ?? 0;
        _comHasLiked[comment['id']] = comment['has_liked'] ?? false;
      }
      return commentariesData;
    } catch (e) {
      log('Erreur lors de la récupération des commentaires : $e');
      return null;
    }
  }

  Future<void> refreshCommentaries() async {
    try {
      final commentariesData =
          await MediaService.getCommentaries(widget.postId);
      for (var comment in commentariesData) {
        _comLikes[comment['id']] = comment['nb_likes'] ?? 0;
        _comHasLiked[comment['id']] = comment['has_liked'] ?? false;
      }
      setState(() {
        _commentariesData = Future.value(commentariesData);
      });
    } catch (e) {
      log('Erreur lors de la récupération des commentaires : $e');
      setState(() {
        _commentariesData = Future.value(null);
      });
    }
  }

  Future<dynamic> fetchUserData(int userID) async {
    try {
      UserService userService = UserService();
      final userData = await userService.getUser(userID);
      final String profilePhotoUrl = userData['picture'];
      return profilePhotoUrl;
    } catch (e) {
      log('Erreur lors de la récupération des données de l\'utilisateur: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1d2b34),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _mediaData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erreur lors de la récupération des données'));
          } else {
            final mediaData = snapshot.data ?? {};
            final String name = mediaData['name'] ?? '';
            final String description = mediaData['description'] ?? '';
            final int user_id = mediaData['user_id'] ?? 0;
            final String url = mediaData['url'] ?? "assets/images/shrek.jpg";
            final String profilePhotoUrl = mediaData['user']['picture'] ??
                "https://www.journee-mondiale.com//medias/grande/images/journee/rien-du-tout.jpg";
            final int likes = mediaData['nb_likes'] ?? 0;
            final bool hasLiked = mediaData['has_liked'] ?? false;

            return Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: (context, url) => Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          color: ColorTheme.buttonColor,
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 40.0, left: 8, right: 8),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: profilePhotoUrl,
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                backgroundImage: imageProvider,
                                radius:
                                    20, // Ajustez cette valeur pour réduire la taille du CircleAvatar
                                  ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: _hasLiked ? Colors.red : Colors.white,
                                ),
                                onPressed: () async {
                                  try {
                                    final response =
                                        await MediaService.likeMedia(
                                            widget.postId, 'Media');
                                    log(response.toString());
                                    if (response["message"] == "success") {
                                      setState(() {
                                        if (response['like'] == "created") {
                                          _hasLiked = true;
                                          _likes++;
                                        } else {
                                          _hasLiked = false;
                                          _likes--;
                                        }
                                      });
                                    }
                                  } catch (e) {
                                    print(
                                        'Erreur lors de l\'ajout du j\'aime : $e');
                                  }
                                },
                              ),
                              Text(
                                '$_likes',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          Text(name, style: TextStyle(color: Colors.white)),
                          Text(description,
                              style: TextStyle(color: Colors.white)),
                        ],
                      )),
                    ),
                    _buildCommentInput(),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: _showCommentaries
                        ? MediaQuery.of(context).size.height * 0.6
                        : 0,
                    decoration: BoxDecoration(
                      color: Color(0xFF0272CD),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: _buildCommentariesList(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  List<Widget> _buildCommentariesList() {
    return [
      IconButton(
        icon: Icon(Icons.close, color: Colors.white),
        onPressed: () {
          setState(() {
            _showCommentaries = false;
          });
        },
      ),
      FutureBuilder<List<dynamic>?>(
        future: _commentariesData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text(
              'Erreur lors de la récupération des commentaires',
              style: TextStyle(color: Colors.white),
            );
          } else {
            final commentariesData = snapshot.data;
            if (commentariesData == null || commentariesData.isEmpty) {
              return Text(
                'Aucun commentaire',
                style: TextStyle(color: Colors.white),
              );
            } else {
              return _buildCommentaries(commentariesData);
            }
          }
        },
      ),
    ];
  }

  Widget _buildCommentaries(List<dynamic> commentaries) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: commentaries.length,
      itemBuilder: (context, index) {
        final commentary = commentaries[index];
        final String comProfilePhotoUrl = commentary["user"]["picture"];
        final String username = commentary['username'] ?? '';
        final int user_id = commentary['user_id'] ?? 0;
        final String content = commentary['content'] ?? '';
        final int comLikes =
            _comLikes[commentary['id']] ?? (commentary['nb_likes'] ?? 0);
        final bool comHasLiked = _comHasLiked[commentary['id']] ??
            (commentary['has_liked'] ?? false);

        return ListTile(
          leading: FutureBuilder<dynamic>(
            future: fetchUserData(user_id),
            builder: (context, snapshot) {
              if (comProfilePhotoUrl.isEmpty) {
                return CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo_real.png'),
                );
              } else {
                return CachedNetworkImage(
                  imageUrl: comProfilePhotoUrl,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo_real.png'),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo_real.png'),
                  ),
                );
              }
            },
          ),
          title: Text(
            username,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            content,
            style: TextStyle(color: Colors.white),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: comHasLiked ? Colors.red : Colors.white,
                ),
                onPressed: () async {
                  try {
                    final response = await MediaService.likeMedia(
                        commentary['id'], 'Commentary');
                    log(response.toString());
                    if (response["message"] == "success") {
                      setState(() {
                        if (response['like'] == "created") {
                          _comHasLiked[commentary['id']] = true;
                          _comLikes[commentary['id']] = (comLikes + 1);
                        } else {
                          _comHasLiked[commentary['id']] = false;
                          _comLikes[commentary['id']] = (comLikes - 1);
                        }
                      });
                    }
                  } catch (e) {
                    print('Erreur lors de l\'ajout du j\'aime : $e');
                  }
                },
              ),
              Text(
                comLikes.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommentInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
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
            icon: Icon(Icons.send, color: Color(0xff0272cd)),
            onPressed: () async {
              final comment = _commentController.text;
              if (comment.isNotEmpty) {
                try {
                  await MediaService.postCommentary(
                    content: comment,
                    mediaId: widget.postId,
                  );
                  _commentController.clear();
                  refreshCommentaries();
                } catch (e) {
                  print('Erreur lors de la publication du commentaire : $e');
                }
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.comment, color: Colors.white),
            onPressed: () {
              setState(() {
                _showCommentaries = !_showCommentaries;
              });
            },
          ),
        ],
      ),
    );
  }
}
