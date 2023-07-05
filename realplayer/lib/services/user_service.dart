import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

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

  final _searchController = StreamController<List<dynamic>>();
  Stream<List<dynamic>> get searchResults => _searchController.stream;
  void searchUser(String query) async {
    if (query.isEmpty) {
      _searchController.sink.add([]);
      return;
    }
    String? token = await AuthService.getToken();
    var url = Uri.parse('https://realplayer.fr/api/search');

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: json.encode({"q": query}),
      );
      if (response.statusCode == 200) {
        _searchController.sink.add(json.decode(response.body) as List<dynamic>);
      } else {
        throw Exception('Failed to search User');
      }
    } catch (e) {
      _searchController.sink.addError('Failed to search user: $e');
    }
  }

  void dispose() {
    _searchController.close();

  Future<Map<String, dynamic>> fetchOtherUserData(int id) async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('$apiUrlBase/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to load user data');
    }
  }
}
