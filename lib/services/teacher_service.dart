import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:programovilfront/config/token_manager.dart';
import '../models/teachers.dart';
import '../models/teachers_colleges.dart';
import '../models/teachers_courses.dart';
import 'package:http/http.dart' as http;

class TeacherService {
  final tokenManager = TokenManager();

  Future<String?> _getToken() async {
    return await tokenManager.getToken();
  }

  final String _baseUrl = dotenv.env['API_URL']!;

  Future<Teacher> getTeacherById(int id) async {
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
      return Teacher.fromJson(jsonItem);
    } else {
      throw Exception(
          'Error al obtener el profesor. Código: ${response.statusCode}');
    }
  }

  Future<Set<int>> getTeacherCollegeIds(int teacherId) async {
    final data = await _loadJsonList('assets/json/teachers_colleges.json');
    return data
        .map((json) => TeacherCollege.fromJson(json))
        .where((tc) => tc.teacherId == teacherId)
        .map((tc) => tc.collegeId)
        .toSet();
  }

  Future<List<dynamic>> getTeachersInCollege(int collegeId) async {
    final data = await _loadJsonList('assets/json/teachers.json');
    return data.where((x) => x['college_id'] == collegeId).toList();
  }

  Future<List<dynamic>> getAllTeachers() async {
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

  Future<List<dynamic>> _loadJsonList(String path) async {
    final jsonStr = await rootBundle.loadString(path);
    return json.decode(jsonStr);
  }

  //  profesores por ID de curso
  Future<List<Teacher>> getTeachersByCourseId(int courseId) async {
    final teacherCoursesJson =
        await _loadJsonList('assets/json/teachers_courses.json');
    final teacherCourses =
        teacherCoursesJson.map((json) => TeacherCourse.fromJson(json)).toList();

    final teacherIds = teacherCourses
        .where((tc) => tc.courseId == courseId)
        .map((tc) => tc.teacherId)
        .toSet();

    final allTeachersJson = await _loadJsonList('assets/json/teachers.json');
    final allTeachers =
        allTeachersJson.map((json) => Teacher.fromJson(json)).toList();

    return allTeachers
        .where((teacher) => teacherIds.contains(teacher.teacherId))
        .toList();
  }
}
