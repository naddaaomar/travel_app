import 'package:injectable/injectable.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/screens/search/data/data_sources/remote/search_ds.dart';
import 'package:p/screens/search/data/models/CompaniesSearchModel.dart';
import 'package:p/screens/search/data/models/EventsSearchModel.dart';
import 'package:p/screens/search/data/models/SearchAllModel.dart';
import 'package:p/screens/search/data/models/TravelsSearchModel.dart';

@Injectable(as: SearchDs)
class SearchDsImpl implements SearchDs {
  final ApiManager apiManager;

  SearchDsImpl(this.apiManager);

  static const String _endpoint = "/api/Search";

  @override
  Future<TravelsSearchModel> searchTravels(
      String search, int pageSize, int pageIndex) async {
    final response = await apiManager.getData(
      endPoint: _endpoint,
      query: {
        'type': 'Travels',
        'Search': search,
        'PageSize': pageSize,
        'PageIndex': pageIndex,
      },
    );

    return  TravelsSearchModel.fromJson(response.data);
  }

  @override
  Future<List<EventsSearchModel>> searchEvents(
      String search, int pageSize, int pageIndex) async {
    final response = await apiManager.getData(
      endPoint: _endpoint,
      query: {
        'type': 'Events',
        'Search': search,
        'PageSize': pageSize,
        'PageIndex': pageIndex,
      },
    );
    List<EventsSearchModel> events = (response.data as List)
        .map((item) => EventsSearchModel.fromJson(item))
        .toList();

    return events;
  }

  @override
  Future<CompaniesSearchModel> searchCompanies(
      String search, int pageSize, int pageIndex) async {
    final response = await apiManager.getData(
      endPoint: _endpoint,
      query: {
        'type': 'Companies',
        'Search': search,
        'PageSize': pageSize,
        'PageIndex': pageIndex,
      },
    );

    return  CompaniesSearchModel.fromJson(response.data);
  }

  @override
  Future<SearchAllModel> searchAll(
      String search, int pageSize, int pageIndex) async {
    final response = await apiManager.getData(
      endPoint: _endpoint,
      query: {
        'Search': search,
        'PageSize': pageSize,
        'PageIndex': pageIndex,
      },
    );

    return  SearchAllModel.fromJson(response.data);
  }
}
