import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          headers: {'Content-Type': 'application/json'}),
    );
  }

  static Future<Response> postData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {

    dio.options.headers = {
      'lang' : lang,
      'Authorization' : token,

    };
    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }
}