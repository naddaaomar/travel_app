/// userName : "string"
/// email : "string"
/// password : "string"

class AuthDataModel {
  final String? userName;
  final String? email;
  final String? password;
  final String? token;
  final String? refreshToken;

  AuthDataModel({
    this.userName,
    this.email,
    this.password,
    this.token,
    this.refreshToken,
  });

  factory AuthDataModel.fromJson(Map<String, dynamic> json) {
    return AuthDataModel(
      userName: json['userName'],
      email: json['email'],
      token: json['token'] ?? json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (userName != null) data['userName'] = userName;
    if (email != null) data['email'] = email;
    if (password != null) data['password'] = password;
    if (token != null) data['token'] = token;
    if (refreshToken != null) data['refreshToken'] = refreshToken;
    return data;
  }
}