import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class ApiManager {
  static late Dio dio;

  static void init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://accept.paymob.com",
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

  static Future<Response> getData(
      {required String endPoint, required Map<String, dynamic> query}) {
    return dio.get(endPoint, queryParameters: query);
  }
}
