
import 'package:p/screens/search/data/models/CompaniesSearchModel.dart';
import 'package:p/screens/search/data/models/EventsSearchModel.dart';
import 'package:p/screens/search/data/models/SearchAllModel.dart';
import 'package:p/screens/search/data/models/TravelsSearchModel.dart';

abstract class SearchDs {
  Future<TravelsSearchModel> searchTravels(String search, int pageSize, int pageIndex);
  Future<List<EventsSearchModel>> searchEvents(String search, int pageSize, int pageIndex);
  Future<CompaniesSearchModel> searchCompanies(String search, int pageSize, int pageIndex);
  Future<SearchAllModel> searchAll(String search, int pageSize, int pageIndex);
}
