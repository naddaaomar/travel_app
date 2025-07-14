import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/exceptions/exceptions.dart';
import 'package:p/screens/event_details/data/data_source/remote/event_details_ds.dart';
import 'package:p/screens/event_details/data/models/EventDetailsModel.dart';

@Injectable(as: EventDetailsDs)
class EventDetailsDsImpl implements EventDetailsDs {
  ApiManager apiManager;

  EventDetailsDsImpl(this.apiManager);

  @override
  Future<EventDetailsModel> getDetails({required String id}) async {
    try {
      var response = await apiManager.getData(
        endPoint: "${Constants.eventsEndPoint}/$id",
      );

      EventDetailsModel eventDetailsModel =
      EventDetailsModel.fromJson(response.data);

      return eventDetailsModel;
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