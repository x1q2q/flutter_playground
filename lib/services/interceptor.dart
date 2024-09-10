import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  String? _token;
  DateTime? _tokenExpiry;
  final DioService network = DioService();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_token == null || _isTokenExpired()) {
      Map<String, dynamic> token = await network.refreshToken();
      _token = token["token"];
      _tokenExpiry = token["token_expiry"];
    }
    options.headers['Authorization'] = 'Bearer $_token';
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // if token expired
    if (err.response?.statusCode == 401) {
      Map<String, dynamic> token = await network.refreshToken();
      _token = token["token"];
      _tokenExpiry = token["token_expiry"];
      final requestOptions = err.requestOptions;
      requestOptions.headers['Authorization'] = 'Bearer $_token';

      try {
        final Dio dio = Dio();
        final resp = await dio.fetch(requestOptions);
        return handler.resolve(resp);
      } on DioException catch (e) {
        return handler.reject(e);
      }
    } else {
      return handler.next(err);
    }
  }

  bool _isTokenExpired() {
    if (_tokenExpiry == null) return true;
    return DateTime.now().isAfter(_tokenExpiry!);
  }
}

class DioService {
  final Dio dio;

  DioService() : dio = Dio() {
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
  }
  Future<Map<String, dynamic>> refreshToken() async {
    final resp = await dio.post('https://accounts.spotify.com/api/token/',
        data: {
          'grant_type': 'client_credentials',
          'client_id': '6fd09be5cccc4a19a368e2a37d8326bf',
          'client_secret': '85a078c158b24c99ab02be4480de413b'
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
    if (resp.statusCode == 200) {
      final Map result = Map.from(resp.data);
      return {
        "token": result['access_token'],
        "token_expiry":
            DateTime.now().add(Duration(seconds: result['expires_in'] ?? 3600))
      };
    } else {
      throw Exception('Failed to fetch token');
    }
  }
}
