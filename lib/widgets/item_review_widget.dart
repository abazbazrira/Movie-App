import 'package:dicoding_bfaf_submission/data/model/customer_review.dart';
import 'package:flutter/material.dart';

class ItemReviewWidget extends StatelessWidget {
  final CustomerReview customerReview;

  const ItemReviewWidget({
    Key? key,
    required this.customerReview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24, top: 16, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            customerReview.name.trim(),
            style: const TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            child: Text(
              customerReview.review.trim(),
              style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              textAlign: TextAlign.start,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            customerReview.date.trim(),
            style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
