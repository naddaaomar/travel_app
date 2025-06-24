import 'package:p/screens/all_companies/models/AllCompanies.dart';

/// id : 2
/// companyName : "Nile Explorers"
/// address : "Siwa, Market"
/// email : "contact@nileexplorers.eg"
/// phoneNumber : "+20 100 222 2222"
/// description : "Discover the hidden gems of Egypt with us."
/// website : "https://www.company2.eg"
/// slogan : "Sail Beyond Dreams."
/// profileImageUrl : "https://journeymate.runasp.net//CompanyImages/1.jpg"
/// coverImageUrl : "/CompanyImages/2.jpg"
/// establishedDate : "2018-10-18"
/// rating : 4
/// socialMediaLinks : []
/// paymentMethods : []
/// ratings : []
/// travels : [{"id":10,"title":"Patagonia Expedition","description":"10-day trekking in Patagonia","price":3200.00,"startDate":"2025-08-11T00:00:00","endDate":"2025-08-21T00:00:00","creationDate":"2025-04-23T00:00:00","availableSeats":18,"departurePoint":"El Calafate Airport","departurePointLat":-50.2803,"departurePointLng":-72.0531,"destinationCity":"Torres del Paine","destinationCityLat":-51.2539,"destinationCityLng":-73.4068,"transportationType":"Bus","amenities":["Trekking guides","Camping gear","Glacier tours"],"companyId":2,"companyName":"Nile Explorers","imageUrls":["https://journeymate.runasp.net/TravelImages/10/1.jpeg","https://journeymate.runasp.net/TravelImages/10/2.jpeg","https://journeymate.runasp.net/TravelImages/10/3.jpeg"],"itenraries":[]}]
/// workingHours : [{"dayOfWeek":"Monday","workingTime":"9:00 AM - 6:00 PM"},{"dayOfWeek":"Tuesday","workingTime":"9:00 AM - 6:00 PM"},{"dayOfWeek":"Wednesday","workingTime":"9:00 AM - 6:00 PM"},{"dayOfWeek":"Thursday","workingTime":"9:00 AM - 6:00 PM"},{"dayOfWeek":"Friday","workingTime":"9:00 AM - 6:00 PM"},{"dayOfWeek":"Saturday","workingTime":"Closed"},{"dayOfWeek":"Sunday","workingTime":"Closed"}]

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
    List<dynamic>? socialMediaLinks,
    List<dynamic>? paymentMethods,
    List<dynamic>? ratings,
    List<Travels>? travels,
    List<WorkingHours>? workingHours,
  }) {
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
  CompanyDetailsModel copyWith({
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
    List<WorkingHours>? workingHours,
  }) =>
      CompanyDetailsModel(
        id: id ?? _id,
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
      map['socialMediaLinks'] =
          _socialMediaLinks?.map((v) => v.toJson()).toList();
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
    String? workingTime,
  }) {
    _dayOfWeek = dayOfWeek;
    _workingTime = workingTime;
  }

  WorkingHours.fromJson(dynamic json) {
    _dayOfWeek = json['dayOfWeek'];
    _workingTime = json['workingTime'];
  }
  String? _dayOfWeek;
  String? _workingTime;
  WorkingHours copyWith({
    String? dayOfWeek,
    String? workingTime,
  }) =>
      WorkingHours(
        dayOfWeek: dayOfWeek ?? _dayOfWeek,
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

/// id : 10
/// title : "Patagonia Expedition"
/// description : "10-day trekking in Patagonia"
/// price : 3200.00
/// startDate : "2025-08-11T00:00:00"
/// endDate : "2025-08-21T00:00:00"
/// creationDate : "2025-04-23T00:00:00"
/// availableSeats : 18
/// departurePoint : "El Calafate Airport"
/// departurePointLat : -50.2803
/// departurePointLng : -72.0531
/// destinationCity : "Torres del Paine"
/// destinationCityLat : -51.2539
/// destinationCityLng : -73.4068
/// transportationType : "Bus"
/// amenities : ["Trekking guides","Camping gear","Glacier tours"]
/// companyId : 2
/// companyName : "Nile Explorers"
/// imageUrls : ["https://journeymate.runasp.net/TravelImages/10/1.jpeg","https://journeymate.runasp.net/TravelImages/10/2.jpeg","https://journeymate.runasp.net/TravelImages/10/3.jpeg"]
/// itenraries : []

class Travels {
  Travels({
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
    List<dynamic>? itenraries,
  }) {
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

  Travels.fromJson(dynamic json) {
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
    _amenities =
        json['amenities'] != null ? json['amenities'].cast<String>() : [];
    _companyId = json['companyId'];
    _companyName = json['companyName'];
    _imageUrls =
        json['imageUrls'] != null ? json['imageUrls'].cast<String>() : [];
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
  Travels copyWith({
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
    List<dynamic>? itenraries,
  }) =>
      Travels(
        id: id ?? _id,
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

class Itenraries {
  String? day;
  String? activity;

  Itenraries({this.day, this.activity});

  Itenraries.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    activity = json['activity'];
  }
}
