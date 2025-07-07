
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

class Items {
  Items({
      num? id, 
      String? companyName, 
      String? address, 
      String? email, 
      String? phoneNumber, 
      String? description, 
      String? website, 
      String? slogan, 
      String? profileImageUrl, 
      String? coverImageUrl, 
      String? establishedDate, 
      num? rating, 
      List<dynamic>? socialMediaLinks, 
      List<dynamic>? paymentMethods, 
      List<dynamic>? ratings, 
      List<Travels>? travels, 
      List<WorkingHours>? workingHours,}){
    _id = id;
    _companyName = companyName;
    _address = address;
    _email = email;
    _phoneNumber = phoneNumber;
    _description = description;
    _website = website;
    _slogan = slogan;
    _profileImageUrl = profileImageUrl;
    _coverImageUrl = coverImageUrl;
    _establishedDate = establishedDate;
    _rating = rating;
    _socialMediaLinks = socialMediaLinks;
    _paymentMethods = paymentMethods;
    _ratings = ratings;
    _travels = travels;
    _workingHours = workingHours;
}

  Items.fromJson(dynamic json) {
    _id = json['id'];
    _companyName = json['companyName'];
    _address = json['address'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _description = json['description'];
    _website = json['website'];
    _slogan = json['slogan'];
    _profileImageUrl = json['profileImageUrl'];
    _coverImageUrl = json['coverImageUrl'];
    _establishedDate = json['establishedDate'];
    _rating = json['rating'];
    if (json['socialMediaLinks'] != null) {
      _socialMediaLinks = [];
      json['socialMediaLinks'].forEach((v) {
        _socialMediaLinks?.add(v);
      });
    }
    if (json['paymentMethods'] != null) {
      _paymentMethods = [];
      json['paymentMethods'].forEach((v) {
        _paymentMethods?.add(v);
      });
    }
    if (json['ratings'] != null) {
      _ratings = [];
      json['ratings'].forEach((v) {
        _ratings?.add(v);
      });
    }
    if (json['travels'] != null) {
      _travels = [];
      json['travels'].forEach((v) {
        _travels?.add(Travels.fromJson(v));
      });
    }
    if (json['workingHours'] != null) {
      _workingHours = [];
      json['workingHours'].forEach((v) {
        _workingHours?.add(WorkingHours.fromJson(v));
      });
    }
  }
  num? _id;
  String? _companyName;
  String? _address;
  String? _email;
  String? _phoneNumber;
  String? _description;
  String? _website;
  String? _slogan;
  String? _profileImageUrl;
  String? _coverImageUrl;
  String? _establishedDate;
  num? _rating;
  List<dynamic>? _socialMediaLinks;
  List<dynamic>? _paymentMethods;
  List<dynamic>? _ratings;
  List<Travels>? _travels;
  List<WorkingHours>? _workingHours;
Items copyWith({  num? id,
  String? companyName,
  String? address,
  String? email,
  String? phoneNumber,
  String? description,
  String? website,
  String? slogan,
  String? profileImageUrl,
  String? coverImageUrl,
  String? establishedDate,
  num? rating,
  List<dynamic>? socialMediaLinks,
  List<dynamic>? paymentMethods,
  List<dynamic>? ratings,
  List<Travels>? travels,
  List<WorkingHours>? workingHours,
}) => Items(  id: id ?? _id,
  companyName: companyName ?? _companyName,
  address: address ?? _address,
  email: email ?? _email,
  phoneNumber: phoneNumber ?? _phoneNumber,
  description: description ?? _description,
  website: website ?? _website,
  slogan: slogan ?? _slogan,
  profileImageUrl: profileImageUrl ?? _profileImageUrl,
  coverImageUrl: coverImageUrl ?? _coverImageUrl,
  establishedDate: establishedDate ?? _establishedDate,
  rating: rating ?? _rating,
  socialMediaLinks: socialMediaLinks ?? _socialMediaLinks,
  paymentMethods: paymentMethods ?? _paymentMethods,
  ratings: ratings ?? _ratings,
  travels: travels ?? _travels,
  workingHours: workingHours ?? _workingHours,
);
  num? get id => _id;
  String? get companyName => _companyName;
  String? get address => _address;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get description => _description;
  String? get website => _website;
  String? get slogan => _slogan;
  String? get profileImageUrl => _profileImageUrl;
  String? get coverImageUrl => _coverImageUrl;
  String? get establishedDate => _establishedDate;
  num? get rating => _rating;
  List<dynamic>? get socialMediaLinks => _socialMediaLinks;
  List<dynamic>? get paymentMethods => _paymentMethods;
  List<dynamic>? get ratings => _ratings;
  List<Travels>? get travels => _travels;
  List<WorkingHours>? get workingHours => _workingHours;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['companyName'] = _companyName;
    map['address'] = _address;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['description'] = _description;
    map['website'] = _website;
    map['slogan'] = _slogan;
    map['profileImageUrl'] = _profileImageUrl;
    map['coverImageUrl'] = _coverImageUrl;
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
    if (_workingHours != null) {
      map['workingHours'] = _workingHours?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// dayOfWeek : "Monday"
/// workingTime : "9:00 AM - 6:00 PM"

class WorkingHours {
  WorkingHours({
      String? dayOfWeek, 
      String? workingTime,}){
    _dayOfWeek = dayOfWeek;
    _workingTime = workingTime;
}

  WorkingHours.fromJson(dynamic json) {
    _dayOfWeek = json['dayOfWeek'];
    _workingTime = json['workingTime'];
  }
  String? _dayOfWeek;
  String? _workingTime;
WorkingHours copyWith({  String? dayOfWeek,
  String? workingTime,
}) => WorkingHours(  dayOfWeek: dayOfWeek ?? _dayOfWeek,
  workingTime: workingTime ?? _workingTime,
);
  String? get dayOfWeek => _dayOfWeek;
  String? get workingTime => _workingTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dayOfWeek'] = _dayOfWeek;
    map['workingTime'] = _workingTime;
    return map;
  }

}

/// id : 4
/// title : "Safari Expedition"
/// description : "8-day wildlife safari in Tanzania"
/// price : 3500
/// baseCost : 3000
/// saleDiscount : 0
/// startDate : "2025-07-22T00:00:00"
/// endDate : "2025-07-30T00:00:00"
/// creationDate : "2025-04-23T00:00:00"
/// availableSeats : 15
/// departurePoint : "Kilimanjaro Airport"
/// departurePointLat : -3.4294
/// departurePointLng : 37.0745
/// destinationCity : "Serengeti"
/// destinationCityLat : -2.3333
/// destinationCityLng : 34.8333
/// transportationType : "Jeep"
/// amenities : ["Safari guides","Camping gear","Wildlife photography"]
/// coverImageUrl : "https://i.pinimg.com/736x/14/7f/ea/147fea20f16d94e7960d2bd3b507fd2e.jpg"
/// profileImageUrl : null
/// companyProfileImageUrl : "https://journeymate.runasp.net//CompanyImages/1.jpg"
/// included : []
/// notIncluded : []
/// specialOffer : null
/// companyId : 4
/// companyName : "Ancient Pathways"
/// categoryId : 4
/// categoryName : null
/// imageUrls : []
/// itenraries : []

class Travels {
  Travels({
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
      List<dynamic>? imageUrls, 
      List<dynamic>? itenraries,}){
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
    _itenraries = itenraries;
}

  Travels.fromJson(dynamic json) {
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
    if (json['imageUrls'] != null) {
      _imageUrls = [];
      json['imageUrls'].forEach((v) {
        _imageUrls?.add(v);
      });
    }
    if (json['itenraries'] != null) {
      _itenraries = [];
      json['itenraries'].forEach((v) {
        _itenraries?.add(v);
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
  List<dynamic>? _imageUrls;
  List<dynamic>? _itenraries;
Travels copyWith({  num? id,
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
  List<dynamic>? imageUrls,
  List<dynamic>? itenraries,
}) => Travels(  id: id ?? _id,
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
  itenraries: itenraries ?? _itenraries,
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
  List<dynamic>? get imageUrls => _imageUrls;
  List<dynamic>? get itenraries => _itenraries;

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
    if (_imageUrls != null) {
      map['imageUrls'] = _imageUrls?.map((v) => v.toJson()).toList();
    }
    if (_itenraries != null) {
      map['itenraries'] = _itenraries?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}