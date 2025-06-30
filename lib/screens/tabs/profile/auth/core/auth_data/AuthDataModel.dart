/// message : null
/// isAuthenticated : true
/// userName : "a"
/// emailorNumber : "a@gmail.com"
/// token : "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9naXZlbm5hbWUiOiJhIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiYUBnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJVc2VyIiwiZXhwIjoxNzQ3NTg0MjAyLCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo3MTI2IiwiYXVkIjoiTXlTZWN1cmVkQVBJVXNlcnMifQ.q8NBvicLJsJi8LNxywP4Rccx25gC5jI4SWHtKH9dhQQ"

class AuthDataModel {
  AuthDataModel({
    dynamic message,
    bool? isAuthenticated,
    String? userName,
    String? emailorNumber,
    String? token,}){
    _message = message;
    _isAuthenticated = isAuthenticated;
    _userName = userName;
    _emailorNumber = emailorNumber;
    _token = token;
  }

  AuthDataModel.fromJson(dynamic json) {
    _message = json['message'];
    _isAuthenticated = json['isAuthenticated'];
    _userName = json['userName'];
    _emailorNumber = json['emailorNumber'];
    _token = json['token'];
  }
  dynamic _message;
  bool? _isAuthenticated;
  String? _userName;
  String? _emailorNumber;
  String? _token;
  AuthDataModel copyWith({  dynamic message,
    bool? isAuthenticated,
    String? userName,
    String? emailorNumber,
    String? token,
  }) => AuthDataModel(  message: message ?? _message,
    isAuthenticated: isAuthenticated ?? _isAuthenticated,
    userName: userName ?? _userName,
    emailorNumber: emailorNumber ?? _emailorNumber,
    token: token ?? _token,
  );
  dynamic get message => _message;
  bool? get isAuthenticated => _isAuthenticated;
  String? get userName => _userName;
  String? get emailorNumber => _emailorNumber;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['isAuthenticated'] = _isAuthenticated;
    map['userName'] = _userName;
    map['emailorNumber'] = _emailorNumber;
    map['token'] = _token;
    return map;
  }

}