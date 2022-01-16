import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title:
              Container(width: 150.0, child: Text(_routeArgs['productName'])),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.grey,
                  constraints: BoxConstraints(
                    minHeight: 200.0,
                    minWidth: double.infinity
                  ),
                    child: Image.network(_routeArgs['url']),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.green,
                        child: Text(
                          _routeArgs['price'],
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                      Text(
                        _routeArgs['productName'],
                        style: TextStyle(
                          fontSize: 25,
                        ),
                        //overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Category: ' + _routeArgs['category'],
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _routeArgs['description'] +
                            'jwhef n  v cvaw ccc i dcicicn ic j c c icOB CC   C    CBCBCBISBbkb wiv sb bfvk bbfvj v',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Add to cart'),
                  )),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('BUY NOW'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
