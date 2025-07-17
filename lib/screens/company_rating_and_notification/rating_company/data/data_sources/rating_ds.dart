import '../model/rating_model.dart';

abstract class CompanyRatingDs {
  Future<void> submitRating(CompanyRatingModel rating);
  Future<List<CompanyRatingModel>> getCompanyRatings(int companyId);
}