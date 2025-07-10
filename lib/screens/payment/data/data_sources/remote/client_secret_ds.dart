import 'package:p/screens/payment/data/models/PaymentModel.dart';

abstract class ClientSecretDs {
  Future<PaymentModel> clientSecret({
    required num bookingId,
    required String paymentMethod,
    required num amount,
    required String currency,
  });
}
