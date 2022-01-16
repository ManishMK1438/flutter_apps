

import 'package:spotify_app_final/models/category.dart';

class CategoryOperations {
  CategoryOperations._();
  static List<Category> getCategories() {
    return <Category>[
      Category(
        title: 'Top Songs',
        image: 'https://is1-ssl.mzstatic.com/image/thumb/Purple123/v4/0e/09/c4/0e09c462-c0cd-0a6c-d748-ea69b70442b7/source/256x256bb.jpg',
      ),
      Category(
        title: 'MJ Hits',
        image: 'https://is1-ssl.mzstatic.com/image/thumb/Purple71/v4/d1/ba/85/d1ba8582-972e-7e02-6f3b-cc47adfc055f/source/256x256bb.jpg',
      ),
      Category(
        title: 'Smile',
        image: 'https://c-cl.cdn.smule.com/rs-s78/arr/30/d7/5a82d9ae-9589-443c-b950-25c139abae89_256.jpg',
      ),
      Category(
        title: 'Rock Band',
        image: 'https://images.genius.com/af067ceaade20726f2b85176ff8dc6e8.256x256x1.jpg',
      ),
      Category(
        title: 'Kishore',
        image: 'https://c-cl.cdn.smule.com/rs-s78/arr/f5/4e/27b764f1-91f2-41e7-934a-5bedf8b1751a.jpg',
      ),
      Category(
        title: 'Rafi',
        image: 'https://c-cl.cdn.smule.com/rs-s80/arr/56/f6/798ae822-373f-402a-a010-f7c60d0fd214.jpg',
      )
    ];
  }
}
