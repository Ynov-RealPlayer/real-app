import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class UserService {
  static const String apiUrlBase = "https://realplayer.fr/api/users";

  static Future<Map> getUser(int id) async {
    String? token = await AuthService.getToken();

    if (token == null) {
      throw Exception('Token not found');
    }
    final response = await http.get(
      Uri.parse('$apiUrlBase/$id'),
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('erreur');
    }
  }

  static Future<List<dynamic>> getTop100() async {
    String? token = await AuthService.getToken();

    if (token == null) {
      throw Exception('Token not found');
    }
    final response = await http.get(
      Uri.parse('$apiUrlBase/top'),
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('erreur');
    }
  }
}
