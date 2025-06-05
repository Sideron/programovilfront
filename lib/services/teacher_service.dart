import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/teachers.dart';
import '../models/teachers_colleges.dart';

class TeacherService {
  Future<Teacher> getTeacherById(int id) async {
    final data = await _loadJsonList('assets/json/teachers.json');
    final jsonItem = data.firstWhere((t) => t['teacher_id'] == id);
    return Teacher.fromJson(jsonItem);
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
    final data = await _loadJsonList('assets/json/teachers.json');
    return data.toList();
  }

  Future<List<dynamic>> _loadJsonList(String path) async {
    final jsonStr = await rootBundle.loadString(path);
    return json.decode(jsonStr);
  }
}
