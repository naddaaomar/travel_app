import 'package:p/screens/company_profile/models/CompanyDetails.dart';

/// items : [{"id":1,"title":"Mediterranean Cruise","description":"7-day cruise exploring the Mediterranean coast","price":1500.00,"startDate":"2025-05-23T00:00:00","endDate":"2025-05-30T00:00:00","creationDate":"2025-04-23T00:00:00","availableSeats":50,"departurePoint":"Barcelona Port","departurePointLat":41.3851,"departurePointLng":2.1734,"destinationCity":"Multiple Cities","destinationCityLat":0,"destinationCityLng":0,"transportationType":"Cruise Ship","amenities":["Pool","Spa","Restaurants","Entertainment"],"companyId":5,"companyName":"Pyramids Gateway","imageUrls":["https://journeymate.runasp.net/TravelImages/1/1.jpeg","https://journeymate.runasp.net/TravelImages/1/2.jpeg","https://journeymate.runasp.net/TravelImages/1/3.jpeg"],"itenraries":[]},{"id":2,"title":"Alpine Adventure","description":"5-day hiking tour through the Alps","price":950.00,"startDate":"2025-06-07T00:00:00","endDate":"2025-06-12T00:00:00","creationDate":"2025-04-23T00:00:00","availableSeats":20,"departurePoint":"Munich Central Station","departurePointLat":48.1351,"departurePointLng":11.582,"destinationCity":"Chamonix","destinationCityLat":45.9237,"destinationCityLng":6.8694,"transportationType":"Bus","amenities":["Guided tours","Equipment rental","Meals included"],"companyId":10,"companyName":"Tut Treks","imageUrls":["https://journeymate.runasp.net/TravelImages/2/1.jpeg","https://journeymate.runasp.net/TravelImages/2/2.jpeg","https://journeymate.runasp.net/TravelImages/2/3.jpeg"],"itenraries":[]},{"id":3,"title":"Japan Cultural Tour","description":"10-day cultural exploration of Japan","price":2500.00,"startDate":"2025-06-22T00:00:00","endDate":"2025-07-02T00:00:00","creationDate":"2025-04-23T00:00:00","availableSeats":30,"departurePoint":"Tokyo Narita Airport","departurePointLat":35.7647,"departurePointLng":140.3861,"destinationCity":"Kyoto","destinationCityLat":35.0116,"destinationCityLng":135.7681,"transportationType":"Train","amenities":["Guided tours","Traditional meals","Temple visits"],"companyId":20,"companyName":"Mystic Egypt Tours","imageUrls":["https://journeymate.runasp.net/TravelImages/3/1.jpeg","https://journeymate.runasp.net/TravelImages/3/2.jpeg","https://journeymate.runasp.net/TravelImages/3/3.jpeg"],"itenraries":[]},{"id":4,"title":"Safari Expedition","description":"8-day wildlife safari in Tanzania","price":3500.00,"startDate":"2025-07-22T00:00:00","endDate":"2025-07-30T00:00:00","creationDate":"2025-04-23T00:00:00","availableSeats":15,"departurePoint":"Kilimanjaro Airport","departurePointLat":-3.4294,"departurePointLng":37.0745,"destinationCity":"Serengeti","destinationCityLat":-2.3333,"destinationCityLng":34.8333,"transportationType":"Jeep","amenities":["Safari guides","Camping gear","Wildlife photography"],"companyId":19,"companyName":"Cairo Compass","imageUrls":["https://journeymate.runasp.net/TravelImages/4/1.jpeg","https://journeymate.runasp.net/TravelImages/4/2.jpeg","https://journeymate.runasp.net/TravelImages/4/3.jpeg"],"itenraries":[]},{"id":5,"title":"Caribbean Island Hopping","description":"6-day island-hopping adventure","price":1400.00,"startDate":"2025-05-13T00:00:00","endDate":"2025-05-19T00:00:00","creationDate":"2025-04-23T00:00:00","availableSeats":40,"departurePoint":"Miami Port","departurePointLat":25.7617,"departurePointLng":-80.1918,"destinationCity":"Multiple Islands","destinationCityLat":0,"destinationCityLng":0,"transportationType":"Cruise Ship","amenities":["Beach access","Snorkeling","Live music"],"companyId":15,"companyName":"Aswan Adventures","imageUrls":["https://journeymate.runasp.net/TravelImages/5/1.jpeg","https://journeymate.runasp.net/TravelImages/5/2.jpeg","https://journeymate.runasp.net/TravelImages/5/3.jpeg"],"itenraries":[]}]
/// totalCount : 12
/// totalPages : 3
/// fromItem : 1
/// toItem : 5

class AllTravelsModel {
  AllTravelsModel({
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

  AllTravelsModel.fromJson(dynamic json) {
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
AllTravelsModel copyWith({  List<Items>? items,
  num? totalCount,
  num? totalPages,
  num? fromItem,
  num? toItem,
}) => AllTravelsModel(  items: items ?? _items,
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

/// id : 1
/// title : "Mediterranean Cruise"
/// description : "7-day cruise exploring the Mediterranean coast"
/// price : 1500.00
/// startDate : "2025-05-23T00:00:00"
/// endDate : "2025-05-30T00:00:00"
/// creationDate : "2025-04-23T00:00:00"
/// availableSeats : 50
/// departurePoint : "Barcelona Port"
/// departurePointLat : 41.3851
/// departurePointLng : 2.1734
/// destinationCity : "Multiple Cities"
/// destinationCityLat : 0
/// destinationCityLng : 0
/// transportationType : "Cruise Ship"
/// amenities : ["Pool","Spa","Restaurants","Entertainment"]
/// companyId : 5
/// companyName : "Pyramids Gateway"
/// imageUrls : ["https://journeymate.runasp.net/TravelImages/1/1.jpeg","https://journeymate.runasp.net/TravelImages/1/2.jpeg","https://journeymate.runasp.net/TravelImages/1/3.jpeg"]
/// itenraries : []

class Items {
  Items({
      num? id, 
      String? title, 
      String? description, 
      num? price, 
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
      num? companyId, 
      String? companyName, 
      List<String>? imageUrls, 
      List<dynamic>? itenraries,}){
    _id = id;
    _title = title;
    _description = description;
    _price = price;
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
    _companyId = companyId;
    _companyName = companyName;
    _imageUrls = imageUrls;
    _itenraries = itenraries;
}

  Items.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _price = json['price'];
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
    _companyId = json['companyId'];
    _companyName = json['companyName'];
    _imageUrls = json['imageUrls'] != null ? json['imageUrls'].cast<String>() : [];
    if (json['itenraries'] != null) {
      _itenraries = [];
      json['itenraries'].forEach((v) {
        _itenraries?.add(Itenraries.fromJson(v));
      });
    }
  }
  num? _id;
  String? _title;
  String? _description;
  num? _price;
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
  num? _companyId;
  String? _companyName;
  List<String>? _imageUrls;
  List<dynamic>? _itenraries;
Items copyWith({  num? id,
  String? title,
  String? description,
  num? price,
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
  num? companyId,
  String? companyName,
  List<String>? imageUrls,
  List<dynamic>? itenraries,
}) => Items(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  price: price ?? _price,
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
  companyId: companyId ?? _companyId,
  companyName: companyName ?? _companyName,
  imageUrls: imageUrls ?? _imageUrls,
  itenraries: itenraries ?? _itenraries,
);
  num? get id => _id;
  String? get title => _title;
  String? get description => _description;
  num? get price => _price;
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
  num? get companyId => _companyId;
  String? get companyName => _companyName;
  List<String>? get imageUrls => _imageUrls;
  List<dynamic>? get itenraries => _itenraries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['price'] = _price;
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
    map['companyId'] = _companyId;
    map['companyName'] = _companyName;
    map['imageUrls'] = _imageUrls;
    if (_itenraries != null) {
      map['itenraries'] = _itenraries?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}