part of 'payment_bloc.dart';

abstract class PaymentEvent {}

class ClientSecretEvent extends PaymentEvent {
  int integrationId;
  String phone;
  String fName;
  String lName;
  double amount;

  ClientSecretEvent(
      {required this.integrationId,
      required this.phone,
      required this.fName,
      required this.lName,
      required this.amount});
}
