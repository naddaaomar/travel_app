import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/rating_cubit.dart';
import 'rating_card.dart';

class ReviewsSection extends StatelessWidget {
  final int companyId;

  const ReviewsSection({required this.companyId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyRatingCubit, CompanyRatingState>(
      builder: (context, state) {
        if (state is CompanyRatingLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CompanyRatingError) {
          return Center(
            child: Text(
              'Failed to load reviews',
              style: TextStyle(
                fontFamily: 'vols',
                fontWeight: FontWeight.w700 ),
            ),
          );
        } else if (state is CompanyRatingsLoaded) {
          if (state.ratings.isEmpty) {
            return Center(
                child: Text(
                    'No reviews yet',
                style: TextStyle(
                  fontFamily: 'vols'),
                ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.ratings.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) =>
                    ReviewCard(rating: state.ratings[index]),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
