import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify_app_final/models/category.dart';
import 'package:spotify_app_final/models/music.dart';
import 'package:spotify_app_final/services/category_operations.dart';
import 'package:spotify_app_final/services/music_operations.dart';

class Home extends StatelessWidget {
  final Function miniPlayer;
  const Home({Key? key, required this.miniPlayer}) : super(key: key);

  Widget createAppBar(String title) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget createCategories(Category category) {
    return Container(
      color: Colors.blueGrey,
      child: Row(
        children: [
          Image.network(category.image),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              category.title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> createListOfCategories() {
    List<Category> catList = CategoryOperations.getCategories();

    List<Widget> categories =
        catList.map((Category category) => createCategories(category)).toList();
    return categories;
  }

  Widget createGrid() {
    return Container(
      height: 280,
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 5 / 2,
        children: createListOfCategories(),
      ),
    );
  }

  Widget createMusicList(String label) {
    List<Music> _musicList = MusicOperations.getMusic();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _musicList.length,
            itemBuilder: (ctx, index) {
              return createMusic(_musicList[index]);
            },
          ),
        ),
      ],
    );
  }


  Widget createMusic(Music music) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              miniPlayer(music, stop: true );
            },
            child: Container(
                height: 200,
                width: 200,
                child: Image.network(
                  music.image,
                  fit: BoxFit.cover,
                )),
          ),
          Text(
            music.title,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            music.description,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey, Colors.black, Colors.black, Colors.blueGrey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.3,0.7,0.9],
            ),
          ),
          child: Column(
            children: [
              createAppBar('Good Morning'),
              createGrid(),
              createMusicList('For you'),
              createMusicList('Newly Added'),
            ],
          ),
        ),
      ),
    );
  }
}
