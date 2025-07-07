import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/exceptions/exceptions.dart';
import 'package:p/screens/booking/data/data_sources/remote/booking_ds.dart';
import 'package:p/screens/booking/data/models/BookingModel.dart';

@Injectable(as: BookingDs)
class BookingDsImpl implements BookingDs {
  ApiManager apiManager;

  BookingDsImpl(this.apiManager);
  @override
  Future<BookingModel> booking(
      {required num travelId, required num quantity}) async {
    try {
      var response = await apiManager
          .postDate(endPoint: Constants.bookingEndpoint, headers: {
        "Authorization":
            'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9naXZlbm5hbWUiOiJBLlIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJhckBnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJVc2VyIiwiZXhwIjoxNzUwODYwNzM0LCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo3MTI2IiwiYXVkIjoiTXlTZWN1cmVkQVBJVXNlcnMifQ.hPsUJl68tWwqjafZDWBByjwQu_ZVLZk2vohJlBkYAwE'
      }, data: {
        "travelId": travelId,
        "quantity": quantity
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
      await apiManager.deleteData(
          endPoint: "${Constants.bookingDeleteEndpoint}/$bookingId",
          headers: {
            "Authorization":
                'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9naXZlbm5hbWUiOiJBLlIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJhckBnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJVc2VyIiwiZXhwIjoxNzUwODYwNzM0LCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo3MTI2IiwiYXVkIjoiTXlTZWN1cmVkQVBJVXNlcnMifQ.hPsUJl68tWwqjafZDWBByjwQu_ZVLZk2vohJlBkYAwE'
          });
    } on DioException catch (e) {
      if (e.response == null) {
        print("null");
      }
      print(e.error);
      throw ErrorRemoteException(e.toString());
    }
  }

  @override
  Future<BookingModel> bookingPut(
      {required int bookingId,
      required num travelId,
      required num quantity}) async {
    try {
      var response = await apiManager.postDate(
          endPoint: "${Constants.bookingPutEndpoint}/$bookingId",
          headers: {
            "Authorization":
                'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9naXZlbm5hbWUiOiJBLlIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJhckBnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJVc2VyIiwiZXhwIjoxNzUwODYwNzM0LCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo3MTI2IiwiYXVkIjoiTXlTZWN1cmVkQVBJVXNlcnMifQ.hPsUJl68tWwqjafZDWBByjwQu_ZVLZk2vohJlBkYAwE'
          },
          data: {
            "travelId": travelId,
            "quantity": quantity
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
}
