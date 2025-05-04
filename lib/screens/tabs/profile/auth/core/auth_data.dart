import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/*
class AuthData {
  Dio dio = Dio();
  register(
      {required password,
        required email,
        required name,
        required BuildContext context}) async {
    try {
      var response =
      await dio.post( '', data: {
        "name": name,
        "email": email,
        "password": password,
      });
      ProfileResponse authResponse = ProfileResponse.fromJson(response.data);

      print(
          "Response: ${response.data}=======================================");
      return authResponse;
    } on DioException catch (error)
    {
      print(error.response?.data);
      print("-------------------------------------------------------------");
      return error.response?.data;

    }
    ;
  }

  registerSignIn({
    required password,
    required email,
  }) async {
    try {
      var response =
      await dio.post('', data: {
        "email": email,
        "password": password,
      });
      ProfileResponse authResponse = ProfileResponse.fromJson(response.data);

      print(
          "Response: ${response.data}=======================================");
      return authResponse;
    } on DioException catch (error) {
      if (error.response == null) {
        print(error.response?.data);
        print("-------------------------------------------------------------");
        return error.response?.data;
      }
    }
    ;
  }
}
*/
