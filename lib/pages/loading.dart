import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/worker/worker.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String? city = "Indore";

  String? temps;
  String? hum;
  String? airspeed;
  String? des;
  String? main;
  String? icon;

  void Startapp(String? city) async {
    worker instance = worker(location: city);
    await instance.getData();

    temps = instance.temp.toString();
    hum = instance.humidity.toString();
    airspeed = instance.air_speed.toString();
    des = instance.description.toString();
    main = instance.main.toString();
    icon = instance.icon;

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/home', arguments: {
        "temp_value": temps,
        "hum_value": hum,
        "airspeed_value": airspeed,
        "des_value": des,
        "main_value": main,
        "icon_value": icon,
        "city_value": city
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map search = ModalRoute.of(context)?.settings.arguments as Map;

    if (search?.isNotEmpty ?? false) {
      city = search["searchText"];
    }
    Startapp(city);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 250,
                ),
                Image.asset(
                  "images/rean.jpeg",
                ),
                Text(
                  "Mausam App",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Made By Udit",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 40,
                ),
                SpinKitWave(
                  color: Colors.blue,
                  size: 50,
                )
              ]),
        ),
      ),
      backgroundColor: Colors.blue[300],
    );
  }
}
