import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class APIClient{
  APIClient._(){}
  static const _API_KEY = 'cbHnTR5GG1yY5SfYZph13kyId2vsgCsC';
  static final BASE_URL = 'https://api.giphy.com/v1/gifs/trending?api_key=$_API_KEY&limit=25&rating=g';

  static Future<http.Response> getTrendingGif(){
    Future<http.Response> future = http.get(Uri.parse(BASE_URL));
    return future;
  }
  
  static Future<Response> getSearchedGifByDio(String search){
    String _searchURL = '/v1/gifs/search?api_key=$_API_KEY&q=$search&limit=25&offset=0&rating=g&lang=en';
    String _baseURL = 'https://api.giphy.com';
    BaseOptions options = BaseOptions(
      baseUrl: _baseURL
     /* connectTimeout: 10000,
      receiveTimeout: 7000,*/
    );
    Dio dio = Dio(options);
    Future<Response> searchedFuture = dio.get(_searchURL);
   // print('object');
    print(searchedFuture);
    return searchedFuture;
  }

  static Future<http.Response> getSearchedGif(String search){
    String _searchURL = 'https://api.giphy.com/v1/gifs/search?api_key=$_API_KEY&q=$search&limit=25&offset=0&rating=g&lang=en';
    Future<http.Response> searchFuture = http.get(Uri.parse(_searchURL));
    return searchFuture;
  }

}