
import 'package:p/screens/tabs/home/data/models/EventRecommendation.dart';
import 'package:p/screens/tabs/home/data/models/TravelRecommendation.dart';

abstract class RecommendationLocalDs {
  Future<void> cacheTravelRecommendations(List<TravelRecommendation> recommendations);
  Future<List<TravelRecommendation>?> getCachedTravelRecommendations();

  Future<void> cacheEventRecommendations(List<EventRecommendation> recommendations);
  Future<List<EventRecommendation>?> getCachedEventRecommendations();
}
