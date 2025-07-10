part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentSuccess extends PaymentState {
  PaymentModel paymentModel;

  PaymentSuccess({required this.paymentModel});
}

final class PaymentError extends PaymentState {}