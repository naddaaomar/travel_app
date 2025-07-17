import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/exceptions/exceptions.dart';
import 'package:p/screens/booking/data/data_sources/remote/booking_ds.dart';
import 'package:p/screens/booking/data/models/BookingModel.dart';
import 'package:p/screens/booking/data/models/GetBookingModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: BookingDs)
class BookingDsImpl implements BookingDs {
  ApiManager apiManager;

  BookingDsImpl(this.apiManager);
  @override
  Future<BookingModel> bookingPost({
    required num travelId,
    required num totalQuantity,
    required num childrenUnderFiveNum,
    required String nationalId,
    required String phoneNumber,
  }) async
  {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = await prefs.getString('token');
      var response = await apiManager
          .postDate(endPoint: Constants.bookingEndpoint, headers: {
        "Authorization": 'Bearer $token'
      }, data: {
        "travelId": travelId,
        "totalQuantity": totalQuantity,
        "childrenUnderFiveNum": childrenUnderFiveNum,
        "nationalId": nationalId,
        "phoneNumber": phoneNumber
      });

      BookingModel bookingModel = BookingModel.fromJson(response.data);

      return bookingModel;
    } on DioException catch (e) {
      if (e.response == null) {
        print("null");
      }
      print(e.error);
      throw ErrorRemoteException(e.toString());
    }
  }

  @override
  Future bookingDelete({required int bookingId}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = await prefs.getString('token');
      await apiManager.deleteData(
        endPoint: "${Constants.bookingDeleteEndpoint}/$bookingId",
        headers: {"Authorization": 'Bearer $token'},
      );
    } on DioException catch (e) {
      if (e.response == null) {
        print("null");
      }
      print(e.error);
      throw ErrorRemoteException(e.toString());
    }
  }

  @override
  Future<BookingModel> bookingPut({
    required int bookingId,
    required num travelId,
    required num totalQuantity,
    required num childrenUnderFiveNum,
    required String nationalId,
    required String phoneNumber,
  }) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = await prefs.getString('token');
    try {
      var response = await apiManager.putData(
          endPoint: "${Constants.bookingPutEndpoint}/$bookingId",
          headers: {
            "Authorization": 'Bearer $token'
          },
          data: {
            "travelId": travelId,
            "totalQuantity": totalQuantity,
            "childrenUnderFiveNum": childrenUnderFiveNum,
            "nationalId": nationalId,
            "phoneNumber": phoneNumber
          });

      BookingModel bookingModel = BookingModel.fromJson(response.data);

      return bookingModel;
    } on DioException catch (e) {
      if (e.response == null) {
        print("null");
      }
      print(e.error);
      throw ErrorRemoteException(e.toString());
    }
  }

  @override
  Future<List<GetBookingModel>> bookingGet() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = await prefs.getString('token');

      var response = await apiManager.getData(
        endPoint: Constants.bookingEndpoint,
        headers: {"Authorization": 'Bearer $token'},
      );

      // Assuming response.data is a List of booking JSON objects
      List<GetBookingModel> bookings = (response.data as List)
          .map((item) => GetBookingModel.fromJson(item))
          .toList();

      return bookings;
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
