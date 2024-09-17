import 'package:dio/dio.dart';
import 'interceptor.dart';

class NetworkService {
  final Dio dio;

  NetworkService() : dio = Dio() {
    dio.options.baseUrl = "https://api.spotify.com/v1/";
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.interceptors.add(AuthInterceptor());
  }

  Future<Response> fetchData(String endpoint) async {
    try {
      final response = await dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw Exception(e.response!.data['message']);
        } else {
          throw Exception('Failed to update data: ${e.response!.data}');
        }
      } else {
        throw Exception('Failed to fetch data: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
