import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/exceptions/exceptions.dart';
import 'package:p/screens/tabs/home/data/data_sources/remote/home_ds.dart';
import 'package:p/screens/tabs/home/data/models/EventRecommendation.dart';
import 'package:p/screens/tabs/home/data/models/EventsModel.dart';
import 'package:p/screens/tabs/home/data/models/NewestModel.dart';
import 'package:p/screens/tabs/home/data/models/TravelRecommendation.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: HomeDs)
class HomeDsImpl implements HomeDs {
  ApiManager apiManager;

  HomeDsImpl(this.apiManager);

  @override
  Future<NewestModel> getNewest(
      {required int PageSize, required int PageIndex}) async {
    try {
      var response = await apiManager.getData(
          endPoint: "${Constants.travelsEndPoint}/newest",
          query: {"PageSize": "$PageSize", "PageIndex": "$PageIndex"});

      NewestModel newestModel = NewestModel.fromJson(response.data);

      return newestModel;
    } on DioException catch (e) {
      print('DioException caught!');
      print('Type: ${e.type}');
      print('Message: ${e.message}');
      print('Response: ${e.response}');
      print('Status Code: ${e.response?.statusCode}');
      print('Data: ${e.response?.data}');
      print('Request Path: ${e.requestOptions.path}');

      throw ErrorRemoteException(e.toString());
    }
  }

  @override
  Future<List<EventsModel>> getEvents() async {
    try {
      var response = await apiManager.getData(
        endPoint: Constants.eventsEndPoint,
      );

      // Assuming response.data is a List<dynamic>
      List<EventsModel> events = (response.data as List)
          .map((item) => EventsModel.fromJson(item))
          .toList();

      return events;
    } on DioException catch (e) {
      print('DioException caught!');
      print('Type: ${e.type}');
      print('Message: ${e.message}');
      print('Response: ${e.response}');
      print('Status Code: ${e.response?.statusCode}');
      print('Data: ${e.response?.data}');
      print('Request Path: ${e.requestOptions.path}');

      throw ErrorRemoteException(e.toString());
    }
  }

  @override
  Future<List<TravelRecommendation>> getTravelRecommend(
      {
      required int numRecommendations,
      required int numHighestInteractions}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = await prefs.getString('user_id');
      var response = await apiManager.getData(
        endPoint: "/api/Ai/recommend-travels/$userId",
        headers: {
          "userId":"$userId",
          "numRecommendations":"$numRecommendations",
          "numHighestInteractions":"$numHighestInteractions",
        }
      );

      // Assuming response.data is a List<dynamic>
      List<TravelRecommendation> travel = (response.data as List)
          .map((item) => TravelRecommendation.fromJson(item))
          .toList();

      return travel;
    } on DioException catch (e) {
      print('DioException caught!');
      print('Type: ${e.type}');
      print('Message: ${e.message}');
      print('Response: ${e.response}');
      print('Status Code: ${e.response?.statusCode}');
      print('Data: ${e.response?.data}');
      print('Request Path: ${e.requestOptions.path}');

      throw ErrorRemoteException(e.toString());
    }
  }

  @override
  Future<List<EventRecommendation>>getEventRecommend (
      {
      required int numRecommendations,
      required int numHighestInteractions}) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = await prefs.getString('user_id');
      var response = await apiManager.getData(
          endPoint: "/api/Ai/recommend-events/$userId",
          headers: {
            "userId":"$userId",
            "numRecommendations":"$numRecommendations",
            "numHighestInteractions":"$numHighestInteractions",
          }
      );

      // Assuming response.data is a List<dynamic>
      List<EventRecommendation> events = (response.data as List)
          .map((item) => EventRecommendation.fromJson(item))
          .toList();

      return events;
    } on DioException catch (e) {
      print('DioException caught!');
      print('Type: ${e.type}');
      print('Message: ${e.message}');
      print('Response: ${e.response}');
      print('Status Code: ${e.response?.statusCode}');
      print('Data: ${e.response?.data}');
      print('Request Path: ${e.requestOptions.path}');

      throw ErrorRemoteException(e.toString());
    }
  }
}
