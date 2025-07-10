/// id : 1
/// buyerEmail : "a@gmail.com"
/// bookingDate : "2025-05-17T15:35:01.0219846+00:00"
/// status : "Pending"
/// bookingItem : {"travelId":2,"title":"Alpine Adventure","travelProfileUrl":"https://i.pinimg.com/736x/14/7f/ea/147fea20f16d94e7960d2bd3b507fd2e.jpg","price":950.00,"quantity":1}
/// totalCost : 950.00
/// paymentIntentId : " "

class BookingModel {
  BookingModel({
    num? id,
    String? buyerEmail,
    String? bookingDate,
    String? status,
    BookingItem? bookingItem,
    num? totalCost,
    String? paymentIntentId,}){
    _id = id;
    _buyerEmail = buyerEmail;
    _bookingDate = bookingDate;
    _status = status;
    _bookingItem = bookingItem;
    _totalCost = totalCost;
    _paymentIntentId = paymentIntentId;
  }

  BookingModel.fromJson(dynamic json) {
    _id = json['id'];
    _buyerEmail = json['buyerEmail'];
    _bookingDate = json['bookingDate'];
    _status = json['status'];
    _bookingItem = json['bookingItem'] != null ? BookingItem.fromJson(json['bookingItem']) : null;
    _totalCost = json['totalCost'];
    _paymentIntentId = json['paymentIntentId'];
  }
  num? _id;
  String? _buyerEmail;
  String? _bookingDate;
  String? _status;
  BookingItem? _bookingItem;
  num? _totalCost;
  String? _paymentIntentId;
  BookingModel copyWith({  num? id,
    String? buyerEmail,
    String? bookingDate,
    String? status,
    BookingItem? bookingItem,
    num? totalCost,
    String? paymentIntentId,
  }) => BookingModel(  id: id ?? _id,
    buyerEmail: buyerEmail ?? _buyerEmail,
    bookingDate: bookingDate ?? _bookingDate,
    status: status ?? _status,
    bookingItem: bookingItem ?? _bookingItem,
    totalCost: totalCost ?? _totalCost,
    paymentIntentId: paymentIntentId ?? _paymentIntentId,
  );
  num? get id => _id;
  String? get buyerEmail => _buyerEmail;
  String? get bookingDate => _bookingDate;
  String? get status => _status;
  BookingItem? get bookingItem => _bookingItem;
  num? get totalCost => _totalCost;
  String? get paymentIntentId => _paymentIntentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['buyerEmail'] = _buyerEmail;
    map['bookingDate'] = _bookingDate;
    map['status'] = _status;
    if (_bookingItem != null) {
      map['bookingItem'] = _bookingItem?.toJson();
    }
    map['totalCost'] = _totalCost;
    map['paymentIntentId'] = _paymentIntentId;
    return map;
  }

}

/// travelId : 2
/// title : "Alpine Adventure"
/// travelProfileUrl : "https://i.pinimg.com/736x/14/7f/ea/147fea20f16d94e7960d2bd3b507fd2e.jpg"
/// price : 950.00
/// quantity : 1

class BookingItem {
  BookingItem({
    num? travelId,
    String? title,
    String? travelProfileUrl,
    num? price,
    num? quantity,}){
    _travelId = travelId;
    _title = title;
    _travelProfileUrl = travelProfileUrl;
    _price = price;
    _quantity = quantity;
  }

  BookingItem.fromJson(dynamic json) {
    _travelId = json['travelId'];
    _title = json['title'];
    _travelProfileUrl = json['travelProfileUrl'];
    _price = json['price'];
    _quantity = json['quantity'];
  }
  num? _travelId;
  String? _title;
  String? _travelProfileUrl;
  num? _price;
  num? _quantity;
  BookingItem copyWith({  num? travelId,
    String? title,
    String? travelProfileUrl,
    num? price,
    num? quantity,
  }) => BookingItem(  travelId: travelId ?? _travelId,
    title: title ?? _title,
    travelProfileUrl: travelProfileUrl ?? _travelProfileUrl,
    price: price ?? _price,
    quantity: quantity ?? _quantity,
  );
  num? get travelId => _travelId;
  String? get title => _title;
  String? get travelProfileUrl => _travelProfileUrl;
  num? get price => _price;
  num? get quantity => _quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['travelId'] = _travelId;
    map['title'] = _title;
    map['travelProfileUrl'] = _travelProfileUrl;
    map['price'] = _price;
    map['quantity'] = _quantity;
    return map;
  }

}