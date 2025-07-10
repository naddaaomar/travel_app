import 'package:p/screens/booking/data/models/BookingModel.dart';
import 'package:p/screens/booking/data/models/GetBookingModel.dart';

abstract class BookingDs {
  Future<BookingModel> bookingPost({
    required num travelId,
    required num totalQuantity,
    required num childrenUnderFiveNum,
    required String nationalId,
    required String phoneNumber,
  });
  Future<BookingModel> bookingPut({
    required int bookingId,
    required num travelId,
    required num totalQuantity,
    required num childrenUnderFiveNum,
    required String nationalId,
    required String phoneNumber
  });
  Future bookingDelete({
    required int bookingId,
  });
  Future<List<GetBookingModel>> bookingGet();
}
