import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import '../../data/model/rating_model.dart';
import '../repositories/rating_repo.dart';

@injectable
class CompanyRatingUseCase {
  final CompanyRatingRepo companyRatingRepo;

  CompanyRatingUseCase(this.companyRatingRepo);

  Future<Either<ErrorFailures, void>> submitRating(CompanyRatingModel rating) {
    return companyRatingRepo.submitRating(rating);
  }

  Future<Either<ErrorFailures, List<CompanyRatingModel>>> getCompanyRatings(int companyId) {
    return companyRatingRepo.getCompanyRatings(companyId);
  }
}