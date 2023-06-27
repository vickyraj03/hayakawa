import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hayakawa_new/config/data/perferences.dart';


class NetworkService {
  String baseUrl = 'https://www.hayakawa.in/app/';

 // final String _authToken ='8adGY/DFf7in185bt2ZHVys1wbshkDfFyuLNvl61n/6DOkY7D1mb74J7g/DDnKS+00Ow+Y+XQ6C/2/VFYjBE/g==yqgPIOLPekSYjRS6s3JgJg==';

  Future<dynamic> post(String _endpoint, String json) async {
    try {
      debugPrint('Api Post, url ${'$baseUrl$_endpoint---headers${{
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.accessControlAllowOriginHeader: '*',
        HttpHeaders.accessControlAllowMethodsHeader: "*"
      //  HttpHeaders.authorizationHeader: "Bearer $_authToken"
      }} ---body$json '}');
      final response = await http.post(Uri.parse(baseUrl + _endpoint),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.accessControlAllowOriginHeader: "*",
            HttpHeaders.accessControlAllowMethodsHeader: "*",
          //  HttpHeaders.authorizationHeader: "Bearer $_authToken"
          },
          body: json);
      var responseJson = _returnResponse(response);
      debugPrint('Api$responseJson');

      return responseJson;
    } on SocketException {
      debugPrint('OOPS POST  No net');
      throw FetchDataException(Preferences.getNetworkIssueMsg());
    }
  }


 Future<dynamic> postFromdata(String _endpoint, Map<String , dynamic> json) async {
    try {
      debugPrint('Api Post, url ${'$baseUrl$_endpoint---headers${{
      
      }} ---body$json '}');
      final response = await http.post(Uri.parse(baseUrl + _endpoint),
         
          body: json);
      var responseJson = _returnResponse(response);
      debugPrint('Api$responseJson');

      return responseJson;
    } on SocketException {
      debugPrint('OOPS POST  No net');
      throw FetchDataException(Preferences.getNetworkIssueMsg());
    }
  }

  Future<dynamic> get(String _endpoint, map) async {
    try {
        debugPrint('Api GET, url ${'$baseUrl$_endpoint---headers${{
      
      }} ---body$map '}');
      final response = await http.get(Uri.parse(baseUrl + _endpoint), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.accessControlAllowMethodsHeader: "*",
        HttpHeaders.accessControlAllowOriginHeader: "*",
      //  HttpHeaders.authorizationHeader: "Bearer $_authToken"
      }, 
      );
      var responseJson = _returnResponse(response);
      debugPrint('api get recieved!${responseJson}');
      return responseJson;
    } on SocketException {
      debugPrint('OOPS GET  No net');
      throw FetchDataException(Preferences.getNetworkIssueMsg());
    }
  }


Future<dynamic> postMultipartFile(String _endpoint, String json) async {
    try {
      var headers = {
      //  'Authorization': 'Bearer $_authToken',
        'Content-Type': 'multipart/form-data'
      };
      var request =
          http.MultipartRequest('POST', Uri.parse(baseUrl + _endpoint));
      request.headers.addAll(headers);
      request.fields.addAll({'FileName': json.split("/").last});
      request.files.add(await http.MultipartFile.fromPath('FileData', json));
      debugPrint('Api Post, url ${baseUrl + _endpoint + '---headers${{
          //  HttpHeaders.authorizationHeader: "Bearer $_authToken"
          }} ' + '---FileData $json ' + '---FileName ${json.split("/").last} '}');
      var res = await request.send();
      debugPrint('Api postMultipartFile Response : $res');
      return res.reasonPhrase;
    } on SocketException {
      debugPrint('OOPS POST  No net');
      //return "No Internet connection";
      throw FetchDataException(Preferences.getNetworkIssueMsg());
    }
  }

}

dynamic _returnResponse(http.Response response) {
  debugPrint('Api decode-- ${response.statusCode}');

  switch (response.statusCode) {
    case 200:
      if (kDebugMode) {
        log('Api Data -- ${response.body}');
      }
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 400:
      if (kDebugMode) {
        log('Api decode 400 -- ${response.body}');
      }
      throw BadRequestException(response.body.toString());
    case 401:
      if (kDebugMode) {
        log('Api decode 401 -- ${response.body}');
      }
      throw BadRequestException(response.body.toString());
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 359:
      throw HandshakeException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]) : super(message, "");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
  