import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/booking/data/models/BookingModel.dart';
import 'package:p/screens/booking/domain/repositories/booking_repo.dart';

@injectable
class BookingUseCase {
  BookingRepo bookingRepo;

  BookingUseCase(this.bookingRepo);

  Future<Either<ErrorFailures, BookingModel>> call({
    required num travelId,
    required num quantity,
  }) =>
      bookingRepo.Booking(quantity: quantity, travelId: travelId);

  Future callDelete({required int bookingId}) =>
      bookingRepo.BookingDelete(bookingId: bookingId);

  Future<Either<ErrorFailures, BookingModel>> callPut({
    required int bookingId,
    required num travelId,
    required num quantity,
  }) =>
      bookingRepo.BookingPut(
          quantity: quantity, travelId: travelId, bookingId: bookingId);
}