import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/search/data/models/CompaniesSearchModel.dart';
import 'package:p/screens/search/data/models/EventsSearchModel.dart';
import 'package:p/screens/search/data/models/SearchAllModel.dart';
import 'package:p/screens/search/data/models/TravelsSearchModel.dart';
import 'package:p/screens/search/domain/repositories/search_repo.dart';

@injectable
class SearchUseCase {
  final SearchRepo searchRepo;

  SearchUseCase(this.searchRepo);

  Future<Either<ErrorFailures, TravelsSearchModel>> searchTravels({
    required String query,
    required int pageSize,
    required int pageIndex,
  }) {
    return searchRepo.searchTravels(query, pageSize, pageIndex);
  }

  Future<Either<ErrorFailures, List<EventsSearchModel>>> searchEvents({
    required String query,
    required int pageSize,
    required int pageIndex,
  }) {
    return searchRepo.searchEvents(query, pageSize, pageIndex);
  }

  Future<Either<ErrorFailures, CompaniesSearchModel>> searchCompanies({
    required String query,
    required int pageSize,
    required int pageIndex,
  }) {
    return searchRepo.searchCompanies(query, pageSize, pageIndex);
  }

  Future<Either<ErrorFailures, SearchAllModel>> searchAll({
    required String query,
    required int pageSize,
    required int pageIndex,
  }) {
    return searchRepo.searchAll(query, pageSize, pageIndex);
  }
}
