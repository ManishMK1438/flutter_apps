import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  String bgImage;


  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    //print(data);
    try {
       bgImage = data["isDayTime"] ? "day2.jpg" : "night.jpg";

    }catch(e){
      print(e);
    }
    Color getBgColor(){
      if(bgImage == "day2.jpg"){
        return Colors.white;
      }else{
        return Colors.blue[900];
      }
    }

    Color getColor(){

      if(bgImage == "day2.jpg"){
        return Colors.black;
      }else{
        return Colors.white;
      }
    }

    return Scaffold(
      backgroundColor: getBgColor(),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/$bgImage"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Column(
              children: [
                FlatButton.icon(
                    onPressed: () async{
                      dynamic result = await Navigator.pushNamed(context, "/location");

                      setState(() {
                        data = {
                          "time": result["time"],
                          "location": result["location"],
                          "flag": result["flag"],
                          "isDayTime": result["isDayTime"]
                        };
                      });
                    },
                    icon: Icon(Icons.edit_location, color: getColor()),
                    label: Text(
                        "Edit Location",
                      style: TextStyle(
                        color: getColor(),
                      ),
                    )),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        data["location"],
                      style: TextStyle(
                        fontSize: 30,
                        letterSpacing: 3,
                        color: getColor(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Text(
                    data["time"],
                  style: TextStyle(
                    fontSize: 50,
                    color: getColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
    ),
    );
  }
}
