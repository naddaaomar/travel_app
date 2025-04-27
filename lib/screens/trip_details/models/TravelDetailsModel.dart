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
/// companyId : 15
/// companyName : "Aswan Adventures"
/// imageUrls : ["https://journeymate.runasp.net/TravelImages/1/1.jpeg","https://journeymate.runasp.net/TravelImages/1/2.jpeg","https://journeymate.runasp.net/TravelImages/1/3.jpeg"]
/// itenraries : [{"dayNumber":1,"activities":["Board ship","Welcome dinner","Evening show"]},{"dayNumber":2,"activities":["At sea","Pool activities","Wine tasting"]},{"dayNumber":3,"activities":["Port visit: Marseille","City tour","Local cuisine tasting"]}]

class TravelDetailsModel {
  TravelDetailsModel({
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
      List<Itenraries>? itenraries,}){
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

  TravelDetailsModel.fromJson(dynamic json) {
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
  List<Itenraries>? _itenraries;
TravelDetailsModel copyWith({  num? id,
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
  List<Itenraries>? itenraries,
}) => TravelDetailsModel(  id: id ?? _id,
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
  List<Itenraries>? get itenraries => _itenraries;

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

/// dayNumber : 1
/// activities : ["Board ship","Welcome dinner","Evening show"]

class Itenraries {
  Itenraries({
      num? dayNumber, 
      List<String>? activities,}){
    _dayNumber = dayNumber;
    _activities = activities;
}

  Itenraries.fromJson(dynamic json) {
    _dayNumber = json['dayNumber'];
    _activities = json['activities'] != null ? json['activities'].cast<String>() : [];
  }
  num? _dayNumber;
  List<String>? _activities;
Itenraries copyWith({  num? dayNumber,
  List<String>? activities,
}) => Itenraries(  dayNumber: dayNumber ?? _dayNumber,
  activities: activities ?? _activities,
);
  num? get dayNumber => _dayNumber;
  List<String>? get activities => _activities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dayNumber'] = _dayNumber;
    map['activities'] = _activities;
    return map;
  }

}