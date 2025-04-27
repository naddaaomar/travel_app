/// items : [{"id":4,"userId":"9f9e9439-ce44-4f42-a1cc-17107dbfa040","companyName":"Ancient Pathways","address":"Aswan, El Shallal","description":"Your trusted partner for authentic Egyptian adventures.","website":"https://www.company4.eg","latitude":null,"longitude":null,"profileImageUrl":"https://journeymate.runasp.net//CompanyImages/1.jpg","establishedDate":"2010-12-28","rating":5,"socialMediaLinks":[],"paymentMethods":[],"ratings":[],"travels":[]},{"id":6,"userId":"4fd6daec-a13f-4cb0-bd5d-45a9d2d022a0","companyName":"Sphinx Journeys","address":"Hurghada, El Dahar","description":"Discover the hidden gems of Egypt with us.","website":"https://www.company6.eg","latitude":null,"longitude":null,"profileImageUrl":"https://journeymate.runasp.net//CompanyImages/1.jpg","establishedDate":"2020-08-15","rating":5,"socialMediaLinks":[],"paymentMethods":[],"ratings":[],"travels":[{"id":8,"title":"Amazon Rainforest Trek","description":"9-day exploration of the Amazon","price":2700.00,"startDate":"2025-08-01T00:00:00","endDate":"2025-08-10T00:00:00","creationDate":"2025-04-23T00:00:00","availableSeats":12,"departurePoint":"Manaus Airport","departurePointLat":-3.1126,"departurePointLng":-60.0261,"destinationCity":"Amazon Jungle","destinationCityLat":-3.4653,"destinationCityLng":-62.2159,"transportationType":"Boat","amenities":["Jungle guides","Camping equipment","Wildlife tours"],"companyId":6,"companyName":"Sphinx Journeys","imageUrls":[],"itenraries":[]}]},{"id":8,"userId":"3747b2e8-62a4-4ac4-8e5a-6e7ebd63b660","companyName":"Desert Dreams","address":"Cairo, Giza","description":"Safe and enjoyable tours designed for families and groups.","website":"https://www.company8.eg","latitude":null,"longitude":null,"profileImageUrl":"https://journeymate.runasp.net//CompanyImages/2.jpg","establishedDate":"2016-07-19","rating":5,"socialMediaLinks":[],"paymentMethods":[],"ratings":[],"travels":[{"id":7,"title":"Ancient Egypt Tour","description":"7-day historical tour of Egypt","price":1600.00,"startDate":"2025-06-12T00:00:00","endDate":"2025-06-19T00:00:00","creationDate":"2025-04-23T00:00:00","availableSeats":35,"departurePoint":"Cairo Airport","departurePointLat":30.1219,"departurePointLng":31.4056,"destinationCity":"Luxor","destinationCityLat":25.6872,"destinationCityLng":32.6396,"transportationType":"Bus","amenities":["Archaeological guides","Nile cruise","Museum visits"],"companyId":8,"companyName":"Desert Dreams","imageUrls":[],"itenraries":[]}]},{"id":10,"userId":"1be045f3-06ce-4e44-9d3c-08e047cd0ace","companyName":"Tut Treks","address":"Sharm El Sheikh, Naama Bay","description":"Premium travel services across Egypt's iconic destinations.","website":"https://www.company10.eg","latitude":null,"longitude":null,"profileImageUrl":"https://journeymate.runasp.net//CompanyImages/1.jpg","establishedDate":"2007-03-20","rating":5,"socialMediaLinks":[],"paymentMethods":[],"ratings":[],"travels":[{"id":2,"title":"Alpine Adventure","description":"5-day hiking tour through the Alps","price":950.00,"startDate":"2025-06-07T00:00:00","endDate":"2025-06-12T00:00:00","creationDate":"2025-04-23T00:00:00","availableSeats":20,"departurePoint":"Munich Central Station","departurePointLat":48.1351,"departurePointLng":11.582,"destinationCity":"Chamonix","destinationCityLat":45.9237,"destinationCityLng":6.8694,"transportationType":"Bus","amenities":["Guided tours","Equipment rental","Meals included"],"companyId":10,"companyName":"Tut Treks","imageUrls":[],"itenraries":[]}]},{"id":11,"userId":"dcefc696-507e-44e9-a3ef-b7c3727683c3","companyName":"Blue Nile Trips","address":"Luxor, Karnak","description":"Discover the hidden gems of Egypt with us.","website":"https://www.company11.eg","latitude":null,"longitude":null,"profileImageUrl":"https://journeymate.runasp.net//CompanyImages/1.jpg","establishedDate":"2014-03-06","rating":5,"socialMediaLinks":[],"paymentMethods":[],"ratings":[],"travels":[]}]
/// totalCount : 20
/// totalPages : 4
/// fromItem : 1
/// toItem : 5

class AllCompaniesModel {
  AllCompaniesModel({
      List<Items>? items, 
      num? totalCount, 
      num? totalPages, 
      num? fromItem, 
      num? toItem,}){
    _items = items;
    _totalCount = totalCount;
    _totalPages = totalPages;
    _fromItem = fromItem;
    _toItem = toItem;
}

  AllCompaniesModel.fromJson(dynamic json) {
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
    _totalCount = json['totalCount'];
    _totalPages = json['totalPages'];
    _fromItem = json['fromItem'];
    _toItem = json['toItem'];
  }
  List<Items>? _items;
  num? _totalCount;
  num? _totalPages;
  num? _fromItem;
  num? _toItem;
AllCompaniesModel copyWith({  List<Items>? items,
  num? totalCount,
  num? totalPages,
  num? fromItem,
  num? toItem,
}) => AllCompaniesModel(  items: items ?? _items,
  totalCount: totalCount ?? _totalCount,
  totalPages: totalPages ?? _totalPages,
  fromItem: fromItem ?? _fromItem,
  toItem: toItem ?? _toItem,
);
  List<Items>? get items => _items;
  num? get totalCount => _totalCount;
  num? get totalPages => _totalPages;
  num? get fromItem => _fromItem;
  num? get toItem => _toItem;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    map['totalCount'] = _totalCount;
    map['totalPages'] = _totalPages;
    map['fromItem'] = _fromItem;
    map['toItem'] = _toItem;
    return map;
  }

}

/// id : 4
/// userId : "9f9e9439-ce44-4f42-a1cc-17107dbfa040"
/// companyName : "Ancient Pathways"
/// address : "Aswan, El Shallal"
/// description : "Your trusted partner for authentic Egyptian adventures."
/// website : "https://www.company4.eg"
/// latitude : null
/// longitude : null
/// profileImageUrl : "https://journeymate.runasp.net//CompanyImages/1.jpg"
/// establishedDate : "2010-12-28"
/// rating : 5
/// socialMediaLinks : []
/// paymentMethods : []
/// ratings : []
/// travels : []

class Items {
  Items({
      num? id, 
      String? userId, 
      String? companyName, 
      String? address, 
      String? description, 
      String? website, 
      dynamic latitude, 
      dynamic longitude, 
      String? profileImageUrl, 
      String? establishedDate, 
      num? rating, 
      List<dynamic>? socialMediaLinks, 
      List<dynamic>? paymentMethods, 
      List<dynamic>? ratings, 
      List<dynamic>? travels,}){
    _id = id;
    _userId = userId;
    _companyName = companyName;
    _address = address;
    _description = description;
    _website = website;
    _latitude = latitude;
    _longitude = longitude;
    _profileImageUrl = profileImageUrl;
    _establishedDate = establishedDate;
    _rating = rating;
    _socialMediaLinks = socialMediaLinks;
    _paymentMethods = paymentMethods;
    _ratings = ratings;
    _travels = travels;
}

  Items.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _companyName = json['companyName'];
    _address = json['address'];
    _description = json['description'];
    _website = json['website'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _profileImageUrl = json['profileImageUrl'];
    _establishedDate = json['establishedDate'];
    _rating = json['rating'];

    if (json['socialMediaLinks'] != null) {
      _socialMediaLinks = [];
      json['socialMediaLinks'].forEach((v) {
        _socialMediaLinks?.add(SocialMediaLink.fromJson(v));
      });
    }

    if (json['paymentMethods'] != null) {
      _paymentMethods = [];
      json['paymentMethods'].forEach((v) {
        _paymentMethods?.add(PaymentMethod.fromJson(v));
      });
    }

    if (json['ratings'] != null) {
      _ratings = [];
      json['ratings'].forEach((v) {
        _ratings?.add(Rating.fromJson(v));
      });
    }

    if (json['travels'] != null) {
      _travels = [];
      json['travels'].forEach((v) {
        _travels?.add(Travel.fromJson(v));
      });
    }
  }

  num? _id;
  String? _userId;
  String? _companyName;
  String? _address;
  String? _description;
  String? _website;
  dynamic _latitude;
  dynamic _longitude;
  String? _profileImageUrl;
  String? _establishedDate;
  num? _rating;
  List<dynamic>? _socialMediaLinks;
  List<dynamic>? _paymentMethods;
  List<dynamic>? _ratings;
  List<dynamic>? _travels;
Items copyWith({  num? id,
  String? userId,
  String? companyName,
  String? address,
  String? description,
  String? website,
  dynamic latitude,
  dynamic longitude,
  String? profileImageUrl,
  String? establishedDate,
  num? rating,
  List<dynamic>? socialMediaLinks,
  List<dynamic>? paymentMethods,
  List<dynamic>? ratings,
  List<dynamic>? travels,
}) => Items(  id: id ?? _id,
  userId: userId ?? _userId,
  companyName: companyName ?? _companyName,
  address: address ?? _address,
  description: description ?? _description,
  website: website ?? _website,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  profileImageUrl: profileImageUrl ?? _profileImageUrl,
  establishedDate: establishedDate ?? _establishedDate,
  rating: rating ?? _rating,
  socialMediaLinks: socialMediaLinks ?? _socialMediaLinks,
  paymentMethods: paymentMethods ?? _paymentMethods,
  ratings: ratings ?? _ratings,
  travels: travels ?? _travels,
);
  num? get id => _id;
  String? get userId => _userId;
  String? get companyName => _companyName;
  String? get address => _address;
  String? get description => _description;
  String? get website => _website;
  dynamic get latitude => _latitude;
  dynamic get longitude => _longitude;
  String? get profileImageUrl => _profileImageUrl;
  String? get establishedDate => _establishedDate;
  num? get rating => _rating;
  List<dynamic>? get socialMediaLinks => _socialMediaLinks;
  List<dynamic>? get paymentMethods => _paymentMethods;
  List<dynamic>? get ratings => _ratings;
  List<dynamic>? get travels => _travels;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['companyName'] = _companyName;
    map['address'] = _address;
    map['description'] = _description;
    map['website'] = _website;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['profileImageUrl'] = _profileImageUrl;
    map['establishedDate'] = _establishedDate;
    map['rating'] = _rating;
    if (_socialMediaLinks != null) {
      map['socialMediaLinks'] = _socialMediaLinks?.map((v) => v.toJson()).toList();
    }
    if (_paymentMethods != null) {
      map['paymentMethods'] = _paymentMethods?.map((v) => v.toJson()).toList();
    }
    if (_ratings != null) {
      map['ratings'] = _ratings?.map((v) => v.toJson()).toList();
    }
    if (_travels != null) {
      map['travels'] = _travels?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
class SocialMediaLink {
  String? platform;
  String? url;

  SocialMediaLink({this.platform, this.url});

  factory SocialMediaLink.fromJson(Map<String, dynamic> json) {
    return SocialMediaLink(
      platform: json['platform'],
      url: json['url'],
    );
  }
}
class PaymentMethod {
  String? type;
  String? details;

  PaymentMethod({this.type, this.details});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      type: json['type'],
      details: json['details'],
    );
  }
}
class Rating {
  String? userId;
  double? value;
  String? comment;

  Rating({this.userId, this.value, this.comment});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      userId: json['userId'],
      value: json['value']?.toDouble(),
      comment: json['comment'],
    );
  }
}
class Travel {
  String? destination;
  String? date;
  double? price;

  Travel({this.destination, this.date, this.price});

  factory Travel.fromJson(Map<String, dynamic> json) {
    return Travel(
      destination: json['destination'],
      date: json['date'],
      price: json['price']?.toDouble(),
    );
  }
}
