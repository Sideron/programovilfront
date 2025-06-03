import 'labels.dart';
import 'review.dart';
import 'user.dart';

class ReviewDisplay {
  final String username;
  final String date;
  final String comment;
  final String emoji;
  final List<String> labelNames;

  ReviewDisplay({
    required this.username,
    required this.date,
    required this.comment,
    required this.emoji,
    required this.labelNames,
  });

  factory ReviewDisplay.fromModels({
    required Review review,
    required User user,
    required String emoji,
    required List<Label> labels,
  }) {
    return ReviewDisplay(
      username: user.username,
      date: review.date,
      comment: review.comment,
      emoji: emoji,
      labelNames: labels.map((l) => l.name).toList(),
    );
  }

  factory ReviewDisplay.fromJson(Map<String, dynamic> json) {
    final labels = (json['labels'] as List)
        .map((label) => label['name'] as String)
        .toList();

    return ReviewDisplay(
      username: json['username'] ?? 'user',
      date: json['date'],
      comment: json['comment'],
      emoji: json['emoji'] ?? '',
      labelNames: labels,
    );
  }
}
