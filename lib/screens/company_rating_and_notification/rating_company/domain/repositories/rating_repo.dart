import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import '../../data/model/rating_model.dart';

abstract class CompanyRatingRepo {
  Future<Either<ErrorFailures, void>> submitRating(CompanyRatingModel rating);
  Future<Either<ErrorFailures, List<CompanyRatingModel>>> getCompanyRatings(int companyId);
}