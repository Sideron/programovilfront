import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:programovilfront/models/labels.dart';

class LabelService {
  Future<List<Label>> loadLabelsFromJson() async {
    final String response =
        await rootBundle.loadString('assets/json/labels.json');
    final List<dynamic> data = json.decode(response);
    return data.map((item) => Label.fromJson(item)).toList();
  }
}
