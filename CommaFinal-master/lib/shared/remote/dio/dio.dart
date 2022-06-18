import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
        BaseOptions(
      baseUrl: "http://home.ahmedfarestech.tk/api/",
      receiveDataWhenStatusError: true,
        headers: {
          'Accept':'application/json',
          'Accept-Language' : 'en'
        }
    ));
  }

  static Future<Response> getData({
    @required String? url,
    @required Map<String, dynamic>? query,
    String? token
  }) async {
       dio!.options.headers = {
         'Accept':'application/json',
          'Accept-Language' : 'en',
         'Authorization': 'Bearer $token',
       };

    return await dio!.get(url!, queryParameters: query,);
  }
  static Future<Response> postData({@required url,@required Map<String, dynamic>? query, token, data})async{
      dio!.options.headers = {
        'Accept':'application/json',
        'Authorization': 'Bearer $token',
        'Accept-Language' : 'en'
      };
    return await dio!.post(url, queryParameters: query, data: data);
  }
  static Future<dynamic> uploadFile({File? file, url, token}) async {
    dio!.options.headers = {
      'Accept':'application/json',
      'Content-Type': 'multipart/form-data‏',
      'Authorization': 'Bearer $token',
      'Accept-Language' : 'en'
    };
    var fileName = file!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "user_matrial[]": await MultipartFile.fromFile(file.path, filename:fileName),
    });
    var response = await dio!.post(url, data: formData);
    return response.data;
  }

  static Future<dynamic> uploadResearch({File? file, url, token}) async {
    dio!.options.headers = {
      'Accept':'application/json',
      'Content-Type': 'multipart/form-data‏',
      'Authorization': 'Bearer $token',
      'Accept-Language' : 'en'
    };
    var fileName = file!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "resarches[]": await MultipartFile.fromFile(file.path, filename:fileName),
    });
    var response = await dio!.post(url, data: formData);
    return response.data;
  }
  static Future<dynamic> uploadCv({File? file, url, token}) async {
    dio!.options.headers = {
      'Accept':'application/json',
      'Content-Type': 'multipart/form-data‏',
      'Authorization': 'Bearer $token',
      'Accept-Language' : 'en'
    };
    var fileName = file!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "cv[]": await MultipartFile.fromFile(file.path, filename:fileName),
    });
    var response = await dio!.post(url, data: formData);
    return response.data;
  }

}
