import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/teachers.dart';
import '../models/teachers_colleges.dart';
import '../models/teachers_courses.dart';

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

  //  profesores por ID de curso
  Future<List<Teacher>> getTeachersByCourseId(int courseId) async {
    final teacherCoursesJson = await _loadJsonList('assets/json/teacher_courses.json');
    final teacherCourses = teacherCoursesJson
        .map((json) => TeacherCourse.fromJson(json))
        .toList();

    final teacherIds = teacherCourses
        .where((tc) => tc.courseId == courseId)
        .map((tc) => tc.teacherId)
        .toSet();

    final allTeachersJson = await _loadJsonList('assets/json/teachers.json');
    final allTeachers = allTeachersJson
        .map((json) => Teacher.fromJson(json))
        .toList();

    return allTeachers
        .where((teacher) => teacherIds.contains(teacher.teacherId))
        .toList();
  }

}
