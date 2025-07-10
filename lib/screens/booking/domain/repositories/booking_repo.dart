import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/booking/data/models/BookingModel.dart';
import 'package:p/screens/booking/data/models/GetBookingModel.dart';

abstract class BookingRepo {
  Future<Either<ErrorFailures, BookingModel>> bookingPost({
    required num travelId,
    required num totalQuantity,
    required num childrenUnderFiveNum,
    required String nationalId,
    required String phoneNumber,
  });
  Future bookingDelete({required int bookingId});
  Future<Either<ErrorFailures, BookingModel>> bookingPut({
    required int bookingId,
    required num travelId,
    required num totalQuantity,
    required num childrenUnderFiveNum,
    required String nationalId,
    required String phoneNumber
  });
  Future<Either<ErrorFailures, List<GetBookingModel>>> bookingGet();
}
