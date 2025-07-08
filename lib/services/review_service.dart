import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/review_display.dart';
import '../models/labels.dart';
import '../models/review.dart';
import '../models/user.dart';

class ReviewResult {
  final List<ReviewDisplay> reviews;
  final List<String> usedLabelNames;
  ReviewResult({required this.reviews, required this.usedLabelNames});
}

class UserProfileResult {
  final User user;
  final List<ReviewDisplay> reviews;
  final String? collegeName;
  UserProfileResult({
    required this.user,
    required this.reviews,
    required this.collegeName,
  });
}

class ReviewService {
  final String _token = dotenv.env['JWT_TOKEN']!;
  final String _baseUrl = dotenv.env['API_URL']!;

  Future<ReviewResult> getReviewsForTeacher(int teacherId) async {
    final url = Uri.parse('$_baseUrl/api/reviews/$teacherId');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al obtener reviews: ${response.statusCode}');
    }

    final List<dynamic> reviewJsonList = json.decode(response.body);
    final List<ReviewDisplay> reviewList = [];
    final Set<String> labelNames = {};

    for (var reviewJson in reviewJsonList) {
      final review = Review(
        reviewId: 0,
        userId: 0,
        teacherId: teacherId,
        courseId: 0,
        comment: reviewJson['comment'],
        date: reviewJson['date'],
      );

      final user = User(
        username: reviewJson['username'] ?? 'Anónimo',
        userId: 0,
        email: '',
        password: '',
        collegeId: 0,
        imageUrl: reviewJson['imageUrl'] ?? '',
      );

      final labels = (reviewJson['labels'] as List?)
              ?.map((l) => Label.fromJson(l))
              .toList() ??
          [];

      labelNames.addAll(labels.map((l) => l.name));

      final display = ReviewDisplay.fromModels(
        review: review,
        user: user,
        emoji: reviewJson['emoji'] ?? '',
        labels: labels,
        courseName: reviewJson['courseName'] ?? '',
      );

      reviewList.add(display);
    }

    return ReviewResult(
      reviews: reviewList,
      usedLabelNames: labelNames.toList(),
    );
  }

  Future<UserProfileResult> getReviewsByUser() async {
    final url = Uri.parse('$_baseUrl/api/users/perfil');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al obtener el perfil del usuario: ${response.statusCode}');
    }

    final jsonData = json.decode(response.body);
    final userData = jsonData['userData'];
    final reviewsJson = jsonData['reviews'];

    final user = User(
      userId: userData['user_id'],
      username: userData['username'],
      email: userData['email'],
      password: '',
      collegeId: userData['college_id'],
      imageUrl: userData['image_url'],
    );

    final collegeName = userData['collegeName'];

    final reviewList = (reviewsJson as List).map((reviewJson) {
      final review = Review(
        reviewId: 0,
        userId: user.userId,
        teacherId: 0,
        courseId: 0,
        comment: reviewJson['comment'],
        date: reviewJson['date'],
      );

      final labels = (reviewJson['labels'] as List?)
              ?.map((l) => Label.fromJson(l))
              .toList() ??
          [];

      return ReviewDisplay.fromModels(
        review: review,
        user: user,
        emoji: reviewJson['emoji'] ?? '',
        labels: labels,
        courseName: reviewJson['courseName'] ?? '',
      );
    }).toList();

    return UserProfileResult(
      user: user,
      reviews: reviewList,
      collegeName: collegeName,
    );
  }
}
