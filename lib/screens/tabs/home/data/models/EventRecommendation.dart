/// title : "Ismailia International Folklore Festivals"
/// category : "Environment"
/// dates : null
/// date : "01 Oct - 31 Oct 2025"
/// location : "Ismailia"
/// link : "https://www.experienceegypt.eg/en/Event/86/ismailia-international-folklore-festivals"
/// image : "https://betamedia.experienceegypt.eg/media/experienceegypt/img/Original/2025/2/9/2025_2_9_12_53_2_335.jpg"
/// map_Link : "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d109917.12676878145!2d32.08102958787859!3d30.580080007828126!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x14f85956191e10b9%3A0x3b0933775b0f5b95!2sIsmailia%2C%20Ismailia%20Governorate!5e0!3m2!1sen!2seg!4v1739098386583!5m2!1sen!2seg"
/// type : null

class EventRecommendation {
  EventRecommendation({
      String? title, 
      String? category, 
      dynamic dates, 
      String? date, 
      String? location, 
      String? link, 
      String? image, 
      String? mapLink, 
      dynamic type,}){
    _title = title;
    _category = category;
    _dates = dates;
    _date = date;
    _location = location;
    _link = link;
    _image = image;
    _mapLink = mapLink;
    _type = type;
}

  EventRecommendation.fromJson(dynamic json) {
    _title = json['title'];
    _category = json['category'];
    _dates = json['dates'];
    _date = json['date'];
    _location = json['location'];
    _link = json['link'];
    _image = json['image'];
    _mapLink = json['map_Link'];
    _type = json['type'];
  }
  String? _title;
  String? _category;
  dynamic _dates;
  String? _date;
  String? _location;
  String? _link;
  String? _image;
  String? _mapLink;
  dynamic _type;
EventRecommendation copyWith({  String? title,
  String? category,
  dynamic dates,
  String? date,
  String? location,
  String? link,
  String? image,
  String? mapLink,
  dynamic type,
}) => EventRecommendation(  title: title ?? _title,
  category: category ?? _category,
  dates: dates ?? _dates,
  date: date ?? _date,
  location: location ?? _location,
  link: link ?? _link,
  image: image ?? _image,
  mapLink: mapLink ?? _mapLink,
  type: type ?? _type,
);
  String? get title => _title;
  String? get category => _category;
  dynamic get dates => _dates;
  String? get date => _date;
  String? get location => _location;
  String? get link => _link;
  String? get image => _image;
  String? get mapLink => _mapLink;
  dynamic get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['category'] = _category;
    map['dates'] = _dates;
    map['date'] = _date;
    map['location'] = _location;
    map['link'] = _link;
    map['image'] = _image;
    map['map_Link'] = _mapLink;
    map['type'] = _type;
    return map;
  }

}