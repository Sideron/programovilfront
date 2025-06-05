import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/colleges.dart';

class CollegeService {
  Future<College> getCollegeById(int id) async {
    final jsonStr = await rootBundle.loadString('assets/json/colleges.json');
    final data = json.decode(jsonStr) as List<dynamic>;
    return data
        .map((json) => College.fromJson(json))
        .toList()
        .where((x) => x.collegeId == id)
        .first;
  }

  Future<List<dynamic>> loadCollegessFromJsonAsMap() async {
    final jsonStr = await rootBundle.loadString('assets/json/colleges.json');
    return json.decode(jsonStr);
  }

  Future<List<College>> getAllColleges() async {
    final jsonStr = await rootBundle.loadString('assets/json/colleges.json');
    final data = json.decode(jsonStr) as List<dynamic>;
    return data.map((json) => College.fromJson(json)).toList();
  }
}
