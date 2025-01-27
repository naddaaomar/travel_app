import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/payment/data/data_sources/remote/client_secret_ds.dart';
import 'package:p/screens/payment/data/models/PaymentModel.dart';
import 'package:p/screens/payment/domain/repositories/client_secret_repo.dart';

@Injectable(as: ClientSecretRepo)
class ClientSecretRepoImpl implements ClientSecretRepo {
  ClientSecretDs clientSecretDs;

  ClientSecretRepoImpl(this.clientSecretDs);

  @override
  Future<Either<ErrorFailures, PaymentModel>> clientSecret(
      {required int integrationId,
      required String phone,
      required String fName,
      required String lName,
      required double amount}) async {
    try {
      var data = await clientSecretDs.clientSecret(
          phone: phone,
          fName: fName,
          integrationId: integrationId,
          lName: lName,
          amount: amount);
      return Right(data);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }
}
