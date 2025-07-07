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
  Future<PaymentModel> clientSecret({
    required num bookingId,
    required String paymentMethod,
    required num amount,
    required String currency,
  }) async {
    try {
      var response =
          await apiManager.postDate(endPoint: Constants.paymentEndpoint, data: {
        "bookingId": bookingId,
        "paymentMethod": paymentMethod,
        "amount": amount,
        "currency": currency
      }
      ,headers: {
            "Authorization":'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9naXZlbm5hbWUiOiJBLlIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJhckBnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJVc2VyIiwiZXhwIjoxNzUwODYwNzM0LCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo3MTI2IiwiYXVkIjoiTXlTZWN1cmVkQVBJVXNlcnMifQ.hPsUJl68tWwqjafZDWBByjwQu_ZVLZk2vohJlBkYAwE'
          },
          );

      PaymentModel paymentModelResponse = PaymentModel.fromJson(response.data);

      return paymentModelResponse;
    } catch (e) {
      throw ErrorRemoteException(e.toString());
    }
  }
}
