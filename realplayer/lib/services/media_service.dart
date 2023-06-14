import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:realplayer/services/auth_service.dart';

import 'auth_service.dart';

class MediaService {
  static const apiUrl = "https://realplayer.fr/api";

  static Future<Map<String, dynamic>> postMedia({
    required String name,
    required String description,
    required String mediaType,
    required String url,
    required int duration,
    required int categoryId,
    required int userId,
  }) async {
    final token = await AuthService.getToken();
    final response = await http.post(
      Uri.parse('$apiUrl/media'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "name": name,
        "description": description,
        "media_type": mediaType,
        "url": url,
        "duration": duration.toString(),
        "category_id": categoryId.toString(),
        "user_id": userId.toString(),
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception("Failed to post media");
    }
  }

  static Future<Map<String, dynamic>> getMedia(int mediaId) async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('$apiUrl/media/$mediaId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception("Failed to get media");
    }
  }

  static Future<Map<String, dynamic>> likeMedia(int mediaId, String type) async {
    //type = Media or Commentary
    final token = await AuthService.getToken();
    final response = await http.post(
      Uri.parse('$apiUrl/likes'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "likeable_type": "App\\Models\\$type",
        "likeable_id": mediaId.toString(),
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      return responseData;
    } else {
      throw Exception("Failed to like media");
    }
  }

  static Future<List<dynamic>> getCommentaries(int mediaId) async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('$apiUrl/media/category/$CategorieId'),
      Uri.parse('$apiUrl/commentaries?media_id=$mediaId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception("Failed to get commentaries");
    }
  }

  static Future<Map<String, dynamic>> postCommentary({
    required String content,
    required int mediaId,
  }) async {
    final token = await AuthService.getToken();
    final response = await http.post(
      Uri.parse('$apiUrl/commentaries'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "content": content,
        "media_id": mediaId.toString(),
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception("Failed to post commentary");
    }
  }
}
