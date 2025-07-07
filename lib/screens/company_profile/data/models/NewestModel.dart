/// items : [{"id":0,"title":"string","description":"string","price":0,"baseCost":0,"saleDiscount":0,"startDate":"2025-07-05T05:32:01.302Z","endDate":"2025-07-05T05:32:01.302Z","creationDate":"2025-07-05T05:32:01.302Z","availableSeats":0,"departurePoint":"string","departurePointLat":0,"departurePointLng":0,"destinationCity":"string","destinationCityLat":0,"destinationCityLng":0,"transportationType":"string","amenities":["string"],"coverImageUrl":"string","profileImageUrl":"string","companyProfileImageUrl":"string","included":["string"],"notIncluded":["string"],"specialOffer":"string","companyId":0,"companyName":"string","categoryId":0,"categoryName":"string","imageUrls":["string"],"itineraries":[{"title":"string","dayNumber":0,"description":"string","startTime":"string","endTime":"string","location":"string","activities":["string"],"includesBreakfast":true,"includesLunch":true,"includesDinner":true,"notes":"string"}]}]
/// totalCount : 0
/// totalPages : 0
/// fromItem : 0
/// toItem : 0

class NewestModel {
  NewestModel({
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

  NewestModel.fromJson(dynamic json) {
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
NewestModel copyWith({  List<Items>? items,
  num? totalCount,
  num? totalPages,
  num? fromItem,
  num? toItem,
}) => NewestModel(  items: items ?? _items,
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

/// id : 0
/// title : "string"
/// description : "string"
/// price : 0
/// baseCost : 0
/// saleDiscount : 0
/// startDate : "2025-07-05T05:32:01.302Z"
/// endDate : "2025-07-05T05:32:01.302Z"
/// creationDate : "2025-07-05T05:32:01.302Z"
/// availableSeats : 0
/// departurePoint : "string"
/// departurePointLat : 0
/// departurePointLng : 0
/// destinationCity : "string"
/// destinationCityLat : 0
/// destinationCityLng : 0
/// transportationType : "string"
/// amenities : ["string"]
/// coverImageUrl : "string"
/// profileImageUrl : "string"
/// companyProfileImageUrl : "string"
/// included : ["string"]
/// notIncluded : ["string"]
/// specialOffer : "string"
/// companyId : 0
/// companyName : "string"
/// categoryId : 0
/// categoryName : "string"
/// imageUrls : ["string"]
/// itineraries : [{"title":"string","dayNumber":0,"description":"string","startTime":"string","endTime":"string","location":"string","activities":["string"],"includesBreakfast":true,"includesLunch":true,"includesDinner":true,"notes":"string"}]

class Items {
  Items({
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
      String? profileImageUrl, 
      String? companyProfileImageUrl, 
      List<String>? included, 
      List<String>? notIncluded, 
      String? specialOffer, 
      num? companyId, 
      String? companyName, 
      num? categoryId, 
      String? categoryName, 
      List<String>? imageUrls, 
      List<Itineraries>? itineraries,}){
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

  Items.fromJson(dynamic json) {
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
    _included = json['included'] != null ? json['included'].cast<String>() : [];
    _notIncluded = json['notIncluded'] != null ? json['notIncluded'].cast<String>() : [];
    _specialOffer = json['specialOffer'];
    _companyId = json['companyId'];
    _companyName = json['companyName'];
    _categoryId = json['categoryId'];
    _categoryName = json['categoryName'];
    _imageUrls = json['imageUrls'] != null ? json['imageUrls'].cast<String>() : [];
    if (json['itineraries'] != null) {
      _itineraries = [];
      json['itineraries'].forEach((v) {
        _itineraries?.add(Itineraries.fromJson(v));
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
  String? _profileImageUrl;
  String? _companyProfileImageUrl;
  List<String>? _included;
  List<String>? _notIncluded;
  String? _specialOffer;
  num? _companyId;
  String? _companyName;
  num? _categoryId;
  String? _categoryName;
  List<String>? _imageUrls;
  List<Itineraries>? _itineraries;
Items copyWith({  num? id,
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
  String? profileImageUrl,
  String? companyProfileImageUrl,
  List<String>? included,
  List<String>? notIncluded,
  String? specialOffer,
  num? companyId,
  String? companyName,
  num? categoryId,
  String? categoryName,
  List<String>? imageUrls,
  List<Itineraries>? itineraries,
}) => Items(  id: id ?? _id,
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
  String? get profileImageUrl => _profileImageUrl;
  String? get companyProfileImageUrl => _companyProfileImageUrl;
  List<String>? get included => _included;
  List<String>? get notIncluded => _notIncluded;
  String? get specialOffer => _specialOffer;
  num? get companyId => _companyId;
  String? get companyName => _companyName;
  num? get categoryId => _categoryId;
  String? get categoryName => _categoryName;
  List<String>? get imageUrls => _imageUrls;
  List<Itineraries>? get itineraries => _itineraries;

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
    map['included'] = _included;
    map['notIncluded'] = _notIncluded;
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

/// title : "string"
/// dayNumber : 0
/// description : "string"
/// startTime : "string"
/// endTime : "string"
/// location : "string"
/// activities : ["string"]
/// includesBreakfast : true
/// includesLunch : true
/// includesDinner : true
/// notes : "string"

class Itineraries {
  Itineraries({
      String? title, 
      num? dayNumber, 
      String? description, 
      String? startTime, 
      String? endTime, 
      String? location, 
      List<String>? activities, 
      bool? includesBreakfast, 
      bool? includesLunch, 
      bool? includesDinner, 
      String? notes,}){
    _title = title;
    _dayNumber = dayNumber;
    _description = description;
    _startTime = startTime;
    _endTime = endTime;
    _location = location;
    _activities = activities;
    _includesBreakfast = includesBreakfast;
    _includesLunch = includesLunch;
    _includesDinner = includesDinner;
    _notes = notes;
}

  Itineraries.fromJson(dynamic json) {
    _title = json['title'];
    _dayNumber = json['dayNumber'];
    _description = json['description'];
    _startTime = json['startTime'];
    _endTime = json['endTime'];
    _location = json['location'];
    _activities = json['activities'] != null ? json['activities'].cast<String>() : [];
    _includesBreakfast = json['includesBreakfast'];
    _includesLunch = json['includesLunch'];
    _includesDinner = json['includesDinner'];
    _notes = json['notes'];
  }
  String? _title;
  num? _dayNumber;
  String? _description;
  String? _startTime;
  String? _endTime;
  String? _location;
  List<String>? _activities;
  bool? _includesBreakfast;
  bool? _includesLunch;
  bool? _includesDinner;
  String? _notes;
Itineraries copyWith({  String? title,
  num? dayNumber,
  String? description,
  String? startTime,
  String? endTime,
  String? location,
  List<String>? activities,
  bool? includesBreakfast,
  bool? includesLunch,
  bool? includesDinner,
  String? notes,
}) => Itineraries(  title: title ?? _title,
  dayNumber: dayNumber ?? _dayNumber,
  description: description ?? _description,
  startTime: startTime ?? _startTime,
  endTime: endTime ?? _endTime,
  location: location ?? _location,
  activities: activities ?? _activities,
  includesBreakfast: includesBreakfast ?? _includesBreakfast,
  includesLunch: includesLunch ?? _includesLunch,
  includesDinner: includesDinner ?? _includesDinner,
  notes: notes ?? _notes,
);
  String? get title => _title;
  num? get dayNumber => _dayNumber;
  String? get description => _description;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get location => _location;
  List<String>? get activities => _activities;
  bool? get includesBreakfast => _includesBreakfast;
  bool? get includesLunch => _includesLunch;
  bool? get includesDinner => _includesDinner;
  String? get notes => _notes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['dayNumber'] = _dayNumber;
    map['description'] = _description;
    map['startTime'] = _startTime;
    map['endTime'] = _endTime;
    map['location'] = _location;
    map['activities'] = _activities;
    map['includesBreakfast'] = _includesBreakfast;
    map['includesLunch'] = _includesLunch;
    map['includesDinner'] = _includesDinner;
    map['notes'] = _notes;
    return map;
  }

}