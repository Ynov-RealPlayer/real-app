import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const apiUrl = "https://realplayer.fr/api";

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(Uri.parse('$apiUrl/login'), body: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception("Failed to login");
    }
  }

  static Future<Map<String, dynamic>> register(String pseudo, String email, String password, String confirmPassword) async {
    final response = await http.post(Uri.parse('$apiUrl/register'), body: {
      "pseudo": pseudo,
      "email": email,
      "password": password,
      "confirm_password": confirmPassword,
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception("Failed to register");
    }
  }
}
