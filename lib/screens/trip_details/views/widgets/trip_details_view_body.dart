import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/models/inclusion_model.dart';
import 'package:p/models/photo_gallery_model.dart';
import 'package:p/screens/payment/presentation/pages/test_form.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';
import 'trip_on_map.dart';

class TripDetailsViewBody extends StatelessWidget {
  const TripDetailsViewBody({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.read<ThemeBloc>().state == ThemeMode.light;
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
                        color: isLight
                            ? Colors.white.withOpacity(0.7)
                            : ColorApp.cardColorDark.withOpacity(.7),
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
                            icon: Icon(
                              Ionicons.chevron_back,
                              color: isLight ? Colors.brown : Colors.white,
                            ),
                          ),
                          IconButton(
                            iconSize: 20,
                            onPressed: () {},
                            icon: Icon(
                              Ionicons.heart_outline,
                              color: isLight ? Colors.brown : Colors.white,
                            ),
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
              decoration: BoxDecoration(
                  color: isLight
                      ? ColorApp.secondaryColor
                      : ColorApp.secondaryColorDark,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('dahab'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color:
                                      isLight ? Colors.black : Colors.white)),
                          Spacer(),
                          Text(
                            "\$200",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: isLight ? Colors.black : Colors.white),
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
                              icon: Icon(Ionicons.chatbubble_ellipses_outline,
                                  color: isLight ? Colors.black : Colors.white),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'rate'.tr(),
                                style: TextStyle(
                                    color:
                                        isLight ? Colors.black : Colors.white,
                                    fontSize: 12),
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
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: isLight
                                ? ColorApp.primaryColor
                                : ColorApp.primaryColorDark,
                            size: 10,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'description'.tr(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: isLight ? Colors.black : Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "egypt’s Hidden Gem ,Dahab is a dream come true for thrill-seekers and nature"
                                " enthusiasts alike. The town is world-renowned for its diving spots, "
                                "particularly the Blue Hole, a bucket-list destination for divers"
                                " drawn to its underwater caves and vibrant marine life."
                            .tr(),
                        style: TextStyle(
                            fontSize: 13,
                            color: isLight ? Colors.black : Colors.white),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: isLight
                                ? ColorApp.primaryColor
                                : ColorApp.primaryColorDark,
                            size: 10,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'photo Gallery'.tr(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: isLight ? Colors.black : Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                      SizedBox(
                        height: 15,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: isLight
                                    ? ColorApp.primaryColor
                                    : ColorApp.primaryColorDark,
                                size: 10,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'show on map'.tr(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        isLight ? Colors.black : Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: isLight
                                ? ColorApp.primaryColor
                                : ColorApp.primaryColorDark,
                            size: 10,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'inclusion'.tr(),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: isLight ? Colors.black : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 4),
                        child: Text(
                          "why book this trip ?".tr(),
                          style: TextStyle(
                              color: isLight ? Colors.black : Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: isLight
                                      ? ColorApp.primaryColor
                                      : ColorApp.primaryColorDark,
                                  size: 6,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    child: Text(
                                  "${inclusionModel[index].label.tr()}",
                                  style: TextStyle(
                                      color: isLight
                                          ? Colors.black
                                          : Colors.white),
                                )),
                              ],
                            ),
                          );
                        },
                        itemCount: inclusionModel.length,
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
                            "book Trip".tr(),
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shadowColor: isLight
                                ? ColorApp.primaryColor
                                : ColorApp.primaryColorDark,
                            backgroundColor: isLight
                                ? ColorApp.primaryColor
                                : ColorApp.primaryColorDark,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Center(
                          child: Text(
                        "what are you waiting for ?".tr(),
                        style: TextStyle(
                            color: isLight ? Colors.black : Colors.white),
                      )),
                      Center(
                          child: Text(
                        "book your trip now.".tr(),
                        style: TextStyle(
                            color: isLight ? Colors.black : Colors.white),
                      )),
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
