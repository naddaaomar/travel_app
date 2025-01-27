import 'package:injectable/injectable.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/exceptions/exceptions.dart';
import 'package:p/screens/payment/data/data_sources/remote/client_secret_ds.dart';
import 'package:p/screens/payment/data/models/PaymentModel.dart';

@Injectable(as: ClientSecretDs)
class ClientSecretDsImpl implements ClientSecretDs {
  ApiManager apiManager;

  ClientSecretDsImpl(this.apiManager);

  @override
  Future<PaymentModel> clientSecret(
      {required int integrationId,
      required String phone,
      required String fName,
      required String lName,
      required double amount}) async {
    try {
      var response = await apiManager
          .postDate(endPoint: Constants.clientEndpoint, headers: {
        "Authorization": Constants.Authorization
      }, data: {
        "amount": amount,
        "currency": "EGP",
        "payment_methods": [integrationId],
        "items": [
          {"name": "Item name", "amount": amount}
        ],
        "billing_data": {
          "first_name": fName,
          "last_name": lName,
          "phone_number": phone
        }
      });

      PaymentModel paymentModelResponse = PaymentModel.fromJson(response.data);

      return paymentModelResponse;
    } catch (e) {
      throw ErrorRemoteException(e.toString());
    }
  }
}
