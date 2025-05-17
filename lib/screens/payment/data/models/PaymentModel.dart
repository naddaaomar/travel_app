/// success : true
/// paymentUrl : "string"
/// transactionId : "string"
/// message : "string"

class PaymentModel {
  PaymentModel({
      bool? success, 
      String? paymentUrl, 
      String? transactionId, 
      String? message,}){
    _success = success;
    _paymentUrl = paymentUrl;
    _transactionId = transactionId;
    _message = message;
}

  PaymentModel.fromJson(dynamic json) {
    _success = json['success'];
    _paymentUrl = json['paymentUrl'];
    _transactionId = json['transactionId'];
    _message = json['message'];
  }
  bool? _success;
  String? _paymentUrl;
  String? _transactionId;
  String? _message;
PaymentModel copyWith({  bool? success,
  String? paymentUrl,
  String? transactionId,
  String? message,
}) => PaymentModel(  success: success ?? _success,
  paymentUrl: paymentUrl ?? _paymentUrl,
  transactionId: transactionId ?? _transactionId,
  message: message ?? _message,
);
  bool? get success => _success;
  String? get paymentUrl => _paymentUrl;
  String? get transactionId => _transactionId;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['paymentUrl'] = _paymentUrl;
    map['transactionId'] = _transactionId;
    map['message'] = _message;
    return map;
  }

}