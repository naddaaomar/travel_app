import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/models/inclusion_model.dart';
import 'package:p/models/photo_gallery_model.dart';
import 'package:p/screens/payment/presentation/pages/test_form.dart';
import 'trip_on_map.dart';

class TripDetailsViewBody extends StatelessWidget {
  const TripDetailsViewBody({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: size.height * 0.3,
              width: double.maxFinite,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20)),
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(15)),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            iconSize: 20,
                            icon: const Icon(Ionicons.chevron_back),
                          ),
                          IconButton(
                            iconSize: 20,
                            onPressed: () {},
                            icon: const Icon(Ionicons.heart_outline),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 230),
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: ColorApp.secondaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text('Dahab',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                          Spacer(),
                          Text(
                            "\$200",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: IconButton(
                              onPressed: () {},
                              iconSize: 20,
                              icon: const Icon(
                                  Ionicons.chatbubble_ellipses_outline),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'rate',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Icon(
                                Ionicons.star,
                                color: Colors.yellow[800],
                                size: 15,
                              ),
                            ],
                          )
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: ColorApp.primaryColor,
                            size: 10,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Description',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Egypt’s Hidden Gem ,Dahab is a dream come true for thrill-seekers and nature"
                        " enthusiasts alike. The town is world-renowned for its diving spots, "
                        "particularly the Blue Hole, a bucket-list destination for divers"
                        " drawn to its underwater caves and vibrant marine life.",
                        style: TextStyle(fontSize: 13),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: ColorApp.primaryColor,
                            size: 10,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Photo Gallery',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 255,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 20),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                photoGalleryModel[index].image,
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TripOnMap(
                                    Latitude: 28.5093,
                                    Longitude: 34.5136,
                                  ),
                                ));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: ColorApp.primaryColor,
                                size: 10,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Show on map',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: ColorApp.primaryColor,
                            size: 10,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Inclusion',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 4),
                        child: Text("Why book this trip ?"),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    color: ColorApp.primaryColor,
                                    size: 6,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "${inclusionModel[index].label}",
                                  )),
                                ],
                              ),
                            );
                          },
                          itemCount: inclusionModel.length,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ));
                          },
                          child: Text(
                            "Book Trip",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shadowColor: ColorApp.primaryColor,
                              backgroundColor: ColorApp.primaryColor),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const Center(child: Text("What are you waiting for ?")),
                      const Center(child: Text("Book your trip now.")),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
