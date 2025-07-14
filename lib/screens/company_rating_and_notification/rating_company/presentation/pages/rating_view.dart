import 'package:flutter/material.dart';
import '../widgets/rating_input_section.dart';
import '../widgets/reviews_section.dart';


class CompanyRatingView extends StatelessWidget {
  final int companyId;
  final String userId;
  final String userName;

  const CompanyRatingView({
    required this.companyId,
    required this.userId,
    required this.userName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingInputSection(
          companyId: companyId,
          userId: userId,
          userName: userName,
        ),
        const SizedBox(height: 24),
        ReviewsSection(companyId: companyId),
      ],
    );
  }
}
