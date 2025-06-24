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
        //required String buyerEmail,
      required num travelId,
      required num quantity}) async {
    try {
      var data = await bookingDs.booking(
          //buyerEmail: buyerEmail,
          travelId: travelId, quantity: quantity);
      return Right(data);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }
}
