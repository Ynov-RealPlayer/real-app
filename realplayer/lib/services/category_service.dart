import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:realplayer/services/auth_service.dart';

class CategoryService {
  static const apiUrl = "https://realplayer.fr/api";

  static Future<List<dynamic>> fetchCategories() async {
    final token = await AuthService.getToken();
    final url = Uri.parse('$apiUrl/categories');
    final response = await http.get(url, headers: {'Authorization': 'Bearer $token'});
    final categories = json.decode(response.body);
    return categories;
  }
}
