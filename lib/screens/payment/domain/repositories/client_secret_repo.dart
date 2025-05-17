import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/payment/data/models/PaymentModel.dart';

abstract class ClientSecretRepo {
  Future<Either<ErrorFailures, PaymentModel>> clientSecret(
      {
        required num bookingId,
        required String paymentMethod,
        required num amount,
        required String currency,
      });
}
