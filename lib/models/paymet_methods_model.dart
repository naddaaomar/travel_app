import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:p/main.dart';

class PaymentMethodesModel {
  String image;
  int id;

  PaymentMethodesModel({required this.image,required this.id});
}

List<PaymentMethodesModel> payModel = [
  PaymentMethodesModel(
    image: 'assets/images/visa.png',
   id: 4936791
  ),
  PaymentMethodesModel(
    image: 'assets/images/masterCard.png',
    id: 4936791
  ),
  PaymentMethodesModel(
    image: 'assets/images/instapay.png',
   id: 4936791
  ),
  PaymentMethodesModel(
    image: 'assets/images/vodafone.png',
  id:4937089 ,
  ),
  PaymentMethodesModel(
    image: 'assets/images/payPal.png',
    id: 4937087,
  ),
];