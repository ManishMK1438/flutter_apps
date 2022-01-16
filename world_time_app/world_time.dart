import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time;
  String url;
  String flag;
  bool isDayTime;

  WorldTime({this.location, this.url, this.flag});

  Future<void> getTime() async {
    try{
      // Making a request to get time.
      Response response = await get("http://worldtimeapi.org/api/timezone/$url");
      Map data = jsonDecode(response.body);
      //print(data);

      // Get properties from the received data.
      String dateTime = data["datetime"];
      //print(dateTime);
      String offset = data["utc_offset"].substring(1,3);
      //print(offset);
      String offset1 = data["utc_offset"].substring(4,6);
      //print(offset1);

      // Formatting Datetime
      DateTime currentTime = DateTime.parse(dateTime);
      currentTime = currentTime.add(Duration(hours: int.parse(offset), minutes: int.parse(offset1)));
      //print(currentTime);

      isDayTime = currentTime.hour > 4 && currentTime.hour < 20 ? true : false ;
      time = DateFormat.jm().format(currentTime);

    }catch(exception){
      print("ERROR OCCURRED: $exception");
      time = "Something went wrong. Please try again.";
    }

  }

}