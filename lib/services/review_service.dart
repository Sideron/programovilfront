import 'dart:convert';
import 'package:flutter/services.dart';
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
    final reviewsJson = await _loadJsonList('assets/json/review.json');
    final reviewLabelsJson = await _loadJsonList('assets/json/review_labels.json');
    final labelsJson = await _loadJsonList('assets/json/labels.json');
    final usersJson = await _loadJsonList('assets/json/users.json');

    final labelMap = {
      for (var l in labelsJson) l['label_id']: Label.fromJson(l),
    };

    final userMap = {
      for (var u in usersJson) u['user_id']: User.fromJson(u),
    };

    final teacherReviews = reviewsJson.where((r) => r['teacher_id'] == teacherId);
    final List<ReviewDisplay> reviewList = [];
    final Set<String> labelNames = {};

    for (var reviewJson in teacherReviews) {
      final reviewId = reviewJson['review_id'];

      final labelIds = reviewLabelsJson
          .where((rl) => rl['review_id'] == reviewId)
          .map((rl) => rl['label_id'])
          .toList();

      final allLabels = labelIds.map((id) => labelMap[id]!).toList();

      final emojiLabel = allLabels.firstWhere(
        (l) => l.groupId == 1,
        orElse: () => Label(labelId: 0, name: '', imageUrl: '', groupId: 1),
      );

      final otherLabels = allLabels.where((l) => l.groupId != 1).toList();

      final review = Review.fromJson(reviewJson);
      final userId = reviewJson['user_id'];
      final user = userMap[userId] ?? User( username: 'Anónimo', userId: 0, email: '', password: '', collegeId: 0, imageUrl: '',);

      final display = ReviewDisplay.fromModels(
        review: review,
        user: user,
        emoji: emojiLabel.name,
        labels: otherLabels,
      );

      reviewList.add(display);
      labelNames.addAll(otherLabels.map((l) => l.name));
    }

    return ReviewResult(
      reviews: reviewList,
      usedLabelNames: labelNames.toList(),
    );
  }

  Future<List<dynamic>> _loadJsonList(String path) async {
    final jsonStr = await rootBundle.loadString(path);
    return json.decode(jsonStr);
  }

  Future<List<ReviewDisplay>> getReviewsByUser(int userId) async {
  final reviewsJson = await _loadJsonList('assets/json/review.json');
  final reviewLabelsJson = await _loadJsonList('assets/json/review_labels.json');
  final labelsJson = await _loadJsonList('assets/json/labels.json');
  final usersJson = await _loadJsonList('assets/json/users.json');

  final labelMap = {
    for (var l in labelsJson) l['label_id']: Label.fromJson(l),
  };

  final userMap = {
    for (var u in usersJson) u['user_id']: User.fromJson(u),
  };

  final userReviews = reviewsJson.where((r) => r['user_id'] == userId);
  final List<ReviewDisplay> reviewList = [];

  for (var reviewJson in userReviews) {
    final reviewId = reviewJson['review_id'];

    final labelIds = reviewLabelsJson
        .where((rl) => rl['review_id'] == reviewId)
        .map((rl) => rl['label_id'])
        .toList();

    final allLabels = labelIds.map((id) => labelMap[id]!).toList();

    final emojiLabel = allLabels.firstWhere(
      (l) => l.groupId == 1,
      orElse: () => Label(labelId: 0, name: '', imageUrl: '', groupId: 1),
    );

    final otherLabels = allLabels.where((l) => l.groupId != 1).toList();

    final review = Review.fromJson(reviewJson);
    final user = userMap[userId] ??
        User(
          username: 'Anónimo',
          userId: 0,
          email: '',
          password: '',
          collegeId: 0,
          imageUrl: '',
        );

    final display = ReviewDisplay.fromModels(
      review: review,
      user: user,
      emoji: emojiLabel.name,
      labels: otherLabels,
    );

    reviewList.add(display);
  }

  return reviewList;
}

}
