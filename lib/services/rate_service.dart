import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:programovilfront/models/group.dart';

class RateService {
  Future<List<Group>> loadGroupsFromJson() async {
    final String response = await rootBundle.loadString('assets/json/group.json');
    final List<dynamic> data = json.decode(response);
    return data.map((item) => Group.fromJson(item)).toList();
  }
}
