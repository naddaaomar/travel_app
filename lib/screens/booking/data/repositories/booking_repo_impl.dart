import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/booking/data/data_sources/remote/booking_ds.dart';
import 'package:p/screens/booking/data/models/BookingModel.dart';
import 'package:p/screens/booking/data/models/GetBookingModel.dart';
import 'package:p/screens/booking/domain/repositories/booking_repo.dart';

@Injectable(as: BookingRepo)
class BookingRepoImpl implements BookingRepo {
  BookingDs bookingDs;

  BookingRepoImpl(this.bookingDs);

  @override
  Future<Either<ErrorFailures, BookingModel>> bookingPost({
    required num travelId,
    required num totalQuantity,
    required num childrenUnderFiveNum,
    required String nationalId,
    required String phoneNumber,
  }) async {
    try {
      var data = await bookingDs.bookingPost(
          travelId: travelId,
          childrenUnderFiveNum: childrenUnderFiveNum,
          nationalId: nationalId,
          phoneNumber: phoneNumber,
          totalQuantity: totalQuantity);
      return Right(data);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }

  @override
  Future bookingDelete({required int bookingId}) async {
    try {
      await bookingDs.bookingDelete(bookingId: bookingId);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<Either<ErrorFailures, BookingModel>> bookingPut(
      {required int bookingId,
      required num travelId,
      required num totalQuantity,
      required num childrenUnderFiveNum,
      required String nationalId,
      required String phoneNumber}) async {
    try {
      var data = await bookingDs.bookingPut(
          bookingId: bookingId,
          travelId: travelId,
          totalQuantity: totalQuantity,
          phoneNumber: phoneNumber,
          nationalId: nationalId,
          childrenUnderFiveNum: childrenUnderFiveNum);
      return Right(data);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<ErrorFailures, List<GetBookingModel>>> bookingGet() async {
    try {
      var data = await bookingDs.bookingGet();
      return Right(data);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }
}
