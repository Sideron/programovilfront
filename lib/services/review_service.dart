import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/courses.dart';
import '../models/review_display.dart';
import '../models/labels.dart';
import '../models/review.dart';
import '../models/teachers.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ReviewResult {
  final List<ReviewDisplay> reviews;
  final List<String> usedLabelNames;
  ReviewResult({required this.reviews, required this.usedLabelNames});
}

class ReviewService {
  Future<ReviewResult> getReviewsForTeacher(int teacherId) async {
    final token = dotenv.env['JWT_TOKEN']!;
    final baseUrl = dotenv.env['API_URL']!;
    final url = Uri.parse('$baseUrl/api/reviews/$teacherId');

    final response = await http.get(
      url,
      headers: {
        'Authorization': '$token',
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
          date: reviewJson['date']);

      final user = User(
        username: reviewJson['username'] ?? 'Anónimo',
        userId: 0,
        email: '',
        password: '',
        collegeId: 0,
        imageUrl: reviewJson['imageUrl'] ?? '',
      );

      // Si se incluyen etiquetas en el JSON:
      final List<Label> labels = (reviewJson['labels'] as List?)
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

  Future<List<ReviewDisplay>> getReviewsByUser(int userId) async {
    final data = await _loadAllData();

    final userReviews = data.reviews.where((r) => r['user_id'] == userId);
    final List<ReviewDisplay> reviewList = [];

    for (var reviewJson in userReviews) {
      final display = _buildReviewDisplay(
        reviewJson,
        data,
        useTeacherAsUser: true,
      );
      reviewList.add(display);
    }

    return reviewList;
  }

  Future<List<dynamic>> _loadJsonList(String path) async {
    final jsonStr = await rootBundle.loadString(path);
    return json.decode(jsonStr);
  }

  Future<_ReviewData> _loadAllData() async {
    final reviews = await _loadJsonList('assets/json/review.json');
    final reviewLabels = await _loadJsonList('assets/json/review_labels.json');
    final labels = await _loadJsonList('assets/json/labels.json');
    final users = await _loadJsonList('assets/json/users.json');
    final courses = await _loadJsonList('assets/json/courses.json');
    final teachers = await _loadJsonList('assets/json/teachers.json');

    return _ReviewData(
      reviews: reviews,
      reviewLabels: reviewLabels,
      labelMap: {for (var l in labels) l['label_id']: Label.fromJson(l)},
      userMap: {for (var u in users) u['user_id']: User.fromJson(u)},
      courseMap: {for (var c in courses) c['course_id']: Course.fromJson(c)},
      teacherMap: {
        for (var t in teachers) t['teacher_id']: Teacher.fromJson(t)
      },
    );
  }

  ReviewDisplay _buildReviewDisplay(
    Map<String, dynamic> reviewJson,
    _ReviewData data, {
    Set<String>? collectLabelNames,
    bool useTeacherAsUser = false,
  }) {
    final reviewId = reviewJson['review_id'];
    final userId = reviewJson['user_id'];

    final labelIds = data.reviewLabels
        .where((rl) => rl['review_id'] == reviewId)
        .map((rl) => rl['label_id'])
        .toList();

    final allLabels = labelIds.map((id) => data.labelMap[id]!).toList();

    final emojiLabel = allLabels.firstWhere(
      (l) => l.groupId == 1,
      orElse: () => Label(labelId: 0, name: '', imageUrl: '', groupId: 1),
    );

    final otherLabels = allLabels.where((l) => l.groupId != 1).toList();

    final review = Review.fromJson(reviewJson);

    User user;
    if (useTeacherAsUser) {
      final teacherId = reviewJson['teacher_id'];
      final teacher = data.teacherMap[teacherId] ??
          Teacher(
            teacherId: 0,
            name: 'Profesor desconocido',
            imageUrl: '',
            ratings: 0,
          );
      user = User(
        userId: teacher.teacherId,
        username: teacher.name,
        email: '',
        password: '',
        collegeId: 0,
        imageUrl: teacher.imageUrl,
      );
    } else {
      user = data.userMap[userId] ??
          User(
            username: 'Anónimo',
            userId: 0,
            email: '',
            password: '',
            collegeId: 0,
            imageUrl: '',
          );
    }

    final course = data.courseMap[review.courseId];
    final courseName = course?.name ?? '';

    collectLabelNames?.addAll(otherLabels.map((l) => l.name));

    return ReviewDisplay.fromModels(
      review: review,
      user: user,
      emoji: emojiLabel.name,
      labels: otherLabels,
      courseName: courseName,
    );
  }
}

class _ReviewData {
  final List<dynamic> reviews;
  final List<dynamic> reviewLabels;
  final Map<int, Label> labelMap;
  final Map<int, User> userMap;
  final Map<int, Course> courseMap;
  final Map<int, Teacher> teacherMap;

  _ReviewData({
    required this.reviews,
    required this.reviewLabels,
    required this.labelMap,
    required this.userMap,
    required this.courseMap,
    required this.teacherMap,
  });
}
