import 'package:dio/dio.dart';

class APIClient{
  APIClient._(){}

  static Future<Response> getUserDetailsByDIO({required String token, required String userID}) {
    String _baseURL ='https://graph.facebook.com';
    String _searchURL =
    "https://graph.facebook.com/v12.0/$userID?fields=id%2Cname%2Cemail%2Cpicture.height(961)&access_token=$token";
    BaseOptions options = BaseOptions(
      baseUrl: _baseURL,
    );
    Dio dio = Dio(options);
    Future<Response> searchedFuture =  dio.get(_searchURL);
    print('SEARCHED FUTURE IS $searchedFuture');
    return searchedFuture;


  }

}