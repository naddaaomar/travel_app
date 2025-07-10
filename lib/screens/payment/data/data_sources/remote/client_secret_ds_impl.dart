import 'package:injectable/injectable.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/exceptions/exceptions.dart';
import 'package:p/screens/payment/data/data_sources/remote/client_secret_ds.dart';
import 'package:p/screens/payment/data/models/PaymentModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: ClientSecretDs)
class ClientSecretDsImpl implements ClientSecretDs {
  ApiManager apiManager;

  ClientSecretDsImpl(this.apiManager);

  @override
  Future<PaymentModel> clientSecret({
    required num bookingId,
    required String paymentMethod,
    required num amount,
    required String currency,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = await prefs.getString('token');
      var response = await apiManager.postDate(
        endPoint: Constants.paymentEndpoint,
        data: {
          "bookingId": bookingId,
          "paymentMethod": paymentMethod,
          "amount": amount,
          "currency": currency
        },
        headers: {"Authorization": 'Bearer $token'},
      );

      PaymentModel paymentModelResponse = PaymentModel.fromJson(response.data);

      return paymentModelResponse;
    } catch (e) {
      throw ErrorRemoteException(e.toString());
    }
  }
}
