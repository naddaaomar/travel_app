import 'dart:async';
import 'package:flutter/material.dart';
import 'package:p/screens/tabs/offers/presentation/pages/company_offers.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/companies.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/hot_deals.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  int _currentIndex = 0;
  late Timer _timer;
  var company = CompanyModel.Companies();
  final List<String> adsImages = [
    "assets/images/dahab1.jpg",
    "assets/images/dahab2.jpg",
    "assets/images/dahab3.jpg",
    "assets/images/dahab4.jpg",
    "assets/images/dahab5.jpg",
    "assets/images/dahab6.jpg",
  ];
  void initState() {
    super.initState();
    _startImageSwitching();
  }

  void _startImageSwitching() {
    _timer = Timer.periodic(const Duration(milliseconds: 2500), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % adsImages.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hot Deals",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            HotDeals(
                adsImages: adsImages,
                currentIndex: _currentIndex,
                timer: _timer),
            SizedBox(
              height: 15,
            ),
            Text(
              """Discover exclusive offers
from top companies tailored just for you""",
              maxLines: 2,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            GridView.builder(
              shrinkWrap:
                  true, // Allow the GridView to size itself based on its children
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 30, mainAxisSpacing: 0),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanyOffers(
                            companyModel: company[index],
                          ),
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 27),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            company[index].imagePath,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(130, 128, 128, 128),
                          ),
                          height: double.infinity,
                        ),
                        Center(
                          child: Text(
                            company[index].label,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: company.length,
            )
          ],
        ),
      ),
    );
  }
}
