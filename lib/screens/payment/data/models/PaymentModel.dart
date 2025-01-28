/// payment_keys : [{"integration":4936791,"key":"ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SjFjMlZ5WDJsa0lqb3hPVEEwTlRrekxDSmhiVzkxYm5SZlkyVnVkSE1pT2pJd01EQXNJbU4xY25KbGJtTjVJam9pUlVkUUlpd2lhVzUwWldkeVlYUnBiMjVmYVdRaU9qUTVNelkzT1RFc0ltOXlaR1Z5WDJsa0lqb3lPRGszTXpneU5EQXNJbUpwYkd4cGJtZGZaR0YwWVNJNmV5Sm1hWEp6ZEY5dVlXMWxJam9pWVd4aFlTSXNJbXhoYzNSZmJtRnRaU0k2SW5KaGMyeGhiaUlzSW5OMGNtVmxkQ0k2SW1SMWJYa2lMQ0ppZFdsc1pHbHVaeUk2SW1SMWJYa2lMQ0ptYkc5dmNpSTZJbVIxYlhraUxDSmhjR0Z5ZEcxbGJuUWlPaUprZFcxNUlpd2lZMmwwZVNJNkltUjFiWGtpTENKemRHRjBaU0k2SW1SMWJYa2lMQ0pqYjNWdWRISjVJam9pWkhWdGVTSXNJbVZ0WVdsc0lqb2lZV3hoWVhKaGMyeGhiakUxTWtCbmJXRnBiQzVqYjIwaUxDSndhRzl1WlY5dWRXMWlaWElpT2lJck1ERXlNakF3TnpNM09EVWlMQ0p3YjNOMFlXeGZZMjlrWlNJNklrNUJJaXdpWlhoMGNtRmZaR1Z6WTNKcGNIUnBiMjRpT2lKT1FTSjlMQ0pzYjJOclgyOXlaR1Z5WDNkb1pXNWZjR0ZwWkNJNlptRnNjMlVzSW1WNGRISmhJanA3SW1WbElqb3lNaXdpYldWeVkyaGhiblJmYjNKa1pYSmZhV1FpT2lJNU9URTJZVEkyWXkwM016SmlMVFJsTnpjdE9XWTNOUzFsWldFMlpUWTBZemN5TW1FaWZTd2libTkwYVdacFkyRjBhVzl1WDNWeWJDSTZJbWgwZEhCek9pOHZkMlZpYUc5dmF5NXphWFJsTHpkaU56RmlZak14TFdFNFlXRXRORFk1WkMwNFpqVTJMVEExTVRJeE1EaGhZbUl6TWlJc0luSmxaR2x5WldOMGFXOXVYM1Z5YkNJNkltaDBkSEJ6T2k4dmQzZDNMbWR2YjJkc1pTNWpiMjB2SWl3aWMybHVaMnhsWDNCaGVXMWxiblJmWVhSMFpXMXdkQ0k2Wm1Gc2MyVXNJbTVsZUhSZmNHRjViV1Z1ZEY5cGJuUmxiblJwYjI0aU9pSndhVjkwWlhOMFh6QTNNakpqWVRBMk5EUTFaalJoWlRVNFpEQmhOV1kxTmpVeVpXRTVNMlprSWl3aVpYaHdJam94TnpNM09UTTRPVGt6ZlEuYnlIQ1hhcTc1QlZBNnM3bHY4OFFSbkF1bVJJTnB2WlhQWnVERXVXX2VEdDlPT0tJLUpwSEJ2U2FHX3Y4emVpWDdTMTg4SFk5cm1sVlM5aDFXYnR4ZlE=","gateway_type":"MIGS","iframe_id":null,"order_id":289738240,"redirection_url":"https://accept.paymobsolutions.com/api/acceptance/post_pay","save_card":false}]
/// redirection_url : "https://www.google.com/"
/// intention_order_id : 289738240
/// id : "pi_test_0722ca06445f4ae58d0a5f5652ea93fd"
/// intention_detail : {"amount":2000,"items":[{"name":"Item name","amount":2000,"description":"Item description","quantity":1,"image":null}],"currency":"EGP","billing_data":{"apartment":"dumy","floor":"dumy","first_name":"alaa","last_name":"raslan","street":"dumy","building":"dumy","phone_number":"+01220073785","shipping_method":"","city":"dumy","country":"dumy","state":"dumy","email":"alaaraslan152@gmail.com","postal_code":""}}
/// client_secret : "egy_csk_test_f635b6055011c5a7c812710d31059931"
/// payment_methods : [{"integration_id":4936791,"alias":null,"name":null,"method_type":"online","currency":"EGP","live":false,"use_cvc_with_moto":false}]
/// special_reference : "9916a26c-732b-4e77-9f75-eea6e64c722a"
/// extras : {"creation_extras":{"ee":22,"merchant_order_id":"9916a26c-732b-4e77-9f75-eea6e64c722a"},"confirmation_extras":null}
/// confirmed : false
/// status : "intended"
/// created : "2025-01-27T01:49:53.750668"
/// card_detail : null
/// card_tokens : []
/// object : "paymentintention"

class PaymentModel {
  PaymentModel({
      List<PaymentKeys>? paymentKeys, 
      String? redirectionUrl, 
      num? intentionOrderId, 
      String? id, 
      IntentionDetail? intentionDetail, 
      String? clientSecret, 
      List<PaymentMethods>? paymentMethods, 
      String? specialReference, 
      Extras? extras, 
      bool? confirmed, 
      String? status, 
      String? created, 
      dynamic cardDetail, 
      List<dynamic>? cardTokens, 
      String? object,}){
    _paymentKeys = paymentKeys;
    _redirectionUrl = redirectionUrl;
    _intentionOrderId = intentionOrderId;
    _id = id;
    _intentionDetail = intentionDetail;
    _clientSecret = clientSecret;
    _paymentMethods = paymentMethods;
    _specialReference = specialReference;
    _extras = extras;
    _confirmed = confirmed;
    _status = status;
    _created = created;
    _cardDetail = cardDetail;
    _cardTokens = cardTokens;
    _object = object;
}

  PaymentModel.fromJson(dynamic json) {
    if (json['payment_keys'] != null) {
      _paymentKeys = [];
      json['payment_keys'].forEach((v) {
        _paymentKeys?.add(PaymentKeys.fromJson(v));
      });
    }
    _redirectionUrl = json['redirection_url'];
    _intentionOrderId = json['intention_order_id'];
    _id = json['id'];
    _intentionDetail = json['intention_detail'] != null ? IntentionDetail.fromJson(json['intention_detail']) : null;
    _clientSecret = json['client_secret'];
    if (json['payment_methods'] != null) {
      _paymentMethods = [];
      json['payment_methods'].forEach((v) {
        _paymentMethods?.add(PaymentMethods.fromJson(v));
      });
    }
    _specialReference = json['special_reference'];
    _extras = json['extras'] != null ? Extras.fromJson(json['extras']) : null;
    _confirmed = json['confirmed'];
    _status = json['status'];
    _created = json['created'];
    _cardDetail = json['card_detail'];
    if (json['card_tokens'] != null) {
      _cardTokens = [];
      json['card_tokens'].forEach((v) {
        _cardTokens?.add(v);
      });
    }
    _object = json['object'];
  }
  List<PaymentKeys>? _paymentKeys;
  String? _redirectionUrl;
  num? _intentionOrderId;
  String? _id;
  IntentionDetail? _intentionDetail;
  String? _clientSecret;
  List<PaymentMethods>? _paymentMethods;
  String? _specialReference;
  Extras? _extras;
  bool? _confirmed;
  String? _status;
  String? _created;
  dynamic _cardDetail;
  List<dynamic>? _cardTokens;
  String? _object;
PaymentModel copyWith({  List<PaymentKeys>? paymentKeys,
  String? redirectionUrl,
  num? intentionOrderId,
  String? id,
  IntentionDetail? intentionDetail,
  String? clientSecret,
  List<PaymentMethods>? paymentMethods,
  String? specialReference,
  Extras? extras,
  bool? confirmed,
  String? status,
  String? created,
  dynamic cardDetail,
  List<dynamic>? cardTokens,
  String? object,
}) => PaymentModel(  paymentKeys: paymentKeys ?? _paymentKeys,
  redirectionUrl: redirectionUrl ?? _redirectionUrl,
  intentionOrderId: intentionOrderId ?? _intentionOrderId,
  id: id ?? _id,
  intentionDetail: intentionDetail ?? _intentionDetail,
  clientSecret: clientSecret ?? _clientSecret,
  paymentMethods: paymentMethods ?? _paymentMethods,
  specialReference: specialReference ?? _specialReference,
  extras: extras ?? _extras,
  confirmed: confirmed ?? _confirmed,
  status: status ?? _status,
  created: created ?? _created,
  cardDetail: cardDetail ?? _cardDetail,
  cardTokens: cardTokens ?? _cardTokens,
  object: object ?? _object,
);
  List<PaymentKeys>? get paymentKeys => _paymentKeys;
  String? get redirectionUrl => _redirectionUrl;
  num? get intentionOrderId => _intentionOrderId;
  String? get id => _id;
  IntentionDetail? get intentionDetail => _intentionDetail;
  String? get clientSecret => _clientSecret;
  List<PaymentMethods>? get paymentMethods => _paymentMethods;
  String? get specialReference => _specialReference;
  Extras? get extras => _extras;
  bool? get confirmed => _confirmed;
  String? get status => _status;
  String? get created => _created;
  dynamic get cardDetail => _cardDetail;
  List<dynamic>? get cardTokens => _cardTokens;
  String? get object => _object;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_paymentKeys != null) {
      map['payment_keys'] = _paymentKeys?.map((v) => v.toJson()).toList();
    }
    map['redirection_url'] = _redirectionUrl;
    map['intention_order_id'] = _intentionOrderId;
    map['id'] = _id;
    if (_intentionDetail != null) {
      map['intention_detail'] = _intentionDetail?.toJson();
    }
    map['client_secret'] = _clientSecret;
    if (_paymentMethods != null) {
      map['payment_methods'] = _paymentMethods?.map((v) => v.toJson()).toList();
    }
    map['special_reference'] = _specialReference;
    if (_extras != null) {
      map['extras'] = _extras?.toJson();
    }
    map['confirmed'] = _confirmed;
    map['status'] = _status;
    map['created'] = _created;
    map['card_detail'] = _cardDetail;
    if (_cardTokens != null) {
      map['card_tokens'] = _cardTokens?.map((v) => v.toJson()).toList();
    }
    map['object'] = _object;
    return map;
  }

}

/// creation_extras : {"ee":22,"merchant_order_id":"9916a26c-732b-4e77-9f75-eea6e64c722a"}
/// confirmation_extras : null

class Extras {
  Extras({
      CreationExtras? creationExtras, 
      dynamic confirmationExtras,}){
    _creationExtras = creationExtras;
    _confirmationExtras = confirmationExtras;
}

  Extras.fromJson(dynamic json) {
    _creationExtras = json['creation_extras'] != null ? CreationExtras.fromJson(json['creation_extras']) : null;
    _confirmationExtras = json['confirmation_extras'];
  }
  CreationExtras? _creationExtras;
  dynamic _confirmationExtras;
Extras copyWith({  CreationExtras? creationExtras,
  dynamic confirmationExtras,
}) => Extras(  creationExtras: creationExtras ?? _creationExtras,
  confirmationExtras: confirmationExtras ?? _confirmationExtras,
);
  CreationExtras? get creationExtras => _creationExtras;
  dynamic get confirmationExtras => _confirmationExtras;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_creationExtras != null) {
      map['creation_extras'] = _creationExtras?.toJson();
    }
    map['confirmation_extras'] = _confirmationExtras;
    return map;
  }

}

/// ee : 22
/// merchant_order_id : "9916a26c-732b-4e77-9f75-eea6e64c722a"

class CreationExtras {
  CreationExtras({
      num? ee, 
      String? merchantOrderId,}){
    _ee = ee;
    _merchantOrderId = merchantOrderId;
}

  CreationExtras.fromJson(dynamic json) {
    _ee = json['ee'];
    _merchantOrderId = json['merchant_order_id'];
  }
  num? _ee;
  String? _merchantOrderId;
CreationExtras copyWith({  num? ee,
  String? merchantOrderId,
}) => CreationExtras(  ee: ee ?? _ee,
  merchantOrderId: merchantOrderId ?? _merchantOrderId,
);
  num? get ee => _ee;
  String? get merchantOrderId => _merchantOrderId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ee'] = _ee;
    map['merchant_order_id'] = _merchantOrderId;
    return map;
  }

}

/// integration_id : 4936791
/// alias : null
/// name : null
/// method_type : "online"
/// currency : "EGP"
/// live : false
/// use_cvc_with_moto : false

class PaymentMethods {
  PaymentMethods({
      num? integrationId, 
      dynamic alias, 
      dynamic name, 
      String? methodType, 
      String? currency, 
      bool? live, 
      bool? useCvcWithMoto,}){
    _integrationId = integrationId;
    _alias = alias;
    _name = name;
    _methodType = methodType;
    _currency = currency;
    _live = live;
    _useCvcWithMoto = useCvcWithMoto;
}

  PaymentMethods.fromJson(dynamic json) {
    _integrationId = json['integration_id'];
    _alias = json['alias'];
    _name = json['name'];
    _methodType = json['method_type'];
    _currency = json['currency'];
    _live = json['live'];
    _useCvcWithMoto = json['use_cvc_with_moto'];
  }
  num? _integrationId;
  dynamic _alias;
  dynamic _name;
  String? _methodType;
  String? _currency;
  bool? _live;
  bool? _useCvcWithMoto;
PaymentMethods copyWith({  num? integrationId,
  dynamic alias,
  dynamic name,
  String? methodType,
  String? currency,
  bool? live,
  bool? useCvcWithMoto,
}) => PaymentMethods(  integrationId: integrationId ?? _integrationId,
  alias: alias ?? _alias,
  name: name ?? _name,
  methodType: methodType ?? _methodType,
  currency: currency ?? _currency,
  live: live ?? _live,
  useCvcWithMoto: useCvcWithMoto ?? _useCvcWithMoto,
);
  num? get integrationId => _integrationId;
  dynamic get alias => _alias;
  dynamic get name => _name;
  String? get methodType => _methodType;
  String? get currency => _currency;
  bool? get live => _live;
  bool? get useCvcWithMoto => _useCvcWithMoto;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['integration_id'] = _integrationId;
    map['alias'] = _alias;
    map['name'] = _name;
    map['method_type'] = _methodType;
    map['currency'] = _currency;
    map['live'] = _live;
    map['use_cvc_with_moto'] = _useCvcWithMoto;
    return map;
  }

}

/// amount : 2000
/// items : [{"name":"Item name","amount":2000,"description":"Item description","quantity":1,"image":null}]
/// currency : "EGP"
/// billing_data : {"apartment":"dumy","floor":"dumy","first_name":"alaa","last_name":"raslan","street":"dumy","building":"dumy","phone_number":"+01220073785","shipping_method":"","city":"dumy","country":"dumy","state":"dumy","email":"alaaraslan152@gmail.com","postal_code":""}

class IntentionDetail {
  IntentionDetail({
      num? amount, 
      List<Items>? items, 
      String? currency, 
      BillingData? billingData,}){
    _amount = amount;
    _items = items;
    _currency = currency;
    _billingData = billingData;
}

  IntentionDetail.fromJson(dynamic json) {
    _amount = json['amount'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
    _currency = json['currency'];
    _billingData = json['billing_data'] != null ? BillingData.fromJson(json['billing_data']) : null;
  }
  num? _amount;
  List<Items>? _items;
  String? _currency;
  BillingData? _billingData;
IntentionDetail copyWith({  num? amount,
  List<Items>? items,
  String? currency,
  BillingData? billingData,
}) => IntentionDetail(  amount: amount ?? _amount,
  items: items ?? _items,
  currency: currency ?? _currency,
  billingData: billingData ?? _billingData,
);
  num? get amount => _amount;
  List<Items>? get items => _items;
  String? get currency => _currency;
  BillingData? get billingData => _billingData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = _amount;
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    map['currency'] = _currency;
    if (_billingData != null) {
      map['billing_data'] = _billingData?.toJson();
    }
    return map;
  }

}

/// apartment : "dumy"
/// floor : "dumy"
/// first_name : "alaa"
/// last_name : "raslan"
/// street : "dumy"
/// building : "dumy"
/// phone_number : "+01220073785"
/// shipping_method : ""
/// city : "dumy"
/// country : "dumy"
/// state : "dumy"
/// email : "alaaraslan152@gmail.com"
/// postal_code : ""

class BillingData {
  BillingData({
      String? apartment, 
      String? floor, 
      String? firstName, 
      String? lastName, 
      String? street, 
      String? building, 
      String? phoneNumber, 
      String? shippingMethod, 
      String? city, 
      String? country, 
      String? state, 
      String? email, 
      String? postalCode,}){
    _apartment = apartment;
    _floor = floor;
    _firstName = firstName;
    _lastName = lastName;
    _street = street;
    _building = building;
    _phoneNumber = phoneNumber;
    _shippingMethod = shippingMethod;
    _city = city;
    _country = country;
    _state = state;
    _email = email;
    _postalCode = postalCode;
}

  BillingData.fromJson(dynamic json) {
    _apartment = json['apartment'];
    _floor = json['floor'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _street = json['street'];
    _building = json['building'];
    _phoneNumber = json['phone_number'];
    _shippingMethod = json['shipping_method'];
    _city = json['city'];
    _country = json['country'];
    _state = json['state'];
    _email = json['email'];
    _postalCode = json['postal_code'];
  }
  String? _apartment;
  String? _floor;
  String? _firstName;
  String? _lastName;
  String? _street;
  String? _building;
  String? _phoneNumber;
  String? _shippingMethod;
  String? _city;
  String? _country;
  String? _state;
  String? _email;
  String? _postalCode;
BillingData copyWith({  String? apartment,
  String? floor,
  String? firstName,
  String? lastName,
  String? street,
  String? building,
  String? phoneNumber,
  String? shippingMethod,
  String? city,
  String? country,
  String? state,
  String? email,
  String? postalCode,
}) => BillingData(  apartment: apartment ?? _apartment,
  floor: floor ?? _floor,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  street: street ?? _street,
  building: building ?? _building,
  phoneNumber: phoneNumber ?? _phoneNumber,
  shippingMethod: shippingMethod ?? _shippingMethod,
  city: city ?? _city,
  country: country ?? _country,
  state: state ?? _state,
  email: email ?? _email,
  postalCode: postalCode ?? _postalCode,
);
  String? get apartment => _apartment;
  String? get floor => _floor;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get street => _street;
  String? get building => _building;
  String? get phoneNumber => _phoneNumber;
  String? get shippingMethod => _shippingMethod;
  String? get city => _city;
  String? get country => _country;
  String? get state => _state;
  String? get email => _email;
  String? get postalCode => _postalCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['apartment'] = _apartment;
    map['floor'] = _floor;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['street'] = _street;
    map['building'] = _building;
    map['phone_number'] = _phoneNumber;
    map['shipping_method'] = _shippingMethod;
    map['city'] = _city;
    map['country'] = _country;
    map['state'] = _state;
    map['email'] = _email;
    map['postal_code'] = _postalCode;
    return map;
  }

}

/// name : "Item name"
/// amount : 2000
/// description : "Item description"
/// quantity : 1
/// image : null

class Items {
  Items({
      String? name, 
      num? amount, 
      String? description, 
      num? quantity, 
      dynamic image,}){
    _name = name;
    _amount = amount;
    _description = description;
    _quantity = quantity;
    _image = image;
}

  Items.fromJson(dynamic json) {
    _name = json['name'];
    _amount = json['amount'];
    _description = json['description'];
    _quantity = json['quantity'];
    _image = json['image'];
  }
  String? _name;
  num? _amount;
  String? _description;
  num? _quantity;
  dynamic _image;
Items copyWith({  String? name,
  num? amount,
  String? description,
  num? quantity,
  dynamic image,
}) => Items(  name: name ?? _name,
  amount: amount ?? _amount,
  description: description ?? _description,
  quantity: quantity ?? _quantity,
  image: image ?? _image,
);
  String? get name => _name;
  num? get amount => _amount;
  String? get description => _description;
  num? get quantity => _quantity;
  dynamic get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['amount'] = _amount;
    map['description'] = _description;
    map['quantity'] = _quantity;
    map['image'] = _image;
    return map;
  }

}

/// integration : 4936791
/// key : "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SjFjMlZ5WDJsa0lqb3hPVEEwTlRrekxDSmhiVzkxYm5SZlkyVnVkSE1pT2pJd01EQXNJbU4xY25KbGJtTjVJam9pUlVkUUlpd2lhVzUwWldkeVlYUnBiMjVmYVdRaU9qUTVNelkzT1RFc0ltOXlaR1Z5WDJsa0lqb3lPRGszTXpneU5EQXNJbUpwYkd4cGJtZGZaR0YwWVNJNmV5Sm1hWEp6ZEY5dVlXMWxJam9pWVd4aFlTSXNJbXhoYzNSZmJtRnRaU0k2SW5KaGMyeGhiaUlzSW5OMGNtVmxkQ0k2SW1SMWJYa2lMQ0ppZFdsc1pHbHVaeUk2SW1SMWJYa2lMQ0ptYkc5dmNpSTZJbVIxYlhraUxDSmhjR0Z5ZEcxbGJuUWlPaUprZFcxNUlpd2lZMmwwZVNJNkltUjFiWGtpTENKemRHRjBaU0k2SW1SMWJYa2lMQ0pqYjNWdWRISjVJam9pWkhWdGVTSXNJbVZ0WVdsc0lqb2lZV3hoWVhKaGMyeGhiakUxTWtCbmJXRnBiQzVqYjIwaUxDSndhRzl1WlY5dWRXMWlaWElpT2lJck1ERXlNakF3TnpNM09EVWlMQ0p3YjNOMFlXeGZZMjlrWlNJNklrNUJJaXdpWlhoMGNtRmZaR1Z6WTNKcGNIUnBiMjRpT2lKT1FTSjlMQ0pzYjJOclgyOXlaR1Z5WDNkb1pXNWZjR0ZwWkNJNlptRnNjMlVzSW1WNGRISmhJanA3SW1WbElqb3lNaXdpYldWeVkyaGhiblJmYjNKa1pYSmZhV1FpT2lJNU9URTJZVEkyWXkwM016SmlMVFJsTnpjdE9XWTNOUzFsWldFMlpUWTBZemN5TW1FaWZTd2libTkwYVdacFkyRjBhVzl1WDNWeWJDSTZJbWgwZEhCek9pOHZkMlZpYUc5dmF5NXphWFJsTHpkaU56RmlZak14TFdFNFlXRXRORFk1WkMwNFpqVTJMVEExTVRJeE1EaGhZbUl6TWlJc0luSmxaR2x5WldOMGFXOXVYM1Z5YkNJNkltaDBkSEJ6T2k4dmQzZDNMbWR2YjJkc1pTNWpiMjB2SWl3aWMybHVaMnhsWDNCaGVXMWxiblJmWVhSMFpXMXdkQ0k2Wm1Gc2MyVXNJbTVsZUhSZmNHRjViV1Z1ZEY5cGJuUmxiblJwYjI0aU9pSndhVjkwWlhOMFh6QTNNakpqWVRBMk5EUTFaalJoWlRVNFpEQmhOV1kxTmpVeVpXRTVNMlprSWl3aVpYaHdJam94TnpNM09UTTRPVGt6ZlEuYnlIQ1hhcTc1QlZBNnM3bHY4OFFSbkF1bVJJTnB2WlhQWnVERXVXX2VEdDlPT0tJLUpwSEJ2U2FHX3Y4emVpWDdTMTg4SFk5cm1sVlM5aDFXYnR4ZlE="
/// gateway_type : "MIGS"
/// iframe_id : null
/// order_id : 289738240
/// redirection_url : "https://accept.paymobsolutions.com/api/acceptance/post_pay"
/// save_card : false

class PaymentKeys {
  PaymentKeys({
      num? integration, 
      String? key, 
      String? gatewayType, 
      dynamic iframeId, 
      num? orderId, 
      String? redirectionUrl, 
      bool? saveCard,}){
    _integration = integration;
    _key = key;
    _gatewayType = gatewayType;
    _iframeId = iframeId;
    _orderId = orderId;
    _redirectionUrl = redirectionUrl;
    _saveCard = saveCard;
}

  PaymentKeys.fromJson(dynamic json) {
    _integration = json['integration'];
    _key = json['key'];
    _gatewayType = json['gateway_type'];
    _iframeId = json['iframe_id'];
    _orderId = json['order_id'];
    _redirectionUrl = json['redirection_url'];
    _saveCard = json['save_card'];
  }
  num? _integration;
  String? _key;
  String? _gatewayType;
  dynamic _iframeId;
  num? _orderId;
  String? _redirectionUrl;
  bool? _saveCard;
PaymentKeys copyWith({  num? integration,
  String? key,
  String? gatewayType,
  dynamic iframeId,
  num? orderId,
  String? redirectionUrl,
  bool? saveCard,
}) => PaymentKeys(  integration: integration ?? _integration,
  key: key ?? _key,
  gatewayType: gatewayType ?? _gatewayType,
  iframeId: iframeId ?? _iframeId,
  orderId: orderId ?? _orderId,
  redirectionUrl: redirectionUrl ?? _redirectionUrl,
  saveCard: saveCard ?? _saveCard,
);
  num? get integration => _integration;
  String? get key => _key;
  String? get gatewayType => _gatewayType;
  dynamic get iframeId => _iframeId;
  num? get orderId => _orderId;
  String? get redirectionUrl => _redirectionUrl;
  bool? get saveCard => _saveCard;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['integration'] = _integration;
    map['key'] = _key;
    map['gateway_type'] = _gatewayType;
    map['iframe_id'] = _iframeId;
    map['order_id'] = _orderId;
    map['redirection_url'] = _redirectionUrl;
    map['save_card'] = _saveCard;
    return map;
  }

}