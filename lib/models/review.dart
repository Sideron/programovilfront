class Review {
  final int reviewId;
  final String comment;
  final int userId;
  final int courseId;
  final int teacherId;
  final String date;

  Review({
    required this.reviewId,
    required this.comment,
    required this.userId,
    required this.courseId,
    required this.teacherId,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewId: json['review_id'],
      comment: json['comment'],
      date: json['date'],
      userId: json['user_id'],
      courseId: json['course_id'],
      teacherId: json['teacher_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'review_id': reviewId,
        'comment': comment,
        'user_id': userId,
        'course_id': courseId,
        'teacher_id': teacherId,
        'date': date,
      };
}
