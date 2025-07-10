import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/search/data/data_sources/remote/search_ds.dart';
import 'package:p/screens/search/data/models/CompaniesSearchModel.dart';
import 'package:p/screens/search/data/models/EventsSearchModel.dart';
import 'package:p/screens/search/data/models/SearchAllModel.dart';
import 'package:p/screens/search/data/models/TravelsSearchModel.dart';
import 'package:p/screens/search/domain/repositories/search_repo.dart';

@LazySingleton(as: SearchRepo)
class SearchRepoImpl implements SearchRepo {
  final SearchDs searchDs;

  SearchRepoImpl(this.searchDs);

  @override
  Future<Either<ErrorFailures, TravelsSearchModel>> searchTravels(
    String query,
    int pageSize,
    int pageIndex,
  ) async {
    try {
      final result = await searchDs.searchTravels(query, pageSize, pageIndex);
      return Right(result);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<ErrorFailures, List<EventsSearchModel>>> searchEvents(
    String query,
    int pageSize,
    int pageIndex,
  ) async {
    try {
      final result = await searchDs.searchEvents(query, pageSize, pageIndex);
      return Right(result);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<ErrorFailures, CompaniesSearchModel>> searchCompanies(
    String query,
    int pageSize,
    int pageIndex,
  ) async {
    try {
      final result = await searchDs.searchCompanies(query, pageSize, pageIndex);
      return Right(result);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<ErrorFailures, SearchAllModel>> searchAll(
    String query,
    int pageSize,
    int pageIndex,
  ) async {
    try {
      final result = await searchDs.searchAll(query, pageSize, pageIndex);
      return Right(result);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }
}
