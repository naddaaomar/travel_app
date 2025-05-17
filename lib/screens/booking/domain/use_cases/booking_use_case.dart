import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/booking/data/models/BookingModel.dart';
import 'package:p/screens/booking/domain/repositories/booking_repo.dart';
import 'package:p/screens/payment/data/models/PaymentModel.dart';
import 'package:p/screens/payment/domain/repositories/client_secret_repo.dart';

@injectable
class BookingUseCase {
  BookingRepo bookingRepo;

  BookingUseCase(this.bookingRepo);

  Future<Either<ErrorFailures, BookingModel>> call(
      {required String buyerEmail,
        required int travelId,
        required int quantity,
      }
      ) =>
      bookingRepo.Booking(
      buyerEmail: buyerEmail,
        quantity: quantity,
        travelId: travelId
      );
}
