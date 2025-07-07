import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';

abstract class AllTravelsLocalDs {
  Future<void> cacheTravels(AllTravelsModel travels);
  Future<AllTravelsModel?> getCachedTravels();
}
