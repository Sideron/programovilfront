import 'package:flutter/material.dart';
import '../../models/review_display.dart';

class ReviewItem extends StatelessWidget {
  final ReviewDisplay review;
  final bool showEmoji;
  final bool showDate;
  final bool showComment;
  final bool showCourse;

  const ReviewItem(
      {Key? key,
      required this.review,
      this.showEmoji = true,
      this.showDate = true,
      this.showComment = true,
      this.showCourse = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.outline,
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            review.imageUrl,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                    review.username,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  if (showDate) ...[
                    SizedBox(width: 12),
                    Text(
                      review.date,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ]
                ]),
                if (showCourse) ...[
                  SizedBox(height: 4),
                  Text(
                    review.courseName,
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
                SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showComment)
                      Expanded(
                        child: Text(
                          review.comment,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    if (showEmoji) ...[
                      SizedBox(width: 8),
                      Text(
                        review.emoji,
                        style: TextStyle(fontSize: 28),
                      ),
                    ]
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
