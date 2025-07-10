import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:p/main.dart';

class OnboardModel {
  String image, name;

  OnboardModel({required this.image, required this.name});
}

List<OnboardModel> onboarding = [
  OnboardModel(
    image: 'assets/images/onboard4.png',
    name: 'explore Egypt with us'.tr(),
  ),
  OnboardModel(
    image: 'assets/images/no_image.png',
    name: "natural Beauty of Egypt".tr(),
  ),
  OnboardModel(
    image: 'assets/images/onboard3.png',
    name: 'peaceful Mind in Nature'.tr(),
  ),
  OnboardModel(
    image: 'assets/images/onboard.png',
    name: 'bright of originality'.tr(),
  ),
];