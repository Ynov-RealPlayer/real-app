import 'dart:convert';
import 'package:http/http.dart' as http;

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
    required String token,
  }) async {
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
}
