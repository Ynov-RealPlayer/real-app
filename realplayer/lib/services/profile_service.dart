import 'package:flutter/material.dart';
import 'package:realplayer/services/auth_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileService {
  static const apiUrl = "https://realplayer.fr/api";

  Future<Map<String, dynamic>> fetchUserData() async {
    final token = await AuthService.getToken();
    final response = await http.post(
      Uri.parse('$apiUrl/me'),
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

  static Future<Map<String, dynamic>> saveUserData(
      int id, Map<String, dynamic> updatedData) async {
    final token = await AuthService.getToken();
    final response = await http.put(
      Uri.parse('$apiUrl/users/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: updatedData,
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to update user data');
    }
  }
}
