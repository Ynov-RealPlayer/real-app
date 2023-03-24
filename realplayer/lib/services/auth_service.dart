import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const apiUrl = "https://realplayer.fr/api/login";

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(Uri.parse(apiUrl), body: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      // La connexion a réussi, retourner les données de l'utilisateur
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      // La connexion a échoué, retourner une erreur
      throw Exception("Failed to login");
    }
  }
}
