import 'package:p/screens/booking/data/models/BookingModel.dart';

abstract class BookingDs {
  Future<BookingModel> booking({
    required num travelId,
    required num quantity,
  });
  Future<BookingModel> bookingPut({
    required int bookingId,
    required num travelId,
    required num quantity,
  });
  Future bookingDelete({
    required int bookingId,
  });
}