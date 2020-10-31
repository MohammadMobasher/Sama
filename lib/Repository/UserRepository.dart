import 'package:flutter/cupertino.dart';
import 'package:sama/Model/DTO/LoginDTO.dart';
import 'package:sama/Model/User.dart';
import 'package:sama/SamaBase/Network/ApiProvider.dart';
import 'package:sama/SamaBase/Network/NetworkRespons.dart';

class UserRepository {
  final ApiProvider apiProvider;

  UserRepository({@required this.apiProvider}) : assert((apiProvider != null));

  Future<Login> login(String userName, String password) async {
    var response = await apiProvider
        .post('auth/login?username=$userName&password=$password');
    if (response.status == Status.Unauthorised) {
      return Login();
    }
    return Login.fromJson(response.data);
  }

  Future<List<User>> searchByName(String name) async {
    List<User> users;

    var result = await apiProvider.get("users?search=$name");

    if (result.status != Status.ERROR) {
      users = (result.data as List).map((item) => User.fromJson(item)).toList();
    }
    return users;
  }

  Future<Login> changePassword(String currentPassword, String newPassword,
      String confirmPassword) async {
    var response = await apiProvider.post(
        'auth/update-profile?current_password=$currentPassword&new_password=$newPassword&confirm_password=$confirmPassword');
    if (response.status == Status.Unauthorised) {
      return Login();
    }
    return Login.fromJson(response.data);
  }
}
