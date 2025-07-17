import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../data/model/rating_model.dart';

class ReviewCard extends StatelessWidget {
  final CompanyRatingModel rating;

  const ReviewCard({required this.rating, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  rating.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'vols',
                      fontSize: 16),
                ),
                const Spacer(),
                RatingBarIndicator(
                  rating: rating.rating.toDouble(),
                  itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber),
                  itemCount: 5,
                  itemSize: 20,
                  direction: Axis.horizontal,
                ),
              ],
            ),
            if (rating.message.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(rating.message, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ],
        ),
      ),
    );
  }
}
