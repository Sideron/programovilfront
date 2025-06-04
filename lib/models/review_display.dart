import 'labels.dart';
import 'review.dart';
import 'user.dart';

class ReviewDisplay {
  final String username;
  final String imageUrl;
  final String date;
  final String comment;
  final String emoji;
  final List<String> labelNames;

  ReviewDisplay({
    required this.username,
    required this.imageUrl,
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
      imageUrl: user.imageUrl,
      date: review.date,
      comment: review.comment,
      emoji: emoji,
      labelNames: labels.map((l) => l.name).toList(),
    );
  }

  factory ReviewDisplay.fromJson(Map<String, dynamic> json) {
    final labels = (json['labels'] as List?)?.map((label) {
      if (label is String) return label;
      if (label is Map<String, dynamic> && label.containsKey('name')) {
        return label['name'] as String;
      }
      return '';
    }).where((name) => name.isNotEmpty).toList() ?? [];

    return ReviewDisplay(
      username: json['username'] ?? 'user',
      imageUrl: json['image_url'] ?? '',
      date: json['date'] ?? '',
      comment: json['comment'] ?? '',
      emoji: json['emoji'] ?? '',
      labelNames: labels,
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'image_url': imageUrl,
    'date': date,
    'comment': comment,
    'emoji': emoji,
    'labels': labelNames.map((name) => {'name': name}).toList(),
  };
}
