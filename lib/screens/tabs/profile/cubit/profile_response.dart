import 'package:dio/dio.dart';

class ProfileResponse {
  ProfileResponse({
    String? status,
    dynamic message,
    User? user,}){
    _status = status;
    _message = message;
    _user = user;
  }

  ProfileResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _status;
  dynamic _message;
  User? _user;
  ProfileResponse copyWith({
    String? status,
    dynamic message,
    User? user,
  }) => ProfileResponse(
    status: status ?? _status,
    message: message ?? _message,
    user: user ?? _user,
  );
  String? get status => _status;
  dynamic get message => _message;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class User {
  User({
    String? name,
    String? email,
    String? token,}){
    _name = name;
    _email = email;
    _token = token;
  }

  User.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _token = json['token'];
  }
  String? _name;
  String? _email;
  String? _token;
  User copyWith({
    String? name,
    String? email,
    String? token,
  }) => User(  name: name ?? _name,
    email: email ?? _email,
    token: token ?? _token,
  );
  String? get name => _name;
  String? get email => _email;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['token'] = _token;
    return map;
  }
}

class ProfileData {
  Dio dio = Dio();

  getProfile({required String token}) async {
    try {
      var response = await dio.post(
          "https://journeymate.runasp.net/api/Auth/login",
          data: {"token": token});

      ProfileResponse profileResponse = ProfileResponse.fromJson(response.data);
      print(profileResponse.status);

      return profileResponse;
    } on DioException catch (e) {
      if (e.response == null) {
        print("nulllllll");
      }
      if (e.response != null) {
        print(e.error);
      }
    }
  }
}