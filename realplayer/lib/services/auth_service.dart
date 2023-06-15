import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const apiUrl = "https://realplayer.fr/api";

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(Uri.parse('$apiUrl/login'), body: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String token = responseData['access_token'];
      await setToken(token);
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
      final String token = responseData['access_token'];
      await setToken(token);
      return responseData;
    } else {
      throw Exception("Failed to register");
    }
  }

  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token ?? '';
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null && token.isNotEmpty;
  }
}
