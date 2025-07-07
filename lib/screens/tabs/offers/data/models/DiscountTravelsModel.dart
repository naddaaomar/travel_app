/// items : [{"id":5,"title":"Caribbean Island Hopping","description":"6-day island-hopping adventure","price":1400,"baseCost":1100,"saleDiscount":0.15,"startDate":"2025-05-13T00:00:00","endDate":"2025-05-19T00:00:00","creationDate":"2025-04-23T00:00:00","availableSeats":40,"departurePoint":"Miami Port","departurePointLat":25.7617,"departurePointLng":-80.1918,"destinationCity":"Multiple Islands","destinationCityLat":0,"destinationCityLng":0,"transportationType":"Cruise Ship","amenities":["Beach access","Snorkeling","Live music"],"coverImageUrl":"https://i.pinimg.com/736x/14/7f/ea/147fea20f16d94e7960d2bd3b507fd2e.jpg","profileImageUrl":null,"companyProfileImageUrl":"https://journeymate.runasp.net//CompanyImages/1.jpg","included":[],"notIncluded":[],"specialOffer":null,"companyId":5,"companyName":"Pyramids Gateway","categoryId":5,"categoryName":null,"imageUrls":["https://journeymate.runasp.net/TravelImages/5/1.jpeg","https://journeymate.runasp.net/TravelImages/5/2.jpeg","https://journeymate.runasp.net/TravelImages/5/3.jpeg"],"itineraries":[]},{"id":11,"title":"Southeast Asia Backpacking","description":"14-day backpacking across Thailand and Vietnam","price":1700,"baseCost":1400,"saleDiscount":0.12,"startDate":"2025-07-12T00:00:00","endDate":"2025-07-26T00:00:00","creationDate":"2025-04-23T00:00:00","availableSeats":22,"departurePoint":"Bangkok Airport","departurePointLat":13.6811,"departurePointLng":100.7471,"destinationCity":"Hanoi","destinationCityLat":21.0285,"destinationCityLng":105.8542,"transportationType":"Bus","amenities":["Local guides","Hostel stays","Street food tours"],"coverImageUrl":"https://i.pinimg.com/736x/14/7f/ea/147fea20f16d94e7960d2bd3b507fd2e.jpg","profileImageUrl":null,"companyProfileImageUrl":"https://journeymate.runasp.net//CompanyImages/1.jpg","included":[],"notIncluded":[],"specialOffer":null,"companyId":11,"companyName":"Blue Nile Trips","categoryId":11,"categoryName":null,"imageUrls":["https://journeymate.runasp.net/TravelImages/11/1.jpeg","https://journeymate.runasp.net/TravelImages/11/2.jpeg","https://journeymate.runasp.net/TravelImages/11/3.jpeg"],"itineraries":[]},{"id":1,"title":"Mediterranean Cruise","description":"7-day cruise exploring the Mediterranean coast","price":1500,"baseCost":1200,"saleDiscount":0.1,"startDate":"2025-05-23T00:00:00","endDate":"2025-05-30T00:00:00","creationDate":"2025-04-23T00:00:00","availableSeats":50,"departurePoint":"Barcelona Port","departurePointLat":41.3851,"departurePointLng":2.1734,"destinationCity":"Multiple Cities","destinationCityLat":0,"destinationCityLng":0,"transportationType":"Cruise Ship","amenities":["Pool","Spa","Restaurants","Entertainment"],"coverImageUrl":"https://i.pinimg.com/736x/14/7f/ea/147fea20f16d94e7960d2bd3b507fd2e.jpg","profileImageUrl":null,"companyProfileImageUrl":"https://journeymate.runasp.net//CompanyImages/1.jpg","included":[],"notIncluded":[],"specialOffer":null,"companyId":1,"companyName":"Pharaoh Travels","categoryId":1,"categoryName":null,"imageUrls":["https://journeymate.runasp.net/TravelImages/1/1.jpeg","https://journeymate.runasp.net/TravelImages/1/2.jpeg","https://journeymate.runasp.net/TravelImages/1/3.jpeg"],"itineraries":[]},{"id":6,"title":"Nordic Winter Escape","description":"5-day winter adventure in Norway","price":1800,"baseCost":1500,"saleDiscount":0.1,"startDate":"2025-08-21T00:00:00","endDate":"2025-08-26T00:00:00","creationDate":"2025-04-23T00:00:00","availableSeats":25,"departurePoint":"Oslo Airport","departurePointLat":60.1939,"departurePointLng":11.1004,"destinationCity":"Tromsø","destinationCityLat":69.6492,"destinationCityLng":18.9553,"transportationType":"Bus","amenities":["Northern Lights tour","Snowshoeing","Sauna"],"coverImageUrl":"https://i.pinimg.com/736x/14/7f/ea/147fea20f16d94e7960d2bd3b507fd2e.jpg","profileImageUrl":null,"companyProfileImageUrl":"https://journeymate.runasp.net//CompanyImages/1.jpg","included":[],"notIncluded":[],"specialOffer":null,"companyId":6,"companyName":"Sphinx Journeys","categoryId":6,"categoryName":null,"imageUrls":["https://journeymate.runasp.net/TravelImages/6/1.jpeg","https://journeymate.runasp.net/TravelImages/6/2.jpeg","https://journeymate.runasp.net/TravelImages/6/3.jpeg"],"itineraries":[]},{"id":9,"title":"Balkan Road Trip","description":"12-day road trip through the Balkans","price":2000,"baseCost":1700,"saleDiscount":0.1,"startDate":"2025-07-07T00:00:00","endDate":"2025-07-19T00:00:00","creationDate":"2025-04-23T00:00:00","availableSeats":28,"departurePoint":"Belgrade Airport","departurePointLat":44.8184,"departurePointLng":20.3091,"destinationCity":"Dubrovnik","destinationCityLat":42.6507,"destinationCityLng":18.0944,"transportationType":"Van","amenities":["Local guides","Historical tours","Wine tasting"],"coverImageUrl":"https://i.pinimg.com/736x/14/7f/ea/147fea20f16d94e7960d2bd3b507fd2e.jpg","profileImageUrl":null,"companyProfileImageUrl":"https://journeymate.runasp.net//CompanyImages/2.jpg","included":[],"notIncluded":[],"specialOffer":null,"companyId":9,"companyName":"Horus Voyages","categoryId":9,"categoryName":null,"imageUrls":["https://journeymate.runasp.net/TravelImages/9/1.jpeg","https://journeymate.runasp.net/TravelImages/9/2.jpeg","https://journeymate.runasp.net/TravelImages/9/3.jpeg"],"itineraries":[]}]
/// totalCount : 10
/// totalPages : 2
/// fromItem : 1
/// toItem : 5

class DiscountTravelsModel {
  DiscountTravelsModel({
      List<ItemsDiscount>? items,
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

  DiscountTravelsModel.fromJson(dynamic json) {
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(ItemsDiscount.fromJson(v));
      });
    }
    _totalCount = json['totalCount'];
    _totalPages = json['totalPages'];
    _fromItem = json['fromItem'];
    _toItem = json['toItem'];
  }
  List<ItemsDiscount>? _items;
  num? _totalCount;
  num? _totalPages;
  num? _fromItem;
  num? _toItem;
DiscountTravelsModel copyWith({  List<ItemsDiscount>? items,
  num? totalCount,
  num? totalPages,
  num? fromItem,
  num? toItem,
}) => DiscountTravelsModel(  items: items ?? _items,
  totalCount: totalCount ?? _totalCount,
  totalPages: totalPages ?? _totalPages,
  fromItem: fromItem ?? _fromItem,
  toItem: toItem ?? _toItem,
);
  List<ItemsDiscount>? get items => _items;
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

/// id : 5
/// title : "Caribbean Island Hopping"
/// description : "6-day island-hopping adventure"
/// price : 1400
/// baseCost : 1100
/// saleDiscount : 0.15
/// startDate : "2025-05-13T00:00:00"
/// endDate : "2025-05-19T00:00:00"
/// creationDate : "2025-04-23T00:00:00"
/// availableSeats : 40
/// departurePoint : "Miami Port"
/// departurePointLat : 25.7617
/// departurePointLng : -80.1918
/// destinationCity : "Multiple Islands"
/// destinationCityLat : 0
/// destinationCityLng : 0
/// transportationType : "Cruise Ship"
/// amenities : ["Beach access","Snorkeling","Live music"]
/// coverImageUrl : "https://i.pinimg.com/736x/14/7f/ea/147fea20f16d94e7960d2bd3b507fd2e.jpg"
/// profileImageUrl : null
/// companyProfileImageUrl : "https://journeymate.runasp.net//CompanyImages/1.jpg"
/// included : []
/// notIncluded : []
/// specialOffer : null
/// companyId : 5
/// companyName : "Pyramids Gateway"
/// categoryId : 5
/// categoryName : null
/// imageUrls : ["https://journeymate.runasp.net/TravelImages/5/1.jpeg","https://journeymate.runasp.net/TravelImages/5/2.jpeg","https://journeymate.runasp.net/TravelImages/5/3.jpeg"]
/// itineraries : []

class ItemsDiscount {
  ItemsDiscount({
      num? id, 
      String? title, 
      String? description, 
      num? price, 
      num? baseCost, 
      num? saleDiscount, 
      String? startDate, 
      String? endDate, 
      String? creationDate, 
      num? availableSeats, 
      String? departurePoint, 
      num? departurePointLat, 
      num? departurePointLng, 
      String? destinationCity, 
      num? destinationCityLat, 
      num? destinationCityLng, 
      String? transportationType, 
      List<String>? amenities, 
      String? coverImageUrl, 
      dynamic profileImageUrl, 
      String? companyProfileImageUrl, 
      List<dynamic>? included, 
      List<dynamic>? notIncluded, 
      dynamic specialOffer, 
      num? companyId, 
      String? companyName, 
      num? categoryId, 
      dynamic categoryName, 
      List<String>? imageUrls, 
      List<dynamic>? itineraries,}){
    _id = id;
    _title = title;
    _description = description;
    _price = price;
    _baseCost = baseCost;
    _saleDiscount = saleDiscount;
    _startDate = startDate;
    _endDate = endDate;
    _creationDate = creationDate;
    _availableSeats = availableSeats;
    _departurePoint = departurePoint;
    _departurePointLat = departurePointLat;
    _departurePointLng = departurePointLng;
    _destinationCity = destinationCity;
    _destinationCityLat = destinationCityLat;
    _destinationCityLng = destinationCityLng;
    _transportationType = transportationType;
    _amenities = amenities;
    _coverImageUrl = coverImageUrl;
    _profileImageUrl = profileImageUrl;
    _companyProfileImageUrl = companyProfileImageUrl;
    _included = included;
    _notIncluded = notIncluded;
    _specialOffer = specialOffer;
    _companyId = companyId;
    _companyName = companyName;
    _categoryId = categoryId;
    _categoryName = categoryName;
    _imageUrls = imageUrls;
    _itineraries = itineraries;
}

  ItemsDiscount.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _price = json['price'];
    _baseCost = json['baseCost'];
    _saleDiscount = json['saleDiscount'];
    _startDate = json['startDate'];
    _endDate = json['endDate'];
    _creationDate = json['creationDate'];
    _availableSeats = json['availableSeats'];
    _departurePoint = json['departurePoint'];
    _departurePointLat = json['departurePointLat'];
    _departurePointLng = json['departurePointLng'];
    _destinationCity = json['destinationCity'];
    _destinationCityLat = json['destinationCityLat'];
    _destinationCityLng = json['destinationCityLng'];
    _transportationType = json['transportationType'];
    _amenities = json['amenities'] != null ? json['amenities'].cast<String>() : [];
    _coverImageUrl = json['coverImageUrl'];
    _profileImageUrl = json['profileImageUrl'];
    _companyProfileImageUrl = json['companyProfileImageUrl'];
    if (json['included'] != null) {
      _included = [];
      json['included'].forEach((v) {
        _included?.add(v);
      });
    }
    if (json['notIncluded'] != null) {
      _notIncluded = [];
      json['notIncluded'].forEach((v) {
        _notIncluded?.add(v);
      });
    }
    _specialOffer = json['specialOffer'];
    _companyId = json['companyId'];
    _companyName = json['companyName'];
    _categoryId = json['categoryId'];
    _categoryName = json['categoryName'];
    _imageUrls = json['imageUrls'] != null ? json['imageUrls'].cast<String>() : [];
    if (json['itineraries'] != null) {
      _itineraries = [];
      json['itineraries'].forEach((v) {
        _itineraries?.add(v);
      });
    }
  }
  num? _id;
  String? _title;
  String? _description;
  num? _price;
  num? _baseCost;
  num? _saleDiscount;
  String? _startDate;
  String? _endDate;
  String? _creationDate;
  num? _availableSeats;
  String? _departurePoint;
  num? _departurePointLat;
  num? _departurePointLng;
  String? _destinationCity;
  num? _destinationCityLat;
  num? _destinationCityLng;
  String? _transportationType;
  List<String>? _amenities;
  String? _coverImageUrl;
  dynamic _profileImageUrl;
  String? _companyProfileImageUrl;
  List<dynamic>? _included;
  List<dynamic>? _notIncluded;
  dynamic _specialOffer;
  num? _companyId;
  String? _companyName;
  num? _categoryId;
  dynamic _categoryName;
  List<String>? _imageUrls;
  List<dynamic>? _itineraries;
  ItemsDiscount copyWith({  num? id,
  String? title,
  String? description,
  num? price,
  num? baseCost,
  num? saleDiscount,
  String? startDate,
  String? endDate,
  String? creationDate,
  num? availableSeats,
  String? departurePoint,
  num? departurePointLat,
  num? departurePointLng,
  String? destinationCity,
  num? destinationCityLat,
  num? destinationCityLng,
  String? transportationType,
  List<String>? amenities,
  String? coverImageUrl,
  dynamic profileImageUrl,
  String? companyProfileImageUrl,
  List<dynamic>? included,
  List<dynamic>? notIncluded,
  dynamic specialOffer,
  num? companyId,
  String? companyName,
  num? categoryId,
  dynamic categoryName,
  List<String>? imageUrls,
  List<dynamic>? itineraries,
}) => ItemsDiscount(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  price: price ?? _price,
  baseCost: baseCost ?? _baseCost,
  saleDiscount: saleDiscount ?? _saleDiscount,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  creationDate: creationDate ?? _creationDate,
  availableSeats: availableSeats ?? _availableSeats,
  departurePoint: departurePoint ?? _departurePoint,
  departurePointLat: departurePointLat ?? _departurePointLat,
  departurePointLng: departurePointLng ?? _departurePointLng,
  destinationCity: destinationCity ?? _destinationCity,
  destinationCityLat: destinationCityLat ?? _destinationCityLat,
  destinationCityLng: destinationCityLng ?? _destinationCityLng,
  transportationType: transportationType ?? _transportationType,
  amenities: amenities ?? _amenities,
  coverImageUrl: coverImageUrl ?? _coverImageUrl,
  profileImageUrl: profileImageUrl ?? _profileImageUrl,
  companyProfileImageUrl: companyProfileImageUrl ?? _companyProfileImageUrl,
  included: included ?? _included,
  notIncluded: notIncluded ?? _notIncluded,
  specialOffer: specialOffer ?? _specialOffer,
  companyId: companyId ?? _companyId,
  companyName: companyName ?? _companyName,
  categoryId: categoryId ?? _categoryId,
  categoryName: categoryName ?? _categoryName,
  imageUrls: imageUrls ?? _imageUrls,
  itineraries: itineraries ?? _itineraries,
);
  num? get id => _id;
  String? get title => _title;
  String? get description => _description;
  num? get price => _price;
  num? get baseCost => _baseCost;
  num? get saleDiscount => _saleDiscount;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get creationDate => _creationDate;
  num? get availableSeats => _availableSeats;
  String? get departurePoint => _departurePoint;
  num? get departurePointLat => _departurePointLat;
  num? get departurePointLng => _departurePointLng;
  String? get destinationCity => _destinationCity;
  num? get destinationCityLat => _destinationCityLat;
  num? get destinationCityLng => _destinationCityLng;
  String? get transportationType => _transportationType;
  List<String>? get amenities => _amenities;
  String? get coverImageUrl => _coverImageUrl;
  dynamic get profileImageUrl => _profileImageUrl;
  String? get companyProfileImageUrl => _companyProfileImageUrl;
  List<dynamic>? get included => _included;
  List<dynamic>? get notIncluded => _notIncluded;
  dynamic get specialOffer => _specialOffer;
  num? get companyId => _companyId;
  String? get companyName => _companyName;
  num? get categoryId => _categoryId;
  dynamic get categoryName => _categoryName;
  List<String>? get imageUrls => _imageUrls;
  List<dynamic>? get itineraries => _itineraries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['price'] = _price;
    map['baseCost'] = _baseCost;
    map['saleDiscount'] = _saleDiscount;
    map['startDate'] = _startDate;
    map['endDate'] = _endDate;
    map['creationDate'] = _creationDate;
    map['availableSeats'] = _availableSeats;
    map['departurePoint'] = _departurePoint;
    map['departurePointLat'] = _departurePointLat;
    map['departurePointLng'] = _departurePointLng;
    map['destinationCity'] = _destinationCity;
    map['destinationCityLat'] = _destinationCityLat;
    map['destinationCityLng'] = _destinationCityLng;
    map['transportationType'] = _transportationType;
    map['amenities'] = _amenities;
    map['coverImageUrl'] = _coverImageUrl;
    map['profileImageUrl'] = _profileImageUrl;
    map['companyProfileImageUrl'] = _companyProfileImageUrl;
    if (_included != null) {
      map['included'] = _included?.map((v) => v.toJson()).toList();
    }
    if (_notIncluded != null) {
      map['notIncluded'] = _notIncluded?.map((v) => v.toJson()).toList();
    }
    map['specialOffer'] = _specialOffer;
    map['companyId'] = _companyId;
    map['companyName'] = _companyName;
    map['categoryId'] = _categoryId;
    map['categoryName'] = _categoryName;
    map['imageUrls'] = _imageUrls;
    if (_itineraries != null) {
      map['itineraries'] = _itineraries?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}