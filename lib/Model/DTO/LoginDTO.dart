import 'package:sama/Model/User.dart';

class Login {
  String accessToken;
  String tokenType;
  int expiresIn;
  User user;

  Login({this.accessToken, this.tokenType, this.expiresIn, this.user});

  Login.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}