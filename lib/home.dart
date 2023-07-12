import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool loding=true;

 late WeatherInfo weather;
 @override
  void initState() {
   getweatherdata('London').then((value) {
     setState(() {
       loding=false;
     });
   });

    super.initState();
  }

  Future<void>getweatherdata(String cityname)async{
    weather=await WeatherInfo.fetchWeatherInfo(cityname) as WeatherInfo;
    print(weather.cityName);
    print(weather.temperature);
    print(weather);


  }



  // void _showOptionsDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Choose Option'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextFormField(
  //               decoration: InputDecoration(
  //                 hintText: 'Location',
  //                 border: OutlineInputBorder(),
  //                 focusedBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: Colors.yellowAccent),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               width: double.infinity,
  //               child: Center(
  //                 child: ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: Colors.white,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(20),
  //                     ),
  //                     padding: EdgeInsets.all(16),
  //                     fixedSize: Size(200, 50),
  //                   ),
  //                   onPressed: () {
  //                     // Fetch weather data and update the state
  //                     fetchWeatherData();
  //                   },
  //                   child: Text('Search'),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.green,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: Stack(
        children: [
          backscreen(context),
          weathericon(context),
          loding == false?
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                     '${weather.temperature.toStringAsFixed(0)}°',
                    style: TextStyle(fontSize: 46, fontWeight: FontWeight.bold),
                  ),
                  Text(
                      '${weather.cityName}',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Image.network("http://openweathermap.org/img/w/${weather.icon}.png")
                ],
              ),
            ),
          ):Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _showOptionsDialog,
      //   child: Icon(Icons.search),
      // ),
    );
  }
}

SvgPicture backscreen(context) {
  return SvgPicture.asset(
    'asset/img/landscape2.svg',
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    fit: BoxFit.cover,
  );
}

SvgPicture weathericon(context) {
  return SvgPicture.asset(
    'asset/img/icons.svg',
    alignment: Alignment.center,
    width: 200,
    height: 200,
  );
}
