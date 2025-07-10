

class CompanyDetailsModel {
  CompanyDetailsModel({
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
      List<SocialMediaLinks>? socialMediaLinks, 
      List<PaymentMethods>? paymentMethods, 
      List<Ratings>? ratings, 
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

  CompanyDetailsModel.fromJson(dynamic json) {
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
        _socialMediaLinks?.add(SocialMediaLinks.fromJson(v));
      });
    }
    if (json['paymentMethods'] != null) {
      _paymentMethods = [];
      json['paymentMethods'].forEach((v) {
        _paymentMethods?.add(PaymentMethods.fromJson(v));
      });
    }
    if (json['ratings'] != null) {
      _ratings = [];
      json['ratings'].forEach((v) {
        _ratings?.add(Ratings.fromJson(v));
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
  List<SocialMediaLinks>? _socialMediaLinks;
  List<PaymentMethods>? _paymentMethods;
  List<Ratings>? _ratings;
  List<Travels>? _travels;
  List<WorkingHours>? _workingHours;
CompanyDetailsModel copyWith({  num? id,
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
  List<SocialMediaLinks>? socialMediaLinks,
  List<PaymentMethods>? paymentMethods,
  List<Ratings>? ratings,
  List<Travels>? travels,
  List<WorkingHours>? workingHours,
}) => CompanyDetailsModel(  id: id ?? _id,
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
  List<SocialMediaLinks>? get socialMediaLinks => _socialMediaLinks;
  List<PaymentMethods>? get paymentMethods => _paymentMethods;
  List<Ratings>? get ratings => _ratings;
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

/// dayOfWeek : "string"
/// workingTime : "string"

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

/// id : 0
/// title : "string"
/// description : "string"
/// price : 0
/// baseCost : 0
/// saleDiscount : 0
/// startDate : "2025-07-09T08:39:50.109Z"
/// endDate : "2025-07-09T08:39:50.109Z"
/// creationDate : "2025-07-09T08:39:50.109Z"
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



class Ratings {
  Ratings({
      String? userId, 
      String? name, 
      num? companyId, 
      num? rating, 
      String? message,}){
    _userId = userId;
    _name = name;
    _companyId = companyId;
    _rating = rating;
    _message = message;
}

  Ratings.fromJson(dynamic json) {
    _userId = json['userId'];
    _name = json['name'];
    _companyId = json['companyId'];
    _rating = json['rating'];
    _message = json['message'];
  }
  String? _userId;
  String? _name;
  num? _companyId;
  num? _rating;
  String? _message;
Ratings copyWith({  String? userId,
  String? name,
  num? companyId,
  num? rating,
  String? message,
}) => Ratings(  userId: userId ?? _userId,
  name: name ?? _name,
  companyId: companyId ?? _companyId,
  rating: rating ?? _rating,
  message: message ?? _message,
);
  String? get userId => _userId;
  String? get name => _name;
  num? get companyId => _companyId;
  num? get rating => _rating;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['name'] = _name;
    map['companyId'] = _companyId;
    map['rating'] = _rating;
    map['message'] = _message;
    return map;
  }

}


class PaymentMethods {
  PaymentMethods({
      String? type, 
      String? provider,}){
    _type = type;
    _provider = provider;
}

  PaymentMethods.fromJson(dynamic json) {
    _type = json['type'];
    _provider = json['provider'];
  }
  String? _type;
  String? _provider;
PaymentMethods copyWith({  String? type,
  String? provider,
}) => PaymentMethods(  type: type ?? _type,
  provider: provider ?? _provider,
);
  String? get type => _type;
  String? get provider => _provider;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['provider'] = _provider;
    return map;
  }

}

/// platform : "string"
/// url : "string"

class SocialMediaLinks {
  SocialMediaLinks({
      String? platform, 
      String? url,}){
    _platform = platform;
    _url = url;
}

  SocialMediaLinks.fromJson(dynamic json) {
    _platform = json['platform'];
    _url = json['url'];
  }
  String? _platform;
  String? _url;
SocialMediaLinks copyWith({  String? platform,
  String? url,
}) => SocialMediaLinks(  platform: platform ?? _platform,
  url: url ?? _url,
);
  String? get platform => _platform;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['platform'] = _platform;
    map['url'] = _url;
    return map;
  }

}