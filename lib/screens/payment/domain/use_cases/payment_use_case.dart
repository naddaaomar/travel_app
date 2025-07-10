import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/payment/data/models/PaymentModel.dart';
import 'package:p/screens/payment/domain/repositories/client_secret_repo.dart';

@injectable
class PaymentUseCase {
  ClientSecretRepo clientSecretRepo;

  PaymentUseCase(this.clientSecretRepo);

  Future<Either<ErrorFailures, PaymentModel>> call(
      {
        required num bookingId,
        required String paymentMethod,
        required num amount,
        required String currency,
      }) =>
      clientSecretRepo.clientSecret(
          bookingId: bookingId,
          paymentMethod: paymentMethod,
          amount: amount,
          currency: currency
      );
}