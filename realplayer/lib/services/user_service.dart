import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class UserService {
  final String apiUrlBase = "https://realplayer.fr/api/users";

  Future<Map> getUser(int id) async {
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
      //print('User: $jsonResponse');
      return jsonResponse;
    } else {
      throw Exception('erreur');
    }
  }
}
