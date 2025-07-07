import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class ApiManager {
  static late Dio dio;

  static void init() {
    dio = Dio(BaseOptions(
      baseUrl: Constants.baseURL,
      receiveDataWhenStatusError: true,
    ));
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ));
  }

  Future<Response> postDate({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.post(
        endPoint,
        data: data,
        options: Options(headers: headers),
      );
    } catch (e) {
      print('Error occurred: $e');
      rethrow;
    }
  }

   Future<Response> getData({
    required String endPoint,
     Map<String, dynamic>? query,
     Map<String, dynamic>? data,
     Map<String, dynamic>? headers,

  }) {
    return dio.get(endPoint, queryParameters: query,
      data: data,
      options: Options(headers: headers),
    );
  }

  Future<Response> putData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.put(
        endPoint,
        data: data,
        options: Options(headers: headers),
      );
    } catch (e) {
      print('PUT Error: $e');
      rethrow;
    }
  }

  Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.delete(
        endPoint,
        data: data,
        options: Options(headers: headers),
      );
    } catch (e) {
      print('DELETE Error: $e');
      rethrow;
    }
  }
}
