import 'package:dio/dio.dart';

class Logging extends Interceptor{



  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(err);
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {

  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

  }
}