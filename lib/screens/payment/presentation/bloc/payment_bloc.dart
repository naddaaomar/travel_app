import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/enums/enums.dart';
import 'package:p/screens/payment/data/models/PaymentModel.dart';
import 'package:p/screens/payment/domain/use_cases/payment_use_case.dart';

part 'payment_event.dart';

part 'payment_state.dart';
/*
@injectable
class PaymentBloc extends Bloc<PaymentEvent, PaymentResponseState> {
  PaymentUseCase? paymentUseCase;

  PaymentBloc(this.paymentUseCase) : super(PaymentInitialState()) {
    on<PaymentEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ClientSecretEvent>((event, emit) async {
      emit(state.copyWith(
          clientSecretRequestState: RequestState.loading,
          clientSecretErrorMessage: null));
      var response = await paymentUseCase!.call(
          integrationId: event.integrationId,
          amount: event.amount,
          phone: event.phone,
          fName: event.fName,
          lName: event.lName);
      response.fold((l) {
        emit(state.copyWith(
            clientSecretRequestState: RequestState.error,
            clientSecretErrorMessage: "something went wrong"));
        print(l.toString());
      }, (r) {
        emit(state.copyWith(
            clientSecretRequestState: RequestState.success, paymentModel: r));
        print("//////////////////////////////");
      });
    });
  }
}


 */