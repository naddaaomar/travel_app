import 'package:easy_localization/easy_localization.dart';
import 'package:p/main.dart';

class RecommendedPlaceModel {
  final String image;
  final double rating;
  final String location;
  RecommendedPlaceModel({
    required this.image,
    required this.rating,
    required this.location,
  });
}


List<RecommendedPlaceModel> recommendedPlaces = [
RecommendedPlaceModel(
  image: 'assets/images/onboard3.png',
  rating: 4.4,
  location: 'taba'.tr(),
 ),
  RecommendedPlaceModel(
    image: 'assets/images/onboard3.png',
    rating: 4.4,
    location: 'taba'.tr(),
  ),
  RecommendedPlaceModel(
    image: 'assets/images/onboard3.png',
    rating: 4.4,
    location: 'taba'.tr(),
  ),
  RecommendedPlaceModel(
    image: 'assets/images/onboard3.png',
    rating: 4.4,
    location: 'taba'.tr(),
  ),
];