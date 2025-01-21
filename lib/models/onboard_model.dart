import 'package:flutter/material.dart';

class OnboardModel {
  String image, name;

  OnboardModel({required this.image, required this.name});
}

List<OnboardModel> onboarding = [
  OnboardModel(
    image: 'assets/images/onboard4.png',
    name: 'Explore Egypt with us',
  ),
  OnboardModel(
    image: 'assets/images/onboard2.png',
    name: "Natural Beauty of Egypt",
  ),
  OnboardModel(
    image: 'assets/images/onboard3.png',
    name: 'Peaceful Mind in Nature',
  ),
  OnboardModel(
    image: 'assets/images/onboard.png',
    name: 'Bright of originality',
  ),
];