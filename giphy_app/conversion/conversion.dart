import 'dart:convert' as jsonconvert;

import 'package:giphy_app/models/gif.dart';
class Conversion {
  Conversion._() {}
  static dynamic convertJSONTOObject(String responseBody, String key) {
    var map = jsonconvert.jsonDecode(responseBody);
    return map[key];
  }

 /* static List<GIF> convertGIFObjects(List list) {
    return list.map((obj) => GIF.mapToObject(obj)).toList();
  }*/
}
