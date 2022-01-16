import 'package:bookmyshow/models/movie_content_model.dart';
import 'package:bookmyshow/models/movie_content_operations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  _createAppBar() {
    return AppBar(
      backgroundColor: Colors.black45,
      leading: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
      centerTitle: true,
      title: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.red),
            padding: const EdgeInsets.all(10),
            child: const Text(
              'NOW SHOWING',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.black26, borderRadius: BorderRadius.circular(10)),
            child: const Text(
              'COMING SOON',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
      actions: [
        Container(
            padding: const EdgeInsets.only(right: 5),
            child: const Icon(
              Icons.location_on,
              color: Colors.white,
            ))
      ],
    );
  }

  _createContainer() {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.topic,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'All Languages',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.image,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Cinemas',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _createRatingsUI(MovieContent content) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 100,
      height: 65,
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: Icon(
                  Icons.wb_sunny,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  flex: 2,
                  child: Text(
                    content.ratings,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ))
            ],
          ),
          Text(
            content.totalVotes,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  _addingData() {
    List<MovieContent> contentList = MovieContentOperations.dataList;
    List<Widget> widgetList = [];
    contentList.map((content) {
      widgetList.add(_createContentUI(content));
    }).toList();
    return widgetList;
  }

  _createContentUI(MovieContent content) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                content.imageURL,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.green,
                  child: const Text(
                    'NEW',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.0),
                  ),
                  child: Text(
                    content.certificate,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: _createRatingsUI(content),
              ),
            ],
          ),
          ListTile(
            title: Text(
              content.movieName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Text(
                  content.language,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  width: 4,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey)),
                  child: Text(
                    content.quality,
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.red),
              child: const Text(
                'BOOK',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: _createAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _createContainer(),
            Column(
              children: _addingData(),
            ),
          ],
        ),
      ),
    );
  }
}
