import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:programovilfront/models/courses.dart';
import 'package:programovilfront/models/faculty.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class CourseService {
  Future<Course> getCourseId(int id) async {
    final jsonStr = await rootBundle.loadString('assets/json/courses.json');
    List<dynamic> data = json.decode(jsonStr);
    Course myCourse = data
        .map((json) => Course.fromJson(json))
        .where((x) => x.courseId == id)
        .toList()
        .first;
    return myCourse;
  }

  Future<List<dynamic>> loadCoursesFromJsonAsMap() async {
    final jsonStr = await rootBundle.loadString('assets/json/courses.json');
    return json.decode(jsonStr);
  }

  Future<List<Course>> loadCoursesFromJson() async {
    final String response =
        await rootBundle.loadString('assets/json/courses.json');
    final List<dynamic> data = json.decode(response);
    return data.map((e) => Course.fromJson(e)).toList();
  }

  Future<List<Faculty>> loadFacultiesFromJson() async {
    final String response =
        await rootBundle.loadString('assets/json/faculty.json');
    final List<dynamic> data = json.decode(response);
    return data.map((e) => Faculty.fromJson(e)).toList();
  }

  Future<List<Course>> getCoursesByCollegeId(int collegeId) async {
    final faculties = await loadFacultiesFromJson();
    final facultyIds = faculties
        .where((f) => f.collegeId == collegeId)
        .map((f) => f.facultyId)
        .toSet();

    final courses = await loadCoursesFromJson();
    return courses.where((c) => facultyIds.contains(c.facultyId)).toList();
  }


  Future<List<Course>> getCoursesByTeacher(int teacherId) async {
    final String token = dotenv.env['JWT_TOKEN']!;
    final String baseUrl = dotenv.env['API_URL']!;

    final url = Uri.parse('$baseUrl/api/courses/profesor/$teacherId');
    
    final response = await http.get(
      url,
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Course.fromJson(item)).toList();
    } else {
      throw Exception('Error al obtener cursos del profesor');
    }
  }

  Future<int> getCourseIdByName(String courseName) async {
  final courses = await loadCoursesFromJson(); 

  final course = courses.firstWhere(
    (c) => c.name.toLowerCase() == courseName.toLowerCase(),
    orElse: () => throw Exception('No se encontró el curso con nombre "$courseName"'),
  );

  return course.courseId;
}
}
