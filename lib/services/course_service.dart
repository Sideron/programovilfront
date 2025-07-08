import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:programovilfront/models/courses.dart';
import 'package:programovilfront/models/faculty.dart';

class CourseService {
  final String _token;
  final String _baseUrl;

  CourseService()
      : _token = dotenv.env['JWT_TOKEN'] ?? '',
        _baseUrl = dotenv.env['API_URL'] ?? '' {
    if (_token.isEmpty || _baseUrl.isEmpty) {
      throw Exception('JWT_TOKEN o API_URL no está configurado en el archivo .env');
    }
  }

  /// Cargar un curso por ID desde archivo local.
  Future<Course> getCourseId(int id) async {
    final jsonStr = await rootBundle.loadString('assets/json/courses.json');
    final data = json.decode(jsonStr) as List<dynamic>;
    return data
        .map((json) => Course.fromJson(json))
        .firstWhere((course) => course.courseId == id);
  }

  /// Cargar todos los cursos como `Map`.
  Future<List<dynamic>> loadCoursesFromJsonAsMap() async {
    final jsonStr = await rootBundle.loadString('assets/json/courses.json');
    return json.decode(jsonStr);
  }

  /// Cargar todos los cursos como `Course`.
  Future<List<Course>> loadCoursesFromJson() async {
    final jsonStr = await rootBundle.loadString('assets/json/courses.json');
    final data = json.decode(jsonStr) as List<dynamic>;
    return data.map((e) => Course.fromJson(e)).toList();
  }

  /// Cargar todas las facultades desde archivo local.
  Future<List<Faculty>> loadFacultiesFromJson() async {
    final jsonStr = await rootBundle.loadString('assets/json/faculty.json');
    final data = json.decode(jsonStr) as List<dynamic>;
    return data.map((e) => Faculty.fromJson(e)).toList();
  }

  /// Obtener cursos de una universidad a partir de su ID.
  Future<List<Course>> getCoursesByCollegeId(int collegeId) async {
    final faculties = await loadFacultiesFromJson();
    final facultyIds = faculties
        .where((f) => f.collegeId == collegeId)
        .map((f) => f.facultyId)
        .toSet();

    final courses = await loadCoursesFromJson();
    return courses.where((c) => facultyIds.contains(c.facultyId)).toList();
  }

  /// Obtener cursos por ID de profesor usando API.
  Future<List<Course>> getCoursesByTeacher(int teacherId) async {
    final url = Uri.parse('$_baseUrl/api/courses/profesor/$teacherId');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $_token',
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

  /// Obtener el ID de un curso por su nombre (insensible a mayúsculas).
  Future<int> getCourseIdByName(String courseName) async {
    final courses = await loadCoursesFromJson();

    final course = courses.firstWhere(
      (c) => c.name.toLowerCase() == courseName.toLowerCase(),
      orElse: () => throw Exception('No se encontró el curso con nombre "$courseName"'),
    );

    return course.courseId;
  }
}
