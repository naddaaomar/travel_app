import 'package:p/screens/payment/data/models/PaymentModel.dart';

abstract class ClientSecretDs {
  Future<PaymentModel> clientSecret(
      {required int integrationId,
      required String phone,
      required String fName,
      required String lName,
      required double amount});
}
