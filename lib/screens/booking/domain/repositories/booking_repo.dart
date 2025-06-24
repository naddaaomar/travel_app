import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/booking/data/models/BookingModel.dart';
import 'package:p/screens/payment/data/models/PaymentModel.dart';

abstract class BookingRepo {
  Future<Either<ErrorFailures, BookingModel>> Booking(
      {
        //required String buyerEmail,
        required num travelId,
        required num quantity,
      }
      );
}
