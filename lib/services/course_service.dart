import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:programovilfront/models/courses.dart';

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
}
