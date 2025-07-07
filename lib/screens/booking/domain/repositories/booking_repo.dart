import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/booking/data/models/BookingModel.dart';

abstract class BookingRepo {
  Future<Either<ErrorFailures, BookingModel>> Booking({
    required num travelId,
    required num quantity,
  });
  Future BookingDelete({required int bookingId});
  Future<Either<ErrorFailures, BookingModel>> BookingPut({
    required int bookingId,
    required num travelId,
    required num quantity,
  });
}
