import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:realplayer/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'auth_service.dart';

class MediaService {
  static const apiUrl = "https://realplayer.fr/api";

  static Future<bool> PostMedia({
    required String title,
    required String description,
    required String categoryID,
    required File media,
  }) async {
    final token = await AuthService.getToken();

    var request = http.MultipartRequest('POST', Uri.parse('$apiUrl/media'));
    request.headers['Authorization'] = 'Bearer $token';

    request.fields['name'] = title;
    request.fields['description'] = description;
    request.fields['category_id'] = categoryID;

    var mediaFile = await http.MultipartFile.fromPath('resource', media.path);
    request.files.add(mediaFile);

    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<dynamic>> getMediaByCategorie(int CategorieId) async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('$apiUrl/media/category/$CategorieId'),
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

  static Future<Map<String, dynamic>> getMedia(int mediaId) async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('$apiUrl/media/$mediaId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception("Failed to get media");
    }
  }

  static Future<List<dynamic>> getAllMedia() async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('$apiUrl/media'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);
      if (responseData is List<dynamic>) {
        return responseData;
      } else {
        throw Exception('Invalid response data format');
      }
    } else {
      throw Exception('Failed to get all medias');
    }
  }

  static Future<Map<String, dynamic>> likeMedia(
      int mediaId, String type) async {
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
