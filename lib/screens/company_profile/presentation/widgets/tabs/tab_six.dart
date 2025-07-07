import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class TabSix extends StatelessWidget {
  final List<Map<String, dynamic>> reviews = [
    {
      "name": "Alaa Raslan",
      "rating": 5.0,
      "review":
      "Amazing experience! The tour guides were professional, and the whole trip was well-organized. Highly recommend!",
      "avatar": "assets/images/user1.png"
    },
    {
      "name": "Nada Omar",
      "rating": 4.5,
      "review":
      "Had a wonderful time exploring Egypt. The hotels were great, and the transport was very comfortable.",
      "avatar": "assets/images/user2.png"
    },
    {
      "name": "Ola Belal",
      "rating": 4.0,
      "review":
      "Good experience overall, but I wish there was more free time in the itinerary. Still, great service!",
      "avatar": "assets/images/user3.png"
    },
    {
      "name": "Nourhan Ali",
      "rating": 5.0,
      "review":
      "A perfect vacation! Everything was arranged so well, from sightseeing to accommodations. Loved it!",
      "avatar": "assets/images/user4.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return FadeInUp(
            duration: Duration(
                milliseconds: 1150
            ),
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
                            review["name"],
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
                                color: starIndex < review["rating"].toInt()
                                    ? Colors.amber
                                    : Colors.grey[400],
                                size: 18,
                              );
                            }),
                          ),
                          SizedBox(height: 5),
                          Text(
                            review["review"],
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
