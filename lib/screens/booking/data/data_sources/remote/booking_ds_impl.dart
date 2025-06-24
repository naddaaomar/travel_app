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
      {

      required num travelId,
      required num quantity}) async {
    try {
      var response = await apiManager.postDate(
          endPoint: Constants.bookingEndpoint,headers: {
            "Authorization":'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9naXZlbm5hbWUiOiJhIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiYUBnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJVc2VyIiwiZXhwIjoxNzQ3NTgyNDg3LCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo3MTI2IiwiYXVkIjoiTXlTZWN1cmVkQVBJVXNlcnMifQ.pET0WilAJMW2X09Fo1dIRY143OjUiU5wzaQSJICW3NM'
      },
          data: {
          //  "buyerEmail": buyerEmail,
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
