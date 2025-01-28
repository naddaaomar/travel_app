part of 'payment_bloc.dart';

class PaymentResponseState {
  RequestState? clientSecretRequestState;
  String? clientSecretErrorMessage;
  PaymentModel? paymentModel;

  PaymentResponseState(
      {this.clientSecretRequestState,
      this.clientSecretErrorMessage,
      this.paymentModel});

  PaymentResponseState copyWith(
      {RequestState? clientSecretRequestState,
      String? clientSecretErrorMessage,
      RequestState? paymentRequestState,
      String? paymentErrorMessage,
      PaymentModel? paymentModel}) {
    return PaymentResponseState(
        clientSecretRequestState:
            clientSecretRequestState ?? this.clientSecretRequestState,
        clientSecretErrorMessage:
            clientSecretErrorMessage ?? this.clientSecretErrorMessage,
        paymentModel: paymentModel ?? this.paymentModel);
  }
}

final class PaymentInitialState extends PaymentResponseState {
  PaymentInitialState()
      : super(
            clientSecretRequestState: RequestState.init,
            clientSecretErrorMessage: "",
            paymentModel: null);
}
