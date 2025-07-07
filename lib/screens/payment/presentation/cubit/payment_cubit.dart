import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/payment/data/models/PaymentModel.dart';
import 'package:p/screens/payment/domain/use_cases/payment_use_case.dart';

part 'payment_state.dart';
@injectable
class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({required this.paymentUseCase}) : super(PaymentInitial());
  PaymentUseCase paymentUseCase;

  static PaymentCubit get(context) => BlocProvider.of(context);

  paymentMethod(
      {required num bookingId,
      required String paymentMethod,
      required num amount,
      required String currency}) async {
    emit(PaymentLoading());
    var payment = await paymentUseCase.call(
        bookingId: bookingId,
        paymentMethod: paymentMethod,
        amount: amount,
        currency: currency);
    payment.fold(
      (l) {
        emit(PaymentError());
        print(l);
        print(l);
        print(l);
        print(l);
      },
      (r) {
        emit(PaymentSuccess(paymentModel: r));
        print(r.paymentUrl);
        print(r.paymentUrl);
        print(r.paymentUrl);
        print(r.paymentUrl);
        print(r.paymentUrl);
      },
    );
  }
}
