import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:programovilfront/models/group.dart';
import 'package:programovilfront/models/labels.dart';

class RateService {
  final String token = dotenv.env['JWT_TOKEN']!;
  final String baseUrl = dotenv.env['API_URL']!;

  Future<Map<Group, List<Label>>> loadGroupsWithLabels() async {
    final Uri url = Uri.parse('$baseUrl/api/rate');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al obtener las preguntas: ${response.statusCode}');
    }

    final Map<String, dynamic> jsonData = json.decode(response.body);

    final List<Group> groups = (jsonData['groups'] as List)
        .map((item) => Group.fromJson(item))
        .toList();

    final List<Label> labels = (jsonData['labels'] as List)
        .map((item) => Label.fromJson(item))
        .toList();

    final Map<Group, List<Label>> grouped = {};

    for (final group in groups) {
      grouped[group] = labels.where((l) => l.groupId == group.groupId).toList();
    }

    return grouped;
  }

  Future<void> submitReview({
    required int teacherId,
    required int courseId,
    required String comment,
    required List<int> labelIds,
  }) async {
    final Uri url = Uri.parse('$baseUrl/api/reviews');

    final Map<String, dynamic> body = {
      "teacher_id": teacherId,
      "course_id": courseId,
      "comment": comment,
      "label_ids": labelIds,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode != 201) {
        throw Exception('Error al enviar la evaluación: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión o servidor: $e');
    }
  }
}
