import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/courses.dart';
import '../models/review_display.dart';
import '../models/labels.dart';
import '../models/review.dart';
import '../models/user.dart';

class ReviewResult {
  final List<ReviewDisplay> reviews;
  final List<String> usedLabelNames;
  ReviewResult({required this.reviews, required this.usedLabelNames});
}

class ReviewService {
  Future<ReviewResult> getReviewsForTeacher(int teacherId) async {
    final data = await _loadAllData();

    final teacherReviews = data.reviews.where((r) => r['teacher_id'] == teacherId);
    final List<ReviewDisplay> reviewList = [];
    final Set<String> labelNames = {};

    for (var reviewJson in teacherReviews) {
      final display = _buildReviewDisplay(
        reviewJson,
        data,
        collectLabelNames: labelNames,
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
      final display = _buildReviewDisplay(reviewJson, data);
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

    return _ReviewData(
      reviews: reviews,
      reviewLabels: reviewLabels,
      labelMap: {for (var l in labels) l['label_id']: Label.fromJson(l)},
      userMap: {for (var u in users) u['user_id']: User.fromJson(u)},
      courseMap: {for (var c in courses) c['course_id']: Course.fromJson(c)},
    );
  }

  ReviewDisplay _buildReviewDisplay(
    Map<String, dynamic> reviewJson,
    _ReviewData data, {
    Set<String>? collectLabelNames,
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
    final user = data.userMap[userId] ??
        User(
          username: 'Anónimo',
          userId: 0,
          email: '',
          password: '',
          collegeId: 0,
          imageUrl: '',
        );

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

  _ReviewData({
    required this.reviews,
    required this.reviewLabels,
    required this.labelMap,
    required this.userMap,
    required this.courseMap,
  });
}
