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
          {required int integrationId,
          required String phone,
          required String fName,
          required String lName,
          required double amount}) =>
      clientSecretRepo.clientSecret(
          lName: lName,
          integrationId: integrationId,
          fName: fName,
          phone: phone,
          amount: amount);
}
