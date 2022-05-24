import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:viking_game/utilities/constants.dart';
import 'package:viking_game/utilities/custom_exception.dart';
import 'package:viking_game/utilities/sharedpref.dart';

class DIOClient {
  static Dio getHttpClient() {
    var dio = Dio();
    dio.transformer = new DIOFlutterTransformer();
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      SharedPrefrencesHelper.getToken().then((_token) {
        if (_token != "") {
          options.headers['Authorization'] = 'Bearer $_token';
        }
      });
      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onResponse: (response, handler) {
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onError: (DioError e, handler) {
      // Do something with response error
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));

    return dio;
  }
}

class HTTPHelper {
  static Future<dynamic> getRequest(
      String url, Map<String, dynamic>? query) async {
    try {
      final response = await DIOClient.getHttpClient()
          .get('${apiUrl}${url}', queryParameters: query);
      if (response.statusCode == 200) {
        final responseJson = response.data;
        return responseJson;
      }
    } on DioError catch (e) {
      throw CustomException(
          message: '${e.response!.data["message"]}',
          statusCode: e.response!.statusCode);
    }
  }

  static Future<dynamic> getAbsoluteUrlRequest(String url) async {
    try {
      final response = await DIOClient.getHttpClient().get(url);
      if (response.statusCode == 200) {
        final responseJson = response.data;
        return responseJson;
      }
    } on DioError catch (e) {
      throw CustomException(
          message: '${e.response!.data["message"]}',
          statusCode: e.response!.statusCode);
    }
  }

  static Future<List<dynamic>?> getListRequest(
      String url, dynamic outputConverter) async {
    try {
      final response = await DIOClient.getHttpClient().get('${apiUrl}${url}');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => outputConverter.fromJson(e))
            .toList();
      }
    } on DioError catch (e) {
      throw CustomException(
          message: '${e.response!.data["message"]}',
          statusCode: e.response!.statusCode);
    }
  }

  static Future<dynamic> postRequest(String url, dynamic body) async {
    try {
      final response =
          await DIOClient.getHttpClient().post('${apiUrl}${url}', data: body);
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        throw CustomException(
            message: '${e.response!.data["message"]}',
            statusCode: e.response!.statusCode);
      } else {
        throw CustomException(
            message: 'Error while processing the request',
            statusCode: errorCode);
      }
    }
  }

  static Future<dynamic> patchRequest(String url, dynamic body) async {
    try {
      final response =
          await DIOClient.getHttpClient().patch('${apiUrl}${url}', data: body);
      return response.data;
    } on DioError catch (e) {
      throw CustomException(
          message: '${e.response!.data["message"]}',
          statusCode: e.response!.statusCode);
    }
  }

  static Future<dynamic> putRequest(String url, dynamic body) async {
    try {
      final response =
          await DIOClient.getHttpClient().put('${apiUrl}${url}', data: body);
      return response.data;
    } on DioError catch (e) {
      throw CustomException(
          message: '${e.response!.data["message"]}',
          statusCode: e.response!.statusCode);
    }
  }

  static Future<dynamic> deleteRequest(
      String url, dynamic data, Map<String, dynamic> queryParameters) async {
    try {
      final response = await DIOClient.getHttpClient().delete('${apiUrl}${url}',
          queryParameters: queryParameters, data: data);
      return response.data;
    } on DioError catch (e) {
      throw CustomException(
          message: '${e.response!.data['message']}',
          statusCode: e.response!.statusCode);
    }
  }
}

class DIOFlutterTransformer extends DefaultTransformer {
  DIOFlutterTransformer() : super(jsonDecodeCallback: _parseJson);
}

// Must be top-level function
_parseAndDecode(String response) {
  return jsonDecode(response);
}

_parseJson(String text) {
  return compute(_parseAndDecode, text);
}
