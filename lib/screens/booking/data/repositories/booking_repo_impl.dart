import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/booking/data/data_sources/remote/booking_ds.dart';
import 'package:p/screens/booking/data/models/BookingModel.dart';
import 'package:p/screens/booking/domain/repositories/booking_repo.dart';

@Injectable(as: BookingRepo)
class BookingRepoImpl implements BookingRepo {
  BookingDs bookingDs;

  BookingRepoImpl(this.bookingDs);

  @override
  Future<Either<ErrorFailures, BookingModel>> Booking(
      {
      required num travelId,
      required num quantity}) async {
    try {
      var data = await bookingDs.booking(
          travelId: travelId,
          quantity: quantity);
      return Right(data);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }

  @override
  Future BookingDelete({required int bookingId}) async {
    try {
      await bookingDs.bookingDelete(bookingId: bookingId);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<Either<ErrorFailures, BookingModel>> BookingPut(
      {required int bookingId,
      required num travelId,
      required num quantity}) async {
    try {
      var data = await bookingDs.bookingPut(
          bookingId: bookingId, travelId: travelId, quantity: quantity);
      return Right(data);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }
}
