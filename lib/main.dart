import 'package:flutter/material.dart';
import 'package:weather/pages/home.dart';
import 'package:weather/pages/loaction.dart';
import 'package:weather/pages/loading.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      "/": (context) => Loading(),
      "/home": (context) => Home(),
      "/loading": (context) => Loading()
    },
  ));
}
