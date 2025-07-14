
class EventsModel {
  EventsModel({
    String? title,
    String? category,
    String? dates,
    dynamic date,
    String? location,
    String? link,
    String? image,
    String? mapLink,
    dynamic type,
    dynamic description,
    dynamic url,
    num? id,}){
    _title = title;
    _category = category;
    _dates = dates;
    _date = date;
    _location = location;
    _link = link;
    _image = image;
    _mapLink = mapLink;
    _type = type;
    _description = description;
    _url = url;
    _id = id;
  }

  EventsModel.fromJson(dynamic json) {
    _title = json['title'];
    _category = json['category'];
    _dates = json['dates'];
    _date = json['date'];
    _location = json['location'];
    _link = json['link'];
    _image = json['image'];
    _mapLink = json['map_Link'];
    _type = json['type'];
    _description = json['description'];
    _url = json['url'];
    _id = json['id'];
  }
  String? _title;
  String? _category;
  String? _dates;
  dynamic _date;
  String? _location;
  String? _link;
  String? _image;
  String? _mapLink;
  dynamic _type;
  dynamic _description;
  dynamic _url;
  num? _id;
  EventsModel copyWith({  String? title,
    String? category,
    String? dates,
    dynamic date,
    String? location,
    String? link,
    String? image,
    String? mapLink,
    dynamic type,
    dynamic description,
    dynamic url,
    num? id,
  }) => EventsModel(  title: title ?? _title,
    category: category ?? _category,
    dates: dates ?? _dates,
    date: date ?? _date,
    location: location ?? _location,
    link: link ?? _link,
    image: image ?? _image,
    mapLink: mapLink ?? _mapLink,
    type: type ?? _type,
    description: description ?? _description,
    url: url ?? _url,
    id: id ?? _id,
  );
  String? get title => _title;
  String? get category => _category;
  String? get dates => _dates;
  dynamic get date => _date;
  String? get location => _location;
  String? get link => _link;
  String? get image => _image;
  String? get mapLink => _mapLink;
  dynamic get type => _type;
  dynamic get description => _description;
  dynamic get url => _url;
  num? get id => _id;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['title'] = _title;
    map['category'] = _category;
    map['dates'] = _dates;
    map['date'] = _date;
    map['location'] = _location;
    map['link'] = _link;
    map['image'] = _image;
    map['map_Link'] = _mapLink;
    map['type'] = _type;
    map['description'] = _description;
    map['url'] = _url;
    map['id'] = _id;
    return map;
  }

}