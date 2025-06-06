import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:programovilfront/models/courses.dart';
import 'package:programovilfront/models/faculty.dart'; 

class CourseService {
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
        await rootBundle.loadString('assets/json/faculties.json');
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
}
