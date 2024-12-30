import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';

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
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.6,
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
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
              height: MediaQuery.of(context).size.height / 500,
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20 ),
              decoration: const BoxDecoration(
                color: Color(0xFFE0D7D7),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)
                ),
              ),
              child: ListView(
                children: const [
                   Padding(padding: EdgeInsets.only(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                          ],
                        )
                      ],
                    ),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20,left: 20,top: 20),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'place',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'description',
                          style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                  const Spacer(),

                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: IconButton(
                      onPressed: () {},
                      iconSize: 20,
                      icon: const Icon(Ionicons.chatbubble_ellipses_outline),
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
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorApp.primaryColor,
                  elevation: 0.4,
                  shape: const StadiumBorder(),

                  padding: const EdgeInsets.symmetric(
                    vertical: 100,
                    horizontal: 40,
                  ),
                ),
                child: const Text("Join this tour"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
