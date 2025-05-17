

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
      image: 'assets/images/amex.png',
      id: 4936791
  ),
  // PaymentMethodesModel(
  //   image: 'assets/images/instapay.png',
  //  id: 4936791
  // ),
  PaymentMethodesModel(
    image: 'assets/images/vodafone.png',
  id:4937089 ,
  ),
  PaymentMethodesModel(
    image: 'assets/images/orange.png',
    id:4937089 ,
  ),
  PaymentMethodesModel(
    image: 'assets/images/we.png',
    id:4937089 ,
  ),
  PaymentMethodesModel(
    image: 'assets/images/etisalat.png',
    id:4937089 ,
  ),
  PaymentMethodesModel(
    image: 'assets/images/meeza.png',
    id:4937089 ,
  ),
  // PaymentMethodesModel(
  //   image: 'assets/images/payPal.png',
  //   id: 4937087,
  // ),
  PaymentMethodesModel(
    image: 'assets/images/aman.png',
    id:4936833 ,
  ),
  PaymentMethodesModel(
    image: 'assets/images/masary.jpg',
    id:4936833 ,
  ),
];