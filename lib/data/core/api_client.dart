import 'dart:convert';
import 'dart:io';
//import 'package:dio/dio.dart';
//import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'api_constants.dart';
import 'unathorised_exception.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  ///using Dio
  /*
  final Dio _dio;

  ApiClient(this._dio) {
    _dio.options.baseUrl = ApiConstants.BASE_URL;
    _dio.options.headers = {'Content-Type': 'application/json'};

    // Bypass SSL certificate validation
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: {'api_key': ApiConstants.API_KEY, ...?params},
      );

      return response.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        //throw UnauthorizedException();
        throw Exception(e.response?.statusMessage ?? 'Unauthorized');
      } else {
        throw Exception(e.response?.statusMessage ?? 'Unknown error');
      }
    }
  }
  */

  ///using http
/*
  late HttpClient _clientHttp;
  late IOClient _ioClient;
  ApiClient(this._client) {
    // Configure HttpClient to ignore SSL certificate issues
    _clientHttp = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    _ioClient = IOClient(_clientHttp);
  }

  dynamic get(String path, {Map<dynamic, dynamic>? params}) async {
    await Future.delayed(Duration(milliseconds: 500));
    final response = await _ioClient.get(
      getPath(path, params),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  } */


  dynamic get(String path, {Map<dynamic, dynamic>? params}) async {
    await Future.delayed(Duration(milliseconds: 500));
    final response = await _client.get(
      getPath(path, params),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }


  dynamic post(String path, {Map<dynamic, dynamic>? params}) async {
    final response = await _client.post(
      getPath(path, null),
      body: jsonEncode(params),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic deleteWithBody(String path, {Map<dynamic, dynamic>? params}) async {
    Request request = Request('DELETE', getPath(path, null));
    request.headers['Content-Type'] = 'application/json';
    request.body = jsonEncode(params);
    final response = await _client.send(request).then(
          (value) => Response.fromStream(value),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Uri getPath(String path, Map<dynamic, dynamic>? params) {
    var paramsString = '';
    if (params?.isNotEmpty ?? false) {
      params?.forEach((key, value) {
        paramsString += '&$key=$value';
      });
    }

    debugPrint('url : ${'${ApiConstants.BASE_URL}$path?api_key=${ApiConstants.API_KEY}$paramsString'}');

    return Uri.parse(
        '${ApiConstants.BASE_URL}$path?api_key=${ApiConstants.API_KEY}$paramsString');
  }

}