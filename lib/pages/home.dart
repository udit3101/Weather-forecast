import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:flutter/src/widgets/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:http/http.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    super.initState();

    print("this is init state running");
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print("set state called");
  }

  @override
  Widget build(BuildContext context) {
    Map info = {};
    info = ModalRoute.of(context)?.settings.arguments as Map;

    String temp = (info['temp_value']).toString();

    if (temp == "NA") {
      print("NA");
    } else {
      temp = (info['temp_value']).toString().substring(0, 4);
    }
    String icon = info["icon_value"];

    var city_name = [
      "Mumbai",
      "Delhi",
      "Indore",
      "Jaipur",
      "bhopal",
      "ahemdabad"
    ];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];
    String getcity = info["city_value"];
    String hum = info["hum_value"];

    String air = (info["airspeed_value"]).toString();
    if (temp == "NA") {
      print("NA");
    } else {
      air = (info['airspeed_value']).toString().substring(0, 4);
    }
    String des = info["des_value"];

    return Scaffold(
        //appBar: PreferredSize(
        //preferredSize: Size.fromHeight(0),
        //child: AppBar(
        // backgroundColor: Colors.red,
        //),
        //),
        //
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: GradientAppBar(
            gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.lightBlueAccent, Colors.blueGrey])),
              child: Column(children: [
                Container(
                  //seatrch box

                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),

                  child: Row(children: [
                    GestureDetector(
                      onTap: () {
                        if ((searchController.text).replaceAll(" ", "") == "") {
                          print("Blank Search");
                        } else {
                          Navigator.pushReplacementNamed(context, "/loading",
                              arguments: {"searchText": searchController.text});
                        }
                      },
                      child: Container(
                        child: Icon(Icons.search),
                        margin: EdgeInsets.fromLTRB(2, 0, 5, 0),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Search $city"),
                    ))
                  ]),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white.withOpacity(0.5)),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Image.network(
                                "https://openweathermap.org/img/wn/10d@2x.png",
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "$des",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "In $getcity",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          )),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white.withOpacity(0.5)),
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        padding: EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.thermometer),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "$temp",
                                    style: TextStyle(
                                      fontSize: 95,
                                    ),
                                  ),
                                  Text(
                                    "C",
                                    style: TextStyle(
                                      fontSize: 40,
                                    ),
                                  )
                                ],
                              )
                            ]),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        padding: EdgeInsets.all(20),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.day_windy),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "$air",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "km/hr",
                            style: TextStyle(fontSize: 15),
                          )
                        ]),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        padding: EdgeInsets.all(20),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.humidity),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "$hum",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Percent",
                            style: TextStyle(fontSize: 15),
                          )
                        ]),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(40),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Made by Udit"),
                        Text("Data provided by Openweather.org")
                      ]),
                )
              ]),
            ),
          ),
        ));
  }
}
