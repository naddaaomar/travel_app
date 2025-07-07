

class PaymentMethodesModel {
  String image;
  String id;

  PaymentMethodesModel({required this.image,required this.id});
}

List<PaymentMethodesModel> payModel = [
  PaymentMethodesModel(
    image: 'assets/images/visa.png',
   id: "card"
  ),
  PaymentMethodesModel(
    image: 'assets/images/masterCard.png',
    id: "card"
  ),
  PaymentMethodesModel(
      image: 'assets/images/amex.png',
      id: "card"
  ),
  // PaymentMethodesModel(
  //   image: 'assets/images/instapay.png',
  //  id: card
  // ),
  PaymentMethodesModel(
    image: 'assets/images/vodafone.png',
  id:"wallet" ,
  ),
  PaymentMethodesModel(
    image: 'assets/images/orange.png',
    id:"wallet" ,
  ),
  PaymentMethodesModel(
    image: 'assets/images/we.png',
    id:"wallet" ,
  ),
  PaymentMethodesModel(
    image: 'assets/images/etisalat.png',
    id:"wallet" ,
  ),
  PaymentMethodesModel(
    image: 'assets/images/meeza.png',
    id:"wallet" ,
  ),
  // PaymentMethodesModel(
  //   image: 'assets/images/payPal.png',
  //   id: 4937087,
  // ),
  PaymentMethodesModel(
    image: 'assets/images/aman.png',
    id:"kiosk" ,
  ),
  PaymentMethodesModel(
    image: 'assets/images/masary.jpg',
    id:"kiosk" ,
  ),
];