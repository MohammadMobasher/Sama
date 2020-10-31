import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:sama/SamaBase/Network/NetworkException.dart';
import 'package:sama/SamaBase/Network/NetworkRespons.dart';
import 'package:sama/Utilities/MPref.dart';

class ApiProvider<T> {
  ApiProvider() {
    // MPref.init();
  }
  final String _baseUrl = "http://mailservice.markazfeqhi.com/api/";

  Future<NetworkResponse> get(String url) async {
    var responseJson;
    var token = MPref.getString("AccessToken");
    try {
      final response = await http.get(_baseUrl + url, headers: {
        "Authorization": 'Bearer ' + token,
        "Accept": "application/json"
      });
      responseJson = _response(response);
    } catch (_) {
      print(_);
    }
    // on SocketException {
    //   throw FetchDataException('No Internet connection');
    // }
    return responseJson;
  }

  Future<NetworkResponse> post(String url, {Map<String, dynamic> body}) async {
    // try {
    var token = MPref.getString("AccessToken");
    final response = await http.post(_baseUrl + url,
        headers: {
          "Authorization": 'Bearer ' + token,
          "Accept": "application/json"
        },
        body: body);
    return await _response(response);

    //.timeout(const Duration(seconds: 60));
    // var result = await _response(response);
    // } catch (e) {
    //   print(e);
    // }
    // on SocketException {
    //   throw FetchDataException('No Internet connection');
    // }
    return null;
  }

  Future<NetworkResponse> _response(http.Response response) async {
    switch (response.statusCode) {
      case 422:
        var f = json.decode(response.body.toString());
        return NetworkResponse.completed(f);
      case 201:
        return NetworkResponse.completed("Complete");
      case 200:
        var f = json.decode(response.body.toString());
        return NetworkResponse.completed(f);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        //var d = json.decode(response.body);
        return NetworkResponse.unauthorised(null);
      // final prefs = await SharedPreferences.getInstance();
      // final userInfo = prefs.getStringList('userInfo') ?? [];
      // if (userInfo != null && userInfo.length > 0) {
      //   BlocProvider.of<LoginBLoc>(context).add(
      //     LoginEventSubmitPress(userName: "", password: ""),
      //   );
      // } else {}
      // throw UnauthorisedException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
