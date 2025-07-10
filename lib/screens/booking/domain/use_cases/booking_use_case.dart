import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/booking/data/models/BookingModel.dart';
import 'package:p/screens/booking/data/models/GetBookingModel.dart';
import 'package:p/screens/booking/domain/repositories/booking_repo.dart';

@injectable
class BookingUseCase {
  BookingRepo bookingRepo;

  BookingUseCase(this.bookingRepo);

  Future<Either<ErrorFailures, BookingModel>> callPost({
    required num travelId,
    required num totalQuantity,
    required num childrenUnderFiveNum,
    required String nationalId,
    required String phoneNumber,
  }) =>
      bookingRepo.bookingPost(
          travelId: travelId,
          totalQuantity: totalQuantity,
          phoneNumber: phoneNumber,
          nationalId: nationalId,
          childrenUnderFiveNum: childrenUnderFiveNum);

  Future callDelete({required int bookingId}) =>
      bookingRepo.bookingDelete(bookingId: bookingId);

  Future<Either<ErrorFailures, BookingModel>> callPut(
          {required int bookingId,
          required num travelId,
          required num totalQuantity,
          required num childrenUnderFiveNum,
          required String nationalId,
          required String phoneNumber}) =>
      bookingRepo.bookingPut(
          travelId: travelId,
          bookingId: bookingId,
          childrenUnderFiveNum: childrenUnderFiveNum,
          nationalId: nationalId,
          phoneNumber: phoneNumber,
          totalQuantity: totalQuantity);

  Future<Either<ErrorFailures, List<GetBookingModel>>> callGet() => bookingRepo.bookingGet();
}
