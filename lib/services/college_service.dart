import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:programovilfront/config/token_manager.dart';
import '../models/colleges.dart';
import 'package:http/http.dart' as http;

class CollegeService {
  final tokenManager = TokenManager();

  Future<String?> _getToken() async {
    return await tokenManager.getToken();
  }

  final String _baseUrl = dotenv.env['API_URL']!;

  Future<College> getCollegeById(int id) async {
    final url = Uri.parse('$_baseUrl/api/colleges/$id');
    final token = await _getToken(); // Asegúrate de tener esta función definida

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonItem = json.decode(response.body);
      return College.fromJson(jsonItem);
    } else {
      throw Exception(
          'Error al obtener la universidad. Código: ${response.statusCode}');
    }
  }

  Future<List<College>> loadCollegessFromJsonAsMap() async {
    final url = Uri.parse('$_baseUrl/api/colleges');
    final token = await _getToken();

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => College.fromJson(json)).toList();
    } else {
      throw Exception(
          'Error al obtener unniversidades. Código: ${response.statusCode}');
    }
  }

  Future<List<College>> getAllColleges() async {
    final jsonStr = await rootBundle.loadString('assets/json/colleges.json');
    final data = json.decode(jsonStr) as List<dynamic>;
    return data.map((json) => College.fromJson(json)).toList();
  }
}
