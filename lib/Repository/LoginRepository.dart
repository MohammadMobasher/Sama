import 'package:flutter/cupertino.dart';
import 'package:sama/Model/DTO/LoginDTO.dart';
import 'package:sama/SamaBase/Network/ApiProvider.dart';
import 'package:sama/SamaBase/Network/NetworkRespons.dart';

class LoginRepository {
  final ApiProvider apiProvider;

  LoginRepository({@required this.apiProvider}) : assert((apiProvider != null));

  Future<Login> login(String userName, String password) async {
    var response = await apiProvider
        .post('auth/login?username=$userName&password=$password');
    if (response.status == Status.Unauthorised) {
      return Login();
    }
    return Login.fromJson(response.data);
  }
}
