import 'package:easy_localization/easy_localization.dart';
import 'package:p/main.dart';

class RecommendedPlaceModel {
  final String image;
  final String date;
  final String location;
  RecommendedPlaceModel({
    required this.image,
    required this.date,
    required this.location,
  });
}


List<RecommendedPlaceModel> recommendedPlaces = [
RecommendedPlaceModel(
  image: 'assets/images/onboard.png',
  date: '7/7/2025',
  location: 'event'.tr(),
 ),
  RecommendedPlaceModel(
    image: 'assets/images/onboard.png',
    date: '7/7/2025',
    location: 'event'.tr(),
  ),
  RecommendedPlaceModel(
    image: 'assets/images/onboard.png',
    date: '7/7/2025',
    location: 'event'.tr(),
  ),
  RecommendedPlaceModel(
    image: 'assets/images/onboard.png',
    date: '7/7/2025',
    location: 'event'.tr(),
  ),
];