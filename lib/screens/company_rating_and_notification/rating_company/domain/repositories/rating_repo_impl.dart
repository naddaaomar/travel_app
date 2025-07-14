import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import '../../data/data_sources/rating_ds.dart';
import '../../data/model/rating_model.dart';
import 'rating_repo.dart';

@Injectable(as: CompanyRatingRepo)
class CompanyRatingRepoImpl implements CompanyRatingRepo {
  final CompanyRatingDs companyRatingDs;

  CompanyRatingRepoImpl(this.companyRatingDs);

  @override
  Future<Either<ErrorFailures, List<CompanyRatingModel>>> getCompanyRatings(int companyId) async {
    try {
      final ratings = await companyRatingDs.getCompanyRatings(companyId);
      return Right(ratings);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<ErrorFailures, void>> submitRating(CompanyRatingModel rating) async {
    try {
      await companyRatingDs.submitRating(rating);
      return const Right(null);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }
}