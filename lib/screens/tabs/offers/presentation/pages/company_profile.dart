import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p/helpers/app_bar/app_bar_widget.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/cover_company.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/nums_profile.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/profile_pic.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/social_media_avatar.dart';

class CompanyProfile extends StatelessWidget {
  double coverHeight = 280;
  double profileHeight = 144;

  CompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorApp.primaryColor,
        appBar: appBar(
          lable: "Terhal",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorApp.secondaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: SingleChildScrollView(
                  child: FadeInUp(
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CoverCompany(),
                            ProfilePic(),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Terhal Travel",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 19),
                              ),
                              Text(
                                "Unveil the Wonders of Egypt",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SocialMediaAvatar(
                                    icon: FontAwesomeIcons.linkedin,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  SocialMediaAvatar(
                                    icon: FontAwesomeIcons.facebookMessenger,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  SocialMediaAvatar(
                                    icon: FontAwesomeIcons.x,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  SocialMediaAvatar(
                                    icon: FontAwesomeIcons.infinity,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: .3,
                              ),
                              NumsProfile(),
                              Divider(
                                color: Colors.black,
                                thickness: .3,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "About",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text("""Explore Egypt with Terhal! 🇪🇬✨
                    Discover the beauty of Egypt with expertly planned trips to iconic destinations like the Pyramids, the Nile, and the Red Sea. Whether you seek adventure, relaxation, or cultural experiences, we offer customized itineraries and professional guides for a seamless journey. Let us take you beyond the ordinary and unveil the wonders of Egypt!"""),
                            ],
                          ),
                        )
                      ],
                    ),
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
