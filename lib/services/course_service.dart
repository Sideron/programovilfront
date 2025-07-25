import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:programovilfront/config/token_manager.dart';

import 'package:programovilfront/models/courses.dart';

class CourseService {
  final String _baseUrl = dotenv.env['API_URL'] ?? '';
  final TokenManager _tokenManager = TokenManager();
  Future<String?> _getToken() async {
    return await _tokenManager.getToken();
  }

  CourseService() {
    if (_baseUrl.isEmpty) {
      throw Exception('API_URL no está configurado en el archivo .env');
    }
  }

  /// Cargar un curso por ID desde archivo local.
  Future<Course> getCourseId(int id) async {
    final url = Uri.parse('$_baseUrl/api/courses/$id');
    final token = await _getToken(); // Asegúrate de tener este método definido

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Course.fromJson(jsonData);
    } else {
      throw Exception(
          'Error al obtener el curso. Código: ${response.statusCode}');
    }
  }

  /// Obtener cursos de una universidad a partir de su ID.
  Future<List<Course>> getCoursesByCollegeId(int collegeId) async {
    final url = Uri.parse('$_baseUrl/api/courses/college/$collegeId');
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
      return jsonList.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception(
          'Error al obtener el profesor. Código: ${response.statusCode}');
    }
  }

  /// Obtener cursos por ID de profesor usando API.
  Future<List<Course>> getCoursesByTeacher(int teacherId) async {
    final url = Uri.parse('$_baseUrl/api/courses/profesor/$teacherId');
    final token = await _tokenManager.getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Token JWT no encontrado. Debes iniciar sesión.');
    }

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data.map((e) => Course.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener cursos del profesor');
    }
  }
}
