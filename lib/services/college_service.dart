import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/colleges.dart';

class CollegeService {
  Future<List<College>> getAllColleges() async {
    final jsonStr = await rootBundle.loadString('assets/json/colleges.json');
    final data = json.decode(jsonStr) as List<dynamic>;
    return data.map((json) => College.fromJson(json)).toList();
  }
}
