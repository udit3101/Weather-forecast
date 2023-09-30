import 'package:http/http.dart';
import 'dart:convert';

class worker {
  String? location;
  worker({this.location}) {
    location = this.location;
  }

  String? temp;
  String? humidity;
  String? air_speed;
  String? description;
  String? main;
  String? icon;
  Future<void> getData() async {
    try {
      final url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=aae19da38ae287f5559eb7278d399fee");
      Response response = await get(url);
      Map data = jsonDecode(response.body);

      Map temp_data = data['main'];
      Map wind = data['wind'];
      double getair_speed = wind['speed'] / 0.27777777777778;
      double gettemp = temp_data['temp'] - 273.15;
      double gethumidity = temp_data['humidity'];

      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getmain_des = weather_main_data['main'];
      String getdesc = weather_main_data['description'];

      temp = gettemp.toString();
      humidity = gethumidity.toString();
      air_speed = getair_speed.toString();
      description = getdesc;
      main = getmain_des;
      String icon = weather_main_data["icon"].toString();
    } catch (e) {
      temp = "NA ";
      humidity = "NA";
      air_speed = "NA";
      description = 'kya dekhega re';
      main = "NA";
      icon = "03n";
    }
  }
}
