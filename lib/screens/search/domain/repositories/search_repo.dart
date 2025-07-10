import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/search/data/models/CompaniesSearchModel.dart';
import 'package:p/screens/search/data/models/EventsSearchModel.dart';
import 'package:p/screens/search/data/models/SearchAllModel.dart';
import 'package:p/screens/search/data/models/TravelsSearchModel.dart';


abstract class SearchRepo {
  Future<Either<ErrorFailures, TravelsSearchModel>> searchTravels(String query, int pageSize, int pageIndex);
  Future<Either<ErrorFailures, List<EventsSearchModel>>> searchEvents(String query, int pageSize, int pageIndex);
  Future<Either<ErrorFailures, CompaniesSearchModel>> searchCompanies(String query, int pageSize, int pageIndex);
  Future<Either<ErrorFailures, SearchAllModel>> searchAll(String query, int pageSize, int pageIndex);
}
