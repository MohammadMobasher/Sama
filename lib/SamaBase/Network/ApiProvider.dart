import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:sama/Model/ViewModel/MessageForwardViewModel.dart';
import 'package:sama/Model/ViewModel/MessageInsertViewModel.dart';
import 'package:sama/Model/ViewModel/MessageReplyViewModel.dart';
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

  Future<bool> postWithFile(
      {String url, String path, MessageInsertViewModel vm}) async {
    var token = MPref.getString("AccessToken");
    // final response = await http.post(_baseUrl + url,
    //     headers: {
    //       "Authorization": 'Bearer ' + token,
    //       "Accept": "application/json"
    //     },
    //     body: body);

    try {
      var request = http.MultipartRequest('POST', Uri.parse(_baseUrl + url));
      request.fields["title"] = vm.title;
      request.fields["text"] = vm.text;
      for (var i = 0; i < vm.recipients.length; i++) {
        request.fields['recipients[$i]'] = vm.recipients[i].toString();
      }
      if (vm.ccRecipients != null && vm.ccRecipients.length > 0) {
        for (var i = 0; i < vm.ccRecipients.length; i++) {
          request.fields['cc_recipients[$i]'] = vm.ccRecipients[i].toString();
        }
      }

      if (vm.bccRecipients != null && vm.bccRecipients.length > 0) {
        for (var i = 0; i < vm.bccRecipients.length; i++) {
          request.fields['bcc_recipients[$i]'] = vm.bccRecipients[i].toString();
        }
      }

      request.headers.addAll(
          {"Authorization": 'Bearer ' + token, "Accept": "application/json"});

      request.files.add(http.MultipartFile.fromBytes(
          'attach', File(path).readAsBytesSync(),
          filename: path.split("/").last));

      var response = await request.send();

      return true;
    } catch (_) {
      return false;
    }

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

  Future<bool> postReplyWithFile(
      {String url, String path, MessageReplyViewModel vm}) async {
    var token = MPref.getString("AccessToken");
    // final response = await http.post(_baseUrl + url,
    //     headers: {
    //       "Authorization": 'Bearer ' + token,
    //       "Accept": "application/json"
    //     },
    //     body: body);

    try {
      var request = http.MultipartRequest('POST', Uri.parse(_baseUrl + url));
      request.fields["text"] = vm.text;
      // for (var i = 0; i < vm.recipients.length; i++) {
      //   request.fields['recipients[$i]'] = vm.recipients[i].toString();
      // }
      // if (vm.ccRecipients != null && vm.ccRecipients.length > 0) {
      //   for (var i = 0; i < vm.ccRecipients.length; i++) {
      //     request.fields['cc_recipients[$i]'] = vm.ccRecipients[i].toString();
      //   }
      // }

      // if (vm.bccRecipients != null && vm.bccRecipients.length > 0) {
      //   for (var i = 0; i < vm.bccRecipients.length; i++) {
      //     request.fields['bcc_recipients[$i]'] = vm.bccRecipients[i].toString();
      //   }
      // }

      request.headers.addAll(
          {"Authorization": 'Bearer ' + token, "Accept": "application/json"});

      request.files.add(http.MultipartFile.fromBytes(
          'attach', File(path).readAsBytesSync(),
          filename: path.split("/").last));

      var response = await request.send();

      return true;
    } catch (_) {
      return false;
    }

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

  Future<bool> postForwardWithFile(
      {String url, String path, MessageForwardViewModel vm}) async {
    var token = MPref.getString("AccessToken");
    // final response = await http.post(_baseUrl + url,
    //     headers: {
    //       "Authorization": 'Bearer ' + token,
    //       "Accept": "application/json"
    //     },
    //     body: body);

    try {
      var request = http.MultipartRequest('POST', Uri.parse(_baseUrl + url));

      request.fields["text"] = vm.text;
      for (var i = 0; i < vm.recipients.length; i++) {
        request.fields['recipients[$i]'] = vm.recipients[i].toString();
      }
      // if (vm.ccRecipients != null && vm.ccRecipients.length > 0) {
      //   for (var i = 0; i < vm.ccRecipients.length; i++) {
      //     request.fields['cc_recipients[$i]'] = vm.ccRecipients[i].toString();
      //   }
      // }

      // if (vm.bccRecipients != null && vm.bccRecipients.length > 0) {
      //   for (var i = 0; i < vm.bccRecipients.length; i++) {
      //     request.fields['bcc_recipients[$i]'] = vm.bccRecipients[i].toString();
      //   }
      // }

      request.headers.addAll(
          {"Authorization": 'Bearer ' + token, "Accept": "application/json"});

      request.files.add(http.MultipartFile.fromBytes(
          'attach', File(path).readAsBytesSync(),
          filename: path.split("/").last));

      var response = await request.send();

      return true;
    } catch (_) {
      return false;
    }

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
