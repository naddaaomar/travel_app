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
      {required String buyerEmail,
      required int travelId,
      required int quantity}) async {
    try {
      var response = await apiManager.postDate(
          endPoint: Constants.bookingEndpoint,
          data: {
            "buyerEmail": buyerEmail,
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
