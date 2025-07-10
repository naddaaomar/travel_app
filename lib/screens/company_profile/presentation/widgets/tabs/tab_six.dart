import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/screens/company_profile/data/models/CompanyDetailsModel.dart';

class TabSix extends StatelessWidget {
  List<Ratings> ratings;

  TabSix({required this.ratings});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ratings.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Ionicons.chatbubble_ellipses_outline,
              size: 48,
              color: Colors.grey,
            ),
            SizedBox(height: 12),
            Text(
              'No reviews yet.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: ratings.length,
        itemBuilder: (context, index) {
          final review = ratings[index];
          return FadeInUp(
            duration: Duration(milliseconds: 1150),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.name ?? "",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: List.generate(5, (starIndex) {
                              return Icon(
                                Ionicons.star,
                                color: starIndex < review.rating!.toInt()
                                    ? Colors.amber
                                    : Colors.grey[400],
                                size: 18,
                              );
                            }),
                          ),
                          SizedBox(height: 5),
                          Text(
                            review.message ?? '',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
