import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:giphy_app/conversion/conversion.dart';
import 'package:giphy_app/models/gif.dart';
import 'package:giphy_app/utils/api_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json_convert;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GIF> gifList = [];
  List<GIF> searchList = [];

  TextEditingController _controller = TextEditingController();

  bool _isSearching = false;

  @override
  void initState() {
    super.initState();


    Future<http.Response> future = APIClient.getTrendingGif();
    String responseBody;
    future.then((response) {
      responseBody = response.body;
      var data = json_convert.jsonDecode(responseBody);
      final listOfGif = data['data'] as List;
     final List<GIF> list = listOfGif.map((gif) => GIF.fromJson(gif)).toList();

      setState(() {
        gifList = list;
      });

      /* widgetList = list.map((gif) => Card(
        child: Column(
          children: [
            Image.network(gif['images']['original']['url']),
            ListTile(
              title: Text(gif['title']),
            ),
          ],
        ),
      )

      ).toList();*/
      /* setState(() {
      });*/
    }).catchError((err) => print('ERROR: $err'));
  }
/*
  _searchGIF(){

      _isSearching = true;
      Future<http.Response> future = APIClient.getTrendingGif();
      String responseBody;
      future.then((response) {
        responseBody = response.body;
        var data = json_convert.jsonDecode(responseBody);
        final listOfGif = data['data'] as List;
        final List<GIF> list = listOfGif.map((gif) => GIF.fromJson(gif)).toList();

        setState(() {
          searchList = list;
        });
        print(searchList);

      }).catchError((err) => print('ERROR: $err'));

  }*/

  List <Widget> _createList(List<GIF> gifList){
    List<Widget> trendingList = [];
     gifList
        .map((gif) {
          trendingList.add(Card(
            child: Column(
              children: [
                Image.network(gif.url),
                ListTile(
                  title: Text(gif.title),
                ),
              ],
            ),
          ));
     }).toList();
     return trendingList;
  }

  _searchGIF(){

    Future<Response> data = APIClient.getSearchedGifByDio(_controller.text);
    dynamic responseBody;
     data.then((response) {
      // print(response);
        responseBody = response.data;
        print(responseBody);
        print(responseBody.runtimeType);
  //      var data = json_convert.jsonDecode(responseBody);
        final List<dynamic> listOfGif = responseBody ['data'];
       /* print(listOfGif);
        print(listOfGif.runtimeType);*/
        final List<GIF> list = listOfGif.map((gif) => GIF.fromJson(gif)).toList();

        setState(() {
          searchList = list;
        });
    }).catchError((error){
      print('ERROR here: $error');
    });
/*
    Future<http.Response> data = APIClient.getSearchedGif(_controller.text);
    data.then((response){
      print(response);
      var data = json_convert.jsonDecode(response.body);
      print(data);
      final listOfGif = data['data'] as List;
      final List<GIF> list = listOfGif.map((gif) => GIF.fromJson(gif)).toList();
      setState(() {
        searchList = list;
      });

    }).catchError((onError){
      print('ERROR: $onError');
    });*/

    }

  _createAppBar() {
    return AppBar(
      backgroundColor: Colors.brown,
      title:  _isSearching? TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Search...',hintStyle: TextStyle(color: Colors.white)
        ),
      )
          :const Text(
        'GIPHY',
        style: TextStyle(color: Colors.white),
      ),
      actions:  _isSearching? [
        IconButton(
          onPressed: () {
           setState(() {
             _isSearching = false;
             _controller.clear();
             searchList.clear();
           });
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ), IconButton(
          onPressed: () {
            _isSearching = true;
            _searchGIF();

          },
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ]
          :[
        IconButton(
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: _isSearching == false
            ? Column(
                children: _createList(gifList)
              ):Column(
            children: _createList(searchList)
        )
      )),
    );
  }
}
