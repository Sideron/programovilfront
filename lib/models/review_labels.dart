class ReviewLabel {
  final int reviewLabelId;
  final int reviewId;
  final int labelId;

  ReviewLabel({
    required this.reviewLabelId,
    required this.reviewId,
    required this.labelId,
  });

  factory ReviewLabel.fromJson(Map<String, dynamic> json) {
    return ReviewLabel(
      reviewLabelId: json['review_label_id'],
      reviewId: json['review_id'],
      labelId: json['label_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'review_label_id': reviewLabelId,
    'review_id': reviewId,
    'label_id': labelId,
  };
}
