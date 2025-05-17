/// id : 0
/// buyerEmail : "string"
/// bookingDate : "2025-05-17T09:15:33.711Z"
/// status : 0
/// item : {"travelItemBooked":{"travelId":0,"title":"string","travelProfileUrl":"string"},"price":0,"quantity":0}
/// totalCost : 0
/// paymentIntentId : "string"

class BookingModel {
  BookingModel({
      num? id, 
      String? buyerEmail, 
      String? bookingDate, 
      num? status, 
      Item? item, 
      num? totalCost, 
      String? paymentIntentId,}){
    _id = id;
    _buyerEmail = buyerEmail;
    _bookingDate = bookingDate;
    _status = status;
    _item = item;
    _totalCost = totalCost;
    _paymentIntentId = paymentIntentId;
}

  BookingModel.fromJson(dynamic json) {
    _id = json['id'];
    _buyerEmail = json['buyerEmail'];
    _bookingDate = json['bookingDate'];
    _status = json['status'];
    _item = json['item'] != null ? Item.fromJson(json['item']) : null;
    _totalCost = json['totalCost'];
    _paymentIntentId = json['paymentIntentId'];
  }
  num? _id;
  String? _buyerEmail;
  String? _bookingDate;
  num? _status;
  Item? _item;
  num? _totalCost;
  String? _paymentIntentId;
BookingModel copyWith({  num? id,
  String? buyerEmail,
  String? bookingDate,
  num? status,
  Item? item,
  num? totalCost,
  String? paymentIntentId,
}) => BookingModel(  id: id ?? _id,
  buyerEmail: buyerEmail ?? _buyerEmail,
  bookingDate: bookingDate ?? _bookingDate,
  status: status ?? _status,
  item: item ?? _item,
  totalCost: totalCost ?? _totalCost,
  paymentIntentId: paymentIntentId ?? _paymentIntentId,
);
  num? get id => _id;
  String? get buyerEmail => _buyerEmail;
  String? get bookingDate => _bookingDate;
  num? get status => _status;
  Item? get item => _item;
  num? get totalCost => _totalCost;
  String? get paymentIntentId => _paymentIntentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['buyerEmail'] = _buyerEmail;
    map['bookingDate'] = _bookingDate;
    map['status'] = _status;
    if (_item != null) {
      map['item'] = _item?.toJson();
    }
    map['totalCost'] = _totalCost;
    map['paymentIntentId'] = _paymentIntentId;
    return map;
  }

}

/// travelItemBooked : {"travelId":0,"title":"string","travelProfileUrl":"string"}
/// price : 0
/// quantity : 0

class Item {
  Item({
      TravelItemBooked? travelItemBooked, 
      num? price, 
      num? quantity,}){
    _travelItemBooked = travelItemBooked;
    _price = price;
    _quantity = quantity;
}

  Item.fromJson(dynamic json) {
    _travelItemBooked = json['travelItemBooked'] != null ? TravelItemBooked.fromJson(json['travelItemBooked']) : null;
    _price = json['price'];
    _quantity = json['quantity'];
  }
  TravelItemBooked? _travelItemBooked;
  num? _price;
  num? _quantity;
Item copyWith({  TravelItemBooked? travelItemBooked,
  num? price,
  num? quantity,
}) => Item(  travelItemBooked: travelItemBooked ?? _travelItemBooked,
  price: price ?? _price,
  quantity: quantity ?? _quantity,
);
  TravelItemBooked? get travelItemBooked => _travelItemBooked;
  num? get price => _price;
  num? get quantity => _quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_travelItemBooked != null) {
      map['travelItemBooked'] = _travelItemBooked?.toJson();
    }
    map['price'] = _price;
    map['quantity'] = _quantity;
    return map;
  }

}

/// travelId : 0
/// title : "string"
/// travelProfileUrl : "string"

class TravelItemBooked {
  TravelItemBooked({
      num? travelId, 
      String? title, 
      String? travelProfileUrl,}){
    _travelId = travelId;
    _title = title;
    _travelProfileUrl = travelProfileUrl;
}

  TravelItemBooked.fromJson(dynamic json) {
    _travelId = json['travelId'];
    _title = json['title'];
    _travelProfileUrl = json['travelProfileUrl'];
  }
  num? _travelId;
  String? _title;
  String? _travelProfileUrl;
TravelItemBooked copyWith({  num? travelId,
  String? title,
  String? travelProfileUrl,
}) => TravelItemBooked(  travelId: travelId ?? _travelId,
  title: title ?? _title,
  travelProfileUrl: travelProfileUrl ?? _travelProfileUrl,
);
  num? get travelId => _travelId;
  String? get title => _title;
  String? get travelProfileUrl => _travelProfileUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['travelId'] = _travelId;
    map['title'] = _title;
    map['travelProfileUrl'] = _travelProfileUrl;
    return map;
  }

}