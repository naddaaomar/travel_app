import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/exceptions/exceptions.dart';
import 'package:p/screens/tabs/home/data/models/EventsModel.dart';
import 'package:p/screens/view_all_events/data/data_sources/remote/all_events_ds.dart';

@Injectable(as: AllEventsDs)
class AllEventsDsImpl implements AllEventsDs {
  ApiManager apiManager;

  AllEventsDsImpl(this.apiManager);

  @override
  Future<List<EventsModel>> getEvents() async {
    try {
      var response = await apiManager.getData(
        endPoint: Constants.eventsEndPoint,
      );

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
}
