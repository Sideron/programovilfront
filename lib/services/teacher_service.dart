import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:programovilfront/config/token_manager.dart';
import '../models/teachers.dart';
import 'package:http/http.dart' as http;

class TeacherService {
  final tokenManager = TokenManager();

  Future<String?> _getToken() async {
    return await tokenManager.getToken();
  }

  final String _baseUrl = dotenv.env['API_URL']!;

  Future<dynamic> getTeacherById(int id) async {
    final url = Uri.parse('$_baseUrl/api/teachers/$id');
    final token = await _getToken();

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonItem = json.decode(response.body);
      return jsonItem;
    } else {
      throw Exception(
          'Error al obtener el profesor. Código: ${response.statusCode}');
    }
  }

  Future<List<Teacher>> getTeachersInCollege(int collegeId) async {
    final url = Uri.parse('$_baseUrl/api/teachers/college/$collegeId');
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
      return jsonList.map((json) => Teacher.fromJson(json)).toList();
    } else {
      throw Exception(
          'Error al obtener el profesor. Código: ${response.statusCode}');
    }
  }

  Future<List<Teacher>> getAllTeachers() async {
    final url = Uri.parse('$_baseUrl/api/teachers');
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
      return jsonList.map((json) => Teacher.fromJson(json)).toList();
    } else {
      throw Exception(
          'Error al obtener el profesor. Código: ${response.statusCode}');
    }
  }

  //  profesores por ID de curso
  Future<List<Teacher>> getTeachersByCourseId(int courseId) async {
    final url = Uri.parse('$_baseUrl/api/teachers/course/$courseId');
    final token =
        await _getToken(); // Asegúrate de tener este método implementado

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Teacher.fromJson(json)).toList();
    } else {
      throw Exception(
          'Error al obtener los profesores del curso. Código: ${response.statusCode}');
    }
  }
}
